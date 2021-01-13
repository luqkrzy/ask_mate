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
