from flask import render_template, url_for, flash, redirect, request
from askmate import app, db, bcrypt
from askmate.forms import RegistrationForm, LoginForm
from askmate.models import Users
from flask_login import login_user, current_user, logout_user

@app.route("/")
@app.route("/home")
def route_home():
    # print(app.config)
    # print(os.environ)
    return render_template('home.html')


@app.route("/register", methods=['GET', 'POST'])
def route_register():
    if current_user.is_authenticated:
        return redirect(url_for('route_home'))

    form = RegistrationForm()
    if form.validate_on_submit():
        hashed_password = bcrypt.generate_password_hash(form.password.data).decode('utf-8')
        user = Users(user_name=form.username.data, email=form.email.data, password=hashed_password)
        db.session.add(user)
        db.session.commit()
        print(user)

        flash(f'Account created for {form.username.data}!', 'success')
        return redirect(url_for('route_home'))
    return render_template('register.html', form=form)


@app.route("/login", methods=['GET', 'POST'])
def route_login():
    if current_user.is_authenticated:
        return redirect(url_for('route_home'))

    form = LoginForm()
    if form.validate_on_submit():
        # user = db.session.query(Users).filter(Users.email==form.email.data).first()
        user = Users.query.filter_by(email=form.email.data).first()
        print(user.user_id)
        if user and bcrypt.check_password_hash(user.password, form.password.data):
            login_user(user, remember=form.remember.data)
            next_page = request.args.get('next')
            return redirect(next_page) if next_page else redirect(url_for('route_home'))
        else:
            flash('Login Unsuccessful. Please check email and password', 'danger')
        return redirect(url_for('route_home'))
    else:
        flash('Login Unsuccessful. Please check username and password', 'danger')
    return render_template('login.html', form=form)

@app.route("/logout")
def route_logout():
    logout_user()
    return redirect(url_for('route_home'))
