from flask import Blueprint, request, render_template, redirect, url_for, flash
import askmate.data_manager as data_manager
from flask_login import current_user, login_required
from datetime import datetime
from askmate.question.forms import QuestionForm
from askmate.users.utils import save_picture

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


@questions.route("/tag")
def route_tag():
    order_direction = request.args.get('order_direction')
    switch_order_direction = data_manager.switch_asc_desc(order_direction)
    request_args = dict(request.args)
    print(request_args)
    tag_id = request.args.get('tag_id')

    questions = data_manager.fetch_questions_by_tag(request_args=dict(request.args))

    return render_template('tag.html', questions=questions, asc_desc=switch_order_direction, tag_id=tag_id)


@questions.route("/question/<int:question_id>", methods=["GET", "POST"])
def route_question(question_id):
    question = data_manager.find_question_by_id(question_id)
    answers_list = data_manager.find_answers_by_question_id(question_id)
    list_comments_for_question = data_manager.find_comments_by_question_id(question_id)
    list_comments_for_answers = data_manager.find_comments_by_answer_id
    data_to_modify = dict(request.args)
    question.view_number += 1
    data_manager.update_to_database()
    question_vote = None


    if current_user.is_authenticated:
        question_vote = data_manager.check_user_question_vote(user_id=current_user.user_id, question_id=question_id)

        if 'questions_votes' in data_to_modify:
            question.vote_number += int(data_to_modify.get('questions_votes'))
            data_manager.update_to_database()
            data_manager.modify_user_reputation(data_to_modify)
            data_manager.vote_for_question_user_votes_table(question_id=question_id, user_id=current_user.user_id, vote_value=data_to_modify.get('questions_votes'))
            return redirect(url_for('questions.route_question', question_id=question_id))


        elif 'answers_votes' in data_to_modify:
            print(data_to_modify)
            data_manager.vote_for_answer(data_to_modify, user_id=current_user.user_id)
            data_manager.modify_user_reputation(data_to_modify)
            return redirect(url_for('questions.route_question', question_id=question_id))


        elif 'remove_question' in data_to_modify:
            data_manager.remove_question_by_id(question_id)
            flash('Question deleted', 'info')
            return redirect(url_for('main.route_home'))

        elif 'remove_answer' in data_to_modify:
            data_manager.remove_answer_by_id(answer_id=request.args.get('answer_id'))
            flash('Answer deleted', 'info')
            return redirect(url_for('questions.route_question', question_id=question_id))

        elif 'remove_comment_for_question' in data_to_modify:
            data_manager.remove_comment_for_question_by_id(comment_id=request.args.get('comment_id'))
            flash('Comment deleted', 'info')
            return redirect(url_for('questions.route_question', question_id=question_id))

        elif 'remove_comment_for_answer' in data_to_modify:
            data_manager.remove_comment_for_answer_by_id(comment_id=request.args.get('comment_id'))
            flash('Comment deleted', 'info')
            return redirect(url_for('questions.route_question', question_id=question_id))

        if request.method == "POST":

            if 'answer_for_question' in request.form:
                new_answer = {'user_id': current_user.user_id,
                              'message': request.form.get('answer_for_question'),
                              'question_id': question_id}

                data_manager.add_new_answer(new_answer)
                flash('Answer added', 'success')
                return redirect(url_for('questions.route_question', question_id=question_id))

            elif 'update_answer' in request.form:
                updated_answer = {
                    'question_id': question_id,
                    "message": request.form.get('update_answer')}

                data_manager.update_answer(updated_answer)
                flash('Answer added', 'success')
                return redirect(url_for('questions.route_question', question_id=question_id))


            elif 'comments_for_answer' in request.form:
                new_comment = {
                    "question_id": question_id,
                    'user_id': current_user.user_id,
                    "answer_id": request.args.get('answer_id'),
                    "message": request.form.get('comments_for_answer')}

                data_manager.add_new_comment_for_answer(new_comment)

            elif 'comments_for_question' in request.form:
                new_comment = {
                    'user_id': current_user.user_id,
                    "question_id": question_id,
                    "message": request.form.get('comments_for_question')}

                data_manager.add_new_comment_for_question(new_comment)

            return redirect(url_for("questions.route_question", question_id=question_id))

    return render_template('question.html', question=question, answers_list=answers_list, question_vote=question_vote,
                           comments_for_question=list_comments_for_question, comments_for_answers=list_comments_for_answers)


@questions.route('/question', methods=['GET', 'POST'])
@login_required
def route_add_question():
    form = QuestionForm()
    picture_file = 'default_question.png'

    if form.validate_on_submit():
        if form.image.data:
            picture_file = save_picture(form.image.data)
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
            picture_file = save_picture(form.image.data)
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
        return redirect(url_for('questions.route_question', question_id=question_id))

    return render_template("edit_add_question.html", form=form, question_id=question_id)


@questions.route("/question/<int:question_id>/new_question_comment", methods=["GET", "POST"])
def route_add_comment_for_question(question_id):
    print(request.form)
    if request.method == "POST":
        new_comment = {
            'user_id': current_user.user_id,
            "question_id": question_id,
            "message": request.form.get('comments_for_question'),
        }

        data_manager.add_new_comment_for_question(new_comment)
        return redirect(url_for("questions.route_question", question_id=question_id))
