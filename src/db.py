import json
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, Date

Base = declarative_base()


def generate_dsn(path):
    with open(path) as f:
        connection = json.load(f)
    user = connection['username']
    password = connection['password']
    db = connection['database']
    print('postgresql://' + user + ':' + password + '@localhost/' + db + '')
    return 'postgresql://' + user + ':' + password + '@localhost/' + db + ''


def get_session(dsn):
    engine = create_engine(dsn, echo=True)
    Session = sessionmaker(engine)
    session = Session()
    return session


class Eatery(Base):
    __tablename__ = 'eatery'
    eatery_id = Column(Integer, primary_key=True)
    name = Column(String)
    location = Column(String)
    park_id = Column(String)
    start_date = Column(Date)
    end_date = Column(Date)
    description = Column(String)
    permit_number = Column(String)
    phone = Column(String)
    website = Column(String)
    type_name = Column(String)
