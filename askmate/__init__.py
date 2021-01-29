from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_login import LoginManager
from askmate.config import Config, DevelopmentConfig, ProductionConfig

db = SQLAlchemy()
bcrypt = Bcrypt()
login_manager = LoginManager()
login_manager.login_view = 'users.route_login'
login_manager.login_message_category = 'info'


def create_app(config_class=DevelopmentConfig):
    app = Flask(__name__)
    app.config.from_object(DevelopmentConfig)
    app.url_map.strict_slashes = False
    app.jinja_env.globals.update(
        func_user_info=data_manager.find_user_by_id,
        func_find_tag_name=data_manager.find_tag_name_by_id,
        func_count_answers=data_manager.count_answers_by_question_id,
        func_count_comments=data_manager.count_comments_by_question_id,
        func_check_user_answer_vote=data_manager.check_user_answer_vote,
        func_tags=data_manager.count_tags,
        func_find_last_10_question_titles=data_manager.find_last_10_question_titles,
        func_find_top_10_users=data_manager.find_top_10_users,
    )


    from askmate.users.routes import users
    from askmate.question.routes import questions
    from askmate.main.routes import main
    from askmate.errors.handlers import errors
    app.register_blueprint(users)
    app.register_blueprint(questions)
    app.register_blueprint(main)
    app.register_blueprint(errors)

    app.url_map.strict_slashes = False

    db.init_app(app)
    bcrypt.init_app(app)
    login_manager.init_app(app)

    return app


from askmate import data_manager
