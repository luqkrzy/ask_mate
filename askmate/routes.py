from flask import render_template, url_for, flash, redirect, request
from askmate import app, bcrypt
from askmate.forms import RegistrationForm, LoginForm, UpdateAccountForm, QuestionForm, Users
from flask_login import login_user, current_user, logout_user, login_required
from askmate import data_manager, datetime
from askmate.models import Users, Question

app.jinja_env.globals.update(
    func_user_info=data_manager.find_user_by_id,
    func_questions_no=data_manager.count_all_questions(),
    func_find_tag_name=data_manager.find_tag_name_by_id,
    func_count_answers=data_manager.count_answers_by_question_id,
    func_count_comments=data_manager.count_comments_by_question_id,
    # func_tags=data_manager.count_tags(),
)


@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404


@app.context_processor
def context_processor():
    return dict(
        func_tags=data_manager.count_tags(),
        # func_questions_no=data_manager.count_all_questions(),
        # func_find_tag_name=data_manager.find_tag_name_by_id,
        # func_count_answers=data_manager.count_answers_by_question_id,
        # func_count_comments=data_manager.count_comments_by_question_id,
        # func_user_info=data_manager.find_user_by_id
    )


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


@app.route("/")
def route_home():
    order_direction = 'asc'
    order_by = 'title'
    if request.args.get('order_by'):
        order_by = request.args.get('order_by')
        order_direction = request.args.get('order_direction')

    switch_order_direction = data_manager.switch_asc_desc(order_direction)
    page = request.args.get('page', default=1, type=int)

    if request.args.get('tag'):
        tag_id = request.args.get('tag')
        questions_by_tags = data_manager.paginate_questions_by_tag(page=page, tag_id=tag_id, order_by=order_by, direction=switch_order_direction)
        return redirect(url_for('tag.html', tag_id=tag_id, questions=questions_by_tags, asc_desc=switch_order_direction))

    questions = data_manager.sort_and_paginate_questions(page=page, order_by=order_by, direction=switch_order_direction)

    return render_template('index.html', questions=questions, asc_desc=switch_order_direction)

@app.route("/tag/<int:tag_id>")
def route_tag(tag_id):
    order_direction = 'asc'
    order_by = 'title'
    if request.args.get('order_by'):
        order_by = request.args.get('order_by')
        order_direction = request.args.get('order_direction')

    switch_order_direction = data_manager.switch_asc_desc(order_direction)
    page = request.args.get('page', default=1, type=int)

    if request.args.get('tag'):
        tag_id = request.args.get('tag')
        questions_by_tags = data_manager.paginate_questions_by_tag(page=page, tag_id=tag_id, order_by=order_by, direction=switch_order_direction)
        return redirect(url_for('tag.html', tag_id=tag_id, questions=questions_by_tags, asc_desc=switch_order_direction))

    questions_by_tags = data_manager.paginate_questions_by_tag(page=page, tag_id=tag_id, order_by=order_by, direction=switch_order_direction)

    return render_template('tag.html', questions=questions_by_tags, asc_desc=switch_order_direction)


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


def clever_function():
    return 'Hello world!'


@app.route('/test', methods=['GET', 'POST'])
def route_test():
    # fint_it = db.session.query(Users).filter(Users.email.like('%wp.pl%')).all()
    # any = data_manager.count_tags()
    # result = data_manager.find_all_users()
    # tags = data_manager.fetch_tags()
    # questions = Question.query.get(9)
    find_tag_name = data_manager.find_tag_name_by_id
    # question_tag = data_manager.find_question_tag_by_id(124)
    find_tag_name_by_id = data_manager.find_tag_name_by_id
    # a = (question_tag)
    # print(a)

    # question_tag.tag_id = 5
    # print(question_tag.tag_id)

    # questions = data_manager.fetch_all_questions()
    # answers= data_manager.count_answers_by_question_id(113)
    # comments = data_manager.count_comments_by_question_id(143)
    # userd_name = data_manager.find_user_by_id(23)
    # paginate_all_questions = data_manager.paginate_all_questions(1)
    # print(paginate_all_questions.page)

    # user = Users.query.filter_by(user_id=40).first_or_404()
    # print(user)

    # question = Question.query.filter_by(author=user).order_by(Question.vote_number.desc())
    # question_paginate = question.paginate(1, per_page=10)
    # for q in question_paginate.items:
    #     print(q)

    # new = data_manager.new_paginate_func()
    # question_paginate = new.paginate(1, per_page=10)
    # for i in question_paginate.items:
    #     print(i)

    # again = data_manager.sort_and_paginate_questions(1, 'question_id', 'desc')
    # for i in again.items:
    #     print(i)


    question = data_manager.paginate_questions_by_tag(1, 1)
    # for i in question.items:
    #     print(i)

    return render_template('test.html', data=question)
