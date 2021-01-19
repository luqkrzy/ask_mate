from flask import render_template, url_for, flash, redirect, request
from askmate import app, bcrypt
from askmate.forms import RegistrationForm, LoginForm, UpdateAccountForm, QuestionForm
from flask_login import login_user, current_user, logout_user, login_required
from askmate import data_manager, datetime


@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404

@app.context_processor
def context_processor():
    return dict(tags= data_manager.count_tags())

@app.route("/")
@app.route("/home")
def route_home():
    questions = data_manager.fetch_all_questions()
    tag_name = data_manager.find_tag_name_by_id


    return render_template('home.html', questions=questions, find_tag_name=tag_name)


@app.route("/register", methods=['GET', 'POST'])
def route_register():
    form = RegistrationForm()
    picture_file = 'default_user.jpg'

    if current_user.is_authenticated:
        return redirect(url_for('route_home'))

    if form.validate_on_submit():
        if form.picture.data:
            picture_file = data_manager.save_picture(form.picture.data)

        hashed_password = bcrypt.generate_password_hash(form.password.data).decode('utf-8')
        new_user = {'user_name': form.username.data, 'email': form.email.data, 'password': hashed_password, 'picture': picture_file}
        data_manager.register_new_user(new_user=new_user)

        flash(f'Account created for {form.username.data}!', 'success')
        return redirect(url_for('route_login'))
    return render_template('register.html', form=form)


@app.route("/login", methods=['GET', 'POST'])
def route_login():
    form = LoginForm()

    if request.method == 'GET':
        if current_user.is_authenticated:
            return redirect(url_for('route_home'))

    elif request.method == 'POST' and form.validate_on_submit():
        user = data_manager.find_user_by_email(form.email.data)

        if user and bcrypt.check_password_hash(user.password, form.password.data):
            login_user(user, remember=form.remember.data)
            next_page = request.args.get('next')
            return redirect(next_page) if next_page else redirect(url_for('route_home'))
        else:
            flash('Login Unsuccessful. Please check email and password', 'danger')
            return redirect(url_for('route_login'))

    return render_template('login.html', form=form)


@app.route("/logout")
def route_logout():
    logout_user()
    return redirect(url_for('route_home'))


@app.route("/account", methods=['GET', 'POST'])
@login_required
def route_account():
    return render_template('account.html')


@app.route("/update_account", methods=['GET', 'POST'])
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
            current_user.picture = data_manager.save_picture(form.picture.data)

        if bcrypt.check_password_hash(current_user.password, form.password.data):
            data_manager.update_to_database()
            flash('Your account has been updated!', 'success')
            return redirect(url_for('route_account'))
        else:
            flash('wrong password', 'danger')

    return render_template('update_account.html', form=form)


@app.route('/question', methods=['GET', 'POST'])
@login_required
def route_add_question():
    form = QuestionForm()
    picture_file = 'default_question.png'

    if form.validate_on_submit():
        if form.image.data:
            picture_file = data_manager.save_picture(form.image.data)
        new_question = {'user_id': current_user.user_id, 'title': form.title.data, 'message': form.message.data, 'image': picture_file, 'tag_id': form.tag_name.data.tag_id}
        print(new_question)

        data_manager.ask_new_question(new_question)
        flash('Question posted ', 'success')
        return redirect(url_for('route_login'))

    return render_template("question.html", form=form)


@app.route('/question/<int:question_id>', methods=['GET', 'POST'])
@login_required
def route_edit_question(question_id):
    form = QuestionForm()
    question = data_manager.find_question_by_id(question_id)
    question_tag = data_manager.find_question_tag_by_id(question_id)
    picture_file = 'default_question.png'

    if request.method == 'GET':
        form.title.data = question.title
        form.message.data = question.message
        form.tag_name.data = question.tag_id


    elif form.validate_on_submit():
        if form.image.data:
            picture_file = data_manager.save_picture(form.image.data)
            current_user.image = picture_file

        question.user_id = current_user.user_id
        question.title = form.title.data
        question.message = form.message.data
        question.image = picture_file
        question.tag_id = form.tag_name.data.tag_id
        question.edit_submission_time = datetime.now().replace(microsecond=0).isoformat()
        question_tag.tag_id = form.tag_name.data.tag_id
        data_manager.update_to_database()
        flash('Question updated ', 'success')
        return redirect(url_for('route_home'))

    return render_template("question.html", form=form, question_id=question_id)




@app.route('/test', methods=['GET', 'POST'])
def route_test():
    # fint_it = db.session.query(Users).filter(Users.email.like('%wp.pl%')).all()
    # any = data_manager.count_tags()
    # result = data_manager.find_all_users()
    # tags = data_manager.fetch_tags()
    # questions = Question.query.get(9)

    question_tag = data_manager.find_question_tag_by_id(124)

    a = question_tag.tag_id
    # print(a)

    question_tag.tag_id = 5

    # print(question_tag.tag_id)
    data_manager.update_to_database()


    return render_template('test.html')


