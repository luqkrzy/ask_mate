import os
from askmate import db
from sqlalchemy import or_, func
from askmate.models import Users, Tag, Question, QuestionTag, Answer, Comment


def switch_asc_desc(order_direction):
    if order_direction == 'asc':
        return 'desc'
    else:
        return 'asc'


def commit_to_database(data):
    db.session.add(data)
    db.session.commit()


def update_to_database():
    db.session.commit()


def register_new_user(new_user: dict):
    user = Users(user_name=new_user['user_name'], email=new_user['email'], password=new_user['password'], picture=new_user['picture'])
    commit_to_database(user)


def ask_new_question(new_question):
    question = Question(user_id=new_question['user_id'], title=new_question['title'], message=new_question['message'], image=new_question['image'], tag_id=new_question['tag_id'])
    commit_to_database(question)


def find_user_by_email(email):
    return Users.query.filter_by(email=email).first()


def fetch_tags():
    return Tag.query.all()


def get_all_tag_names():
    return [tag.tag_name for tag in list(fetch_tags())]


def count_tags():
    return db.engine.execute('SELECT tag.tag_id, tag.tag_name, COUNT(tag.tag_id) FROM tag, question_tag WHERE tag.tag_id = question_tag.tag_id GROUP BY tag.tag_id;')


def choice_query():
    return Tag.query


def find_question_by_id(question_id):
    return Question.query.get_or_404(question_id)


def find_tag_name_by_id(tag_id):
    return Tag.query.filter_by(tag_id=tag_id).first()


def find_question_tag_by_id(question_id):
    return QuestionTag.query.filter_by(question_id=question_id).first()
    # return db.engine.execute('SELECT tag_id FROM question_tag WHERE question_id=124;')


def count_answers_by_question_id(question_id):
    return Answer.query.filter_by(question_id=question_id).count()


def count_comments_by_question_id(question_id):
    return Comment.query.filter_by(question_id=question_id).count()


def count_comments_by_answer_id(answer_id):
    return Comment.query.filter_by(answer_id=answer_id).count()


def find_user_by_id(user_id):
    return Users.query.get_or_404(user_id)


def sort_and_paginate_questions(request_args: dict, direction='asc'):
    page = int(request_args.get('page', 1))
    order_by = request_args.get('order_by', 'submission_time')
    questions = "Question.query.order_by(Question.{}.{}())".format(order_by, direction)
    return eval(questions).paginate(page, per_page=10)


def fetch_questions_by_tag(request_args: dict):
    order_by = request_args.get('order_by', 'submission_time')
    order_direction = request_args.get('order_direction', 'desc')
    page = int(request_args.get('page', int(1)))
    tag_id = int(request_args.get('tag_id'))
    filter_questions = "Question.query.filter_by(tag_id={}).order_by(Question.{}.{}())".format(tag_id, order_by, order_direction)
    return eval(filter_questions).paginate(page, per_page=10)


def search_query(request_args: dict):
    order_by = request_args.get('order_by', 'submission_time')
    order_direction = request_args.get('order_direction', 'desc')
    search_phrase = request_args.get('search_phrase')
    page = int(request_args.get('page', 1))
    search_base = 'Question.query.filter(or_(func.lower(Question.title).like(func.lower(f"%{search_phrase}%")),func.lower(Question.message).like(func.lower(f"%{search_phrase}%"))))'
    order_direction = '.order_by(Question.{}.{}())'.format(order_by, order_direction)
    full_search_query = search_base + order_direction

    return eval(full_search_query).paginate(page, per_page=10)

