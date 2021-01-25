import os

def get_connection_string():
    user_name = os.environ.get('PSQL_USER_NAME')
    password = os.environ.get('PSQL_PASSWORD')
    host = os.environ.get('PSQL_HOST')
    database_name = os.environ.get('PSQL_DB_NAME')

    env_variables_defined = user_name and password and host and database_name

    if env_variables_defined:
        return f'postgresql://{user_name}:{password}@{host}/{database_name}'
    else:
        raise KeyError('Some necessary environment variable(s) are not defined')


class Config(object):
    DEBUG = False
    TESTING = False
    CSRF_ENABLED = True
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SECRET_KEY = 'd6843ae88d2a6755ea08ef12e2f2f046'
    UPLOAD_EXTENSIONS = ['.jpg', '.png', '.jpeg'],
    USR_PIC_PATH = 'askmate/static/img/usr_pic'
    QUESTION_PIC_PATH = 'askmate/static/img/question_pic'
    ANSWER_PIC = 'askmate/static/img/answer_pic'
    PIC_PATH = 'askmate/static/img/'

    SQLALCHEMY_DATABASE_URI = get_connection_string()
    # MAX_CONTENT_LENGTH = 3 * 1024 * 1024,


class ProductionConfig(Config):
    DEBUG = False


class DevelopmentConfig(Config):
    ENV = 'development'
    DEVELOPMENT = True
    DEBUG = True


class TestingConfig(Config):
    TESTING = True
