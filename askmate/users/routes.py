from flask import Blueprint, render_template, url_for, redirect, request, flash
from flask_login import current_user, login_user, logout_user, login_required
from askmate import bcrypt
import askmate.data_manager as data_manager
from askmate.users.utils import save_picture
from askmate.users.forms import RegistrationForm, LoginForm, UpdateAccountForm

users = Blueprint('users', __name__)


@users.route("/register", methods=['GET', 'POST'])
def route_register():
    form = RegistrationForm()
    picture_file = 'default_user.jpg'

    if current_user.is_authenticated:
        return redirect(url_for('main.route_home'))

    if form.validate_on_submit():
        if form.picture.data:
            picture_file = save_picture(form.picture.data)

        hashed_password = bcrypt.generate_password_hash(form.password.data).decode('utf-8')
        new_user = {'user_name': form.username.data, 'email': form.email.data, 'password': hashed_password, 'picture': picture_file}
        data_manager.register_new_user(new_user=new_user)

        flash(f'Account created for {form.username.data}!', 'success')
        return redirect(url_for('users.route_login'))
    return render_template('register.html', form=form)


@users.route("/login", methods=['GET', 'POST'])
def route_login():
    form = LoginForm()

    if request.method == 'GET':
        if current_user.is_authenticated:
            return redirect(url_for('main.route_home'))

    elif request.method == 'POST' and form.validate_on_submit():
        user = data_manager.find_user_by_email(form.email.data)

        if user and bcrypt.check_password_hash(user.password, form.password.data):
            login_user(user, remember=form.remember.data)
            next_page = request.args.get('next')

            return redirect(next_page) if next_page else redirect(url_for('main.route_home'))
        else:
            flash('Login Unsuccessful. Please check email and password', 'danger')
            return redirect(url_for('users.route_login'))

    return render_template('login.html', form=form)


@users.route("/logout")
def route_logout():
    logout_user()
    return redirect(url_for('main.route_home'))


@users.route("/account", methods=['GET', 'POST'])
@login_required
def route_account():
    questions = data_manager.find_questions_by_user_id(user_id=current_user.user_id)
    answers_and_rel_data = data_manager.find_answers_and_all_related_by_user_id(user_id=current_user.user_id)
    comments_for_questions = data_manager.find_comments_for_questions_by_user_id(user_id=current_user.user_id)
    comments_for_answers = data_manager.find_comments_for_answers_by_user_id(user_id=current_user.user_id)

    return render_template('account.html', questions=questions,
                           comments_for_questions=comments_for_questions,
                           comments_for_answers=comments_for_answers,
                           answers_and_rel_data=answers_and_rel_data
                           )


@users.route("/update_account", methods=['GET', 'POST'])
@login_required
def route_update_account():
    form = UpdateAccountForm()

    if request.method == 'GET':
        form.username.data = current_user.user_name
        form.email.data = current_user.email

    elif request.method == 'POST' and form.validate_on_submit():
        current_user.user_name = form.username.data
        current_user.email = form.email.data

        if form.picture.data:
            current_user.picture = save_picture(form.picture.data)

        if bcrypt.check_password_hash(current_user.password, form.password.data):
            data_manager.update_to_database()
            flash('Your account has been updated!', 'success')
            return redirect(url_for('users.route_account'))
        else:
            flash('wrong password', 'danger')

    return render_template('update_account.html', form=form)


@users.route("/users")
def route_users():
    order_direction = request.args.get('order_direction')
    switch_order_direction = data_manager.switch_asc_desc(order_direction)
    request_args = dict(request.args)
    print(request_args)
    users = data_manager.fetch_users(request_args)

    return render_template('users.html', users=users, asc_desc=switch_order_direction)


@users.route("/user/<int:user_id>")
def route_user(user_id):
    if current_user.is_authenticated and user_id == current_user.user_id:
        return redirect(url_for('users.route_account'))

    user = data_manager.find_user_by_id(user_id)

    return render_template('user.html', user=user)
