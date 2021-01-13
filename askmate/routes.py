import os
from datetime import datetime
from flask import render_template, url_for, flash, redirect
from askmate import app, db, bcrypt
from askmate.forms import RegistrationForm, LoginForm
from askmate.models import Users


@app.route("/")
@app.route("/home")
def route_home():
    # print(app.config)
    # print(os.environ)
    return render_template('home.html')


@app.route("/register", methods=['GET', 'POST'])
def route_register():
    form = RegistrationForm()
    if form.validate_on_submit():
        hashed_password = bcrypt.generate_password_hash(form.password.data).decode('utf-8')
        user = Users(user_name=form.username.data, email=form.email.data, password=hashed_password, register_date=datetime.now().replace(microsecond=0).isoformat())
        db.session.add(user)
        db.session.commit()
        print(user)

        flash(f'Account created for {form.username.data}!', 'success')
        return redirect(url_for('route_home'))
    return render_template('register.html', form=form)


@app.route("/login", methods=['GET', 'POST'])
def route_login():
    form = LoginForm()
    if form.validate_on_submit():
        if form.email.data == 'admin@blog.com' and form.password.data == 'root':
            flash('You have been logged in!', 'success')
            return redirect(url_for('route_home'))
        else:
            flash('Login Unsuccessful. Please check username and password', 'danger')
    return render_template('login.html', form=form)
