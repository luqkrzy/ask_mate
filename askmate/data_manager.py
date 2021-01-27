import os
from askmate import db
from sqlalchemy import or_, func
from askmate.models import Users, Tag, Question, QuestionTag, Answer, Comment, UserVotes


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


def add_new_answer(new_answer):
    answer = Answer(user_id=new_answer['user_id'], message=new_answer['message'], question_id=new_answer['question_id'])
    commit_to_database(answer)


def add_new_comment_for_question(new_comment):
    comment = Comment(user_id=new_comment['user_id'], question_id=new_comment['question_id'], message=new_comment['message'])
    commit_to_database(comment)


def add_new_comment_for_answer(new_comment):
    comment = Comment(user_id=new_comment['user_id'], answer_id=new_comment['answer_id'], message=new_comment['message'])
    commit_to_database(comment)


def vote_for_answer(data_to_modify):
    answer_id = int(data_to_modify.get('answer_id'))
    vote = int(data_to_modify.get('answers_votes'))
    db.session.query(Answer).filter(Answer.answer_id == answer_id).update({Answer.vote_number: Answer.vote_number + vote})

def vote_for_question_user_votes_table(question_id, user_id):
    vote = UserVotes(user_id=user_id, question_id=question_id)
    commit_to_database(vote)


def check_user_question_vote(user_id, question_id):
    return db.session.query(UserVotes).filter_by(user_id=user_id, question_id=question_id)



def update_answer(updated_answer):
    question_id = updated_answer.get('question_id')
    message = updated_answer.get('message')
    db.session.query(Answer).filter(Answer.question_id == question_id).update({Answer.message: message})
    update_to_database()


def find_user_by_email(email):
    return Users.query.filter_by(email=email).first()


def fetch_tags():
    return Tag.query.all()


def count_tags():
    return db.engine.execute('SELECT tag.tag_id, tag.tag_name, COUNT(tag.tag_id) FROM tag, question_tag WHERE tag.tag_id = question_tag.tag_id GROUP BY tag.tag_id;')


def choice_query():
    return Tag.query


def find_question_by_id(question_id):
    return Question.query.get_or_404(question_id)


def remove_question_by_id(question_id):
    Question.query.filter_by(question_id=question_id).delete()
    update_to_database()


def remove_comment_by_id(comment_id):
    Comment.query.filter_by(comment_id=comment_id).delete()
    update_to_database()


def remove_answer_by_id(answer_id):
    Answer.query.filter_by(answer_id=answer_id).delete()
    update_to_database()


def find_answers_by_question_id(question_id):
    return Answer.query.filter_by(question_id=question_id)


def find_comments_by_question_id(question_id):
    return Comment.query.filter_by(question_id=question_id).order_by(Comment.submission_time.asc())


def find_comments_by_answer_id(answer_id):
    return Comment.query.filter_by(answer_id=answer_id).order_by(Comment.submission_time.asc())


def find_tag_name_by_id(tag_id):
    return Tag.query.filter_by(tag_id=tag_id).first()


def find_question_tag_by_id(question_id):
    return QuestionTag.query.filter_by(question_id=question_id).first()


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
