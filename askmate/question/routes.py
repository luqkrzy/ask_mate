from flask import Blueprint, request, render_template, redirect, url_for, flash
import askmate.data_manager as data_manager
from flask_login import current_user, login_required
from askmate import db
from askmate.models import Question
from askmate.question.forms import QuestionForm
from datetime import datetime


questions = Blueprint('questions', __name__)



@questions.route("/search")
def route_search():
    order_direction = request.args.get('order_direction')
    switch_order_direction = data_manager.switch_asc_desc(order_direction)
    request_args = dict(request.args)
    print(request_args)
    search_phrase = request.args.get('search_phrase')

    questions = data_manager.search_query(request_args=request_args)

    return render_template('search.html', questions=questions, asc_desc=switch_order_direction, search_phrase=search_phrase)


@questions.route('/question', methods=['GET', 'POST'])
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
        return redirect(url_for('main.route_home'))

    return render_template("edit_add_question.html", form=form)


@questions.route('/question/edit/<int:question_id>', methods=['GET', 'POST'])
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
        return redirect(url_for('questions.route_home'))

    return render_template("edit_add_question.html", form=form, question_id=question_id)
