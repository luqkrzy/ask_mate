from flask_wtf import FlaskForm
from flask_wtf.file import FileAllowed, FileField
from wtforms import StringField, SubmitField, TextAreaField
from wtforms.ext.sqlalchemy.fields import QuerySelectField
from wtforms.validators import DataRequired, Length
from wtforms_validators import AlphaSpace
from askmate.data_manager import choice_query

class QuestionForm(FlaskForm):
    title = StringField('Title', validators=[DataRequired(), Length(min=10, max=80), AlphaSpace()])
    message = TextAreaField('Message', validators=[DataRequired(), Length(min=20)])
    image = FileField('Upload image', validators=[FileAllowed(['jpg', 'jpeg', 'png'])])
    tag_name = QuerySelectField('Tag', allow_blank=True, validators=[DataRequired()], query_factory=choice_query, get_label='tag_name')
    submit = SubmitField('Post')


class AnswerForm(FlaskForm):
    message = TextAreaField('post answer', validators=[DataRequired(), Length(min=20)])
    submit = SubmitField('Post')
