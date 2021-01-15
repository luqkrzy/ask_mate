from askmate import os
from secrets import token_hex
from werkzeug.utils import secure_filename
from PIL import Image


def save_picture(form_picture):
    random_hex = token_hex(6)
    _, file_ext = os.path.splitext(form_picture.filename)
    picture_filename = random_hex + file_ext
    picture_path = os.path.join(os.getcwd(), 'askmate/static/img/usr_pic', picture_filename)

    output_size = (300, 200)
    pic = Image.open(form_picture)
    pic.thumbnail(output_size)
    pic.save(picture_path)

    return picture_filename


