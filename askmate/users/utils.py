import os
import inspect
from flask import current_app

from secrets import token_hex
from PIL import Image


def set_picture_path(called_function):
    usr_pic_path = current_app.config['USR_PIC_PATH']
    question_pic_path = current_app.config['QUESTION_PIC_PATH']
    answer_pic = current_app.config['ANSWER_PIC']
    pic_path = current_app.config['PIC_PATH']

    if called_function == 'route_register' or called_function == 'route_update_account':
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
