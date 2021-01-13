from connection import get_connection_string


class Config(object):
    DEBUG = False
    TESTING = False
    CSRF_ENABLED = True
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SECRET_KEY = 'd6843ae88d2a6755ea08ef12e2f2f046'
    UPLOAD_EXTENSIONS = ['.jpg', '.png', '.jpeg'],
    UPLOAD_PATH = 'static/img'
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
