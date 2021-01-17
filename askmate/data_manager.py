import inspect
from askmate import os, db, app_config
from secrets import token_hex
from PIL import Image
from askmate.models import Users, Tag, Question


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


def find_all_users():
    return Users.query.all()


def fetch_tags():
    return Tag.query.all()


def get_all_tag_names():
    return [tag.tag_name for tag in list(fetch_tags())]


def count_tags():
    return db.engine.execute('SELECT tag_name, COUNT(tag.tag_id) FROM tag, question_tag WHERE tag.tag_id = question_tag.tag_id GROUP BY tag.tag_id;')


def choice_query():
    return Tag.query


def find_question_by_id(question_id):
    return Question.query.get_or_404(question_id)
