from flask import render_template, url_for, flash, redirect, request
from askmate import app, db, bcrypt
from flask_wtf.file import FileField, FileAllowed, F
from askmate.forms import RegistrationForm, LoginForm, UpdateAccountForm
from askmate.models import Users
from flask_login import login_user, current_user, logout_user, login_required


@app.route("/")
@app.route("/home")
def route_home():
    # print(app.config)
    # print(os.environ)
    result = db.session.query(Users).all()

    return render_template('home.html', users=result)


@app.route("/register", methods=['GET', 'POST'])
def route_register():
    form = RegistrationForm()

    if current_user.is_authenticated:
        return redirect(url_for('route_home'))

    if request.method == 'POST' and form.validate_on_submit():
        hashed_password = bcrypt.generate_password_hash(form.password.data).decode('utf-8')
        user = Users(user_name=form.username.data, email=form.email.data, password=hashed_password)
        db.session.add(user)
        db.session.commit()

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
        # user = db.session.query(Users).filter(Users.email==form.email.data).first()
        user = Users.query.filter_by(email=form.email.data).first()
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
    print(request.method)

    if request.method == 'GET':
        form.username.data = current_user.user_name
        form.email.data = current_user.email

    if request.method == 'POST' and form.validate_on_submit():
        print('into')
        current_user.user_name = form.username.data
        current_user.email = form.email.data
        if bcrypt.check_password_hash(current_user.password, form.password.data):
            print(form.username.data)
            print(form.email.data)
            db.session.commit()
            flash('Your account has been updated!', 'success')
            return redirect(url_for('route_account'))
        else:
            flash('wrong password', 'danger')

    return render_template('update_account.html', form=form)
