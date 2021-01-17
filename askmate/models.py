from datetime import datetime
# from sqlalchemy.ext.automap import automap_base
from askmate import db, login_manager
from flask_login import UserMixin


# Base = automap_base()
# Base.prepare(db.engine, reflect=True)
# Users = Base.classes.users

@login_manager.user_loader
def load_user(user_id):
    return Users.query.get(int(user_id))


class Users(db.Model, UserMixin):
    user_id = db.Column(db.Integer, primary_key=True, autoincrement=True, nullable=False)
    user_name = db.Column(db.String(50), nullable=False)
    email = db.Column(db.String(50), unique=True, nullable=False)
    password = db.Column(db.String(256), nullable=False)
    register_date = db.Column(db.DateTime, default=datetime.now().replace(microsecond=0).isoformat())
    reputation = db.Column(db.Integer, default=0)
    picture = db.Column(db.String(50), default='default_user.jpg')

    def get_id(self):
        return (self.user_id)

    def __repr__(self):
        return f"('{self.user_id}, '{self.user_name}', '{self.email}', '{self.register_date}', '{self.reputation}', '{self.picture}')"


class Tag(db.Model):
    tag_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    tag_name = db.Column(db.String(20), nullable=False)

    def __repr__(self):
        return f"('{self.tag_id}', '{self.tag_name}')"


class Question(db.Model):
    question_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'), nullable=False)
    submission_time = db.Column(db.DateTime, nullable=False, default=datetime.now().replace(microsecond=0).isoformat())
    edit_submission_time = db.Column(db.DateTime)
    view_number = db.Column(db.Integer, default=0)
    vote_number = db.Column(db.Integer, default=0)
    title = db.Column(db.Text, nullable=False)
    message = db.Column(db.Text, nullable=False)
    image = db.Column(db.String, default='default_question.png')
    tag_id = (db.Column(db.Integer, db.ForeignKey('tag.tag_id'), nullable=False))

    def __repr__(self):
        return f"('{self.question_id}', '{self.user_id}', '{self.title}', '{self.submission_time}', '{self.edit_submission_time}', '{self.view_number}', '{self.vote_number}', '{self.tag_id}')"
