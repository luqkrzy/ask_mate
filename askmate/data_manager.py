import inspect
from askmate import os, db, app_config
from secrets import token_hex
from PIL import Image
from askmate.models import Users, Tag, Question, QuestionTag, Answer, Comment


def set_picture_path(called_function):
    usr_pic_path = app_config['USR_PIC_PATH']
    question_pic_path = app_config['QUESTION_PIC_PATH']
    answer_pic = app_config['ANSWER_PIC']
    pic_path = app_config['PIC_PATH']
    if called_function == 'route_register':
        pic_path = usr_pic_path

    elif called_function == 'route_add_question' or called_function == 'route_edit_question':
        pic_path = question_pic_path

    elif called_function == 'route_add_answer':
        pic_path = answer_pic

    return os.path.join(os.getcwd(), pic_path)


def save_picture(form_picture):
    called_function = inspect.stack()[1].function
    random_hex = token_hex(6)
    _, file_ext = os.path.splitext(form_picture.filename)
    picture_filename = random_hex + file_ext
    full_picture_path = os.path.join(set_picture_path(called_function), picture_filename)
    output_size = (300, 200)
    pic = Image.open(form_picture)
    pic.thumbnail(output_size)
    pic.save(full_picture_path)
    return picture_filename


def switch_asc_desc(order_direction):
    return 'desc' if order_direction == 'asc' else 'asc'


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


def paginate_questions(page):
    return Question.query.paginate(page, per_page=10)


def count_answers_by_question_id(question_id):
    return Answer.query.filter_by(question_id=question_id).count()


def count_comments_by_question_id(question_id):
    return Comment.query.filter_by(question_id=question_id).count()


def count_comments_by_answer_id(answer_id):
    return Comment.query.filter_by(answer_id=answer_id).count()



def find_user_by_id(user_id):
    return Users.query.get_or_404(user_id)

def count_all_questions():
    return Question.query.count()

def fetch_all_questions():
    return Question.query.all()



def sort_and_paginate_questions(request_args: dict, direction = 'desc'):
    page = int(request_args.get('page', 1))
    order_by = request_args.get('order_by', 'submission_time')
    questions = "Question.query.order_by(Question.{}.{}())".format(order_by, direction)
    x = eval(questions).paginate(page, per_page=10)
    print(type(x))
    return x

def fetch_questions_by_request(request_args: dict):
    order_by = request_args.get('order_by', 'submission_time')
    order_direction = request_args.get('order_direction', 'desc')
    page = request_args.get('page', int(1))
    filter_by_type = next(iter(request_args))
    filter_by_value = next(iter(request_args.values()))
    filter_questions = "Question.query.filter_by({}={}).order_by(Question.{}.{}())".format(filter_by_type, filter_by_value, order_by, order_direction)
    return eval(filter_questions).paginate(page, per_page=10)

