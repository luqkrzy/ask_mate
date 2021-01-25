import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_login import LoginManager
from datetime import datetime


app = Flask(__name__)
app.config.from_object('config.DevelopmentConfig')
app.url_map.strict_slashes = False
app_config = app.config
db = SQLAlchemy(app)
bcrypt = Bcrypt(app)
login_manager= LoginManager(app)
login_manager.login_view = 'users.route_login'
login_manager.login_message_category = 'info'

from askmate.users.routes import users
from askmate.question.routes import questions
from askmate.main.routes import main

app.register_blueprint(users)
app.register_blueprint(questions)
app.register_blueprint(main)

from askmate import data_manager


app.jinja_env.globals.update(
    func_user_info=data_manager.find_user_by_id,
    func_find_tag_name=data_manager.find_tag_name_by_id,
    func_count_answers=data_manager.count_answers_by_question_id,
    func_count_comments=data_manager.count_comments_by_question_id,
    # func_tags=data_manager.count_tags(),
)


# @app.errorhandler(404)
# def page_not_found(e):
#     return render_template('404.html'), 404


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
