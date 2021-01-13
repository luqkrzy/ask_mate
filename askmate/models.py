from sqlalchemy.ext.automap import automap_base
from askmate import db

Base = automap_base()
Base.prepare(db.engine, reflect=True)

Users = Base.classes.users
