from flask import render_template, redirect, request, Blueprint, url_for
from flask_login import current_user
import askmate.data_manager as data_manager


main = Blueprint('main', __name__)



@main.route("/")
def route_home():
    order_direction = request.args.get('order_direction', 'asc')
    switch_order_direction = data_manager.switch_asc_desc(order_direction)
    if request.args.get('search_phrase') is not None:
        return redirect(url_for('questions.route_search'))

    elif request.args.get('tag_id') is not None:
        return redirect(url_for('questions.route_tag'))

    questions = data_manager.sort_and_paginate_questions(request_args=dict(request.args), direction=switch_order_direction)

    return render_template('index.html', questions=questions, asc_desc=switch_order_direction)


@main.route('/test', methods=['GET', 'POST'])
def route_test():

    # answer_votes = data_manager.check_user_answer_vote(51, 495)
    # answers_list = data_manager.find_answers_by_question_id(146)
    # if not current_user.is_authenticated:
    #     print('im here')
    #     current_user.user_id = 1000
    #     print(current_user.user_id)

    # all_users = data_manager.fetch_users(1, 'user_name', 'asc')
    #
    # print(dir(all_users))
    # print(all_users.items)

    question = data_manager.find_last_10_question_titles()
    print(question)

    return render_template('test.html', questions=question)
