from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Post(db.Model):
    __tablename__ = 'post'
    id = db.Column(db.Integer, primary_key=True)
    score = db.Column(db.Integer, nullable=False)
    text = db.Column(db.String, nullable=False)
    username = db.Column(db.String, nullable=False)
    comments = db.relationship('Comment', cascade='delete')

    def __init__(self, **kwargs):
        self.score = kwargs.get('score',0)
        self.text = kwargs.get('text','')
        self.username = kwargs.get('username','')

    def serialize(self):
        return {
            'id': self.id,
            'score': self.score,
            'text': self.text,
            'username': self.username
        }


class Comment(db.Model):
    __tablename__ = 'comment'
    id = db.Column(db.Integer, primary_key=True)
    score = db.Column(db.Integer, nullable=False)
    text = db.Column(db.String, nullable=False)
    username = db.Column(db.String, nullable=False)
    post_id = db.Column(db.Integer, db.ForeignKey('post.id'), nullable=False)

    def __init__(self, **kwargs):
        self.score = kwargs.get('score',0)
        self.text = kwargs.get('text','')
        self.username = kwargs.get('username','')
        self.post_id = kwargs.get('post_id')

    def serialize(self):
        return {
            'id': self.id,
            'score': self.score,
            'text': self.text,
            'username': self.username
        }

association_table = db.Table('association', db.Model.metadata,
    db.Column('grant_id', db.Integer, db.ForeignKey('grant.id')),
    db.Column('user_id', db.Integer, db.ForeignKey('user.id'))
)

class Grant(db.Model):
    __tablename__ = 'grant'
    id = db.Column(db.Integer, primary_key=True)
    amount = db.Column(db.String, nullable=False)
    name = db.Column(db.String, nullable=False)
    organization = db.Column(db.String, nullable=False)
    deadline = db.Column(db.String, nullable=False)
    description_g = db.Column(db.String, nullable=False)
    url = db.Column(db.String, nullable=False)
    assignments = db.relationship('Assignment', cascade='delete')
    users = db.relationship("User", secondary=association_table, back_populates="grants")

    def __init__(self, **kwargs):
        self.amount = kwargs.get('amount','')
        self.name = kwargs.get('name','')
        self.organization = kwargs.get('organization','')
        self.deadline = kwargs.get('deadline','')
        self.description_g = kwargs.get('description','')
        self.url = kwargs.get('url','')

    def serialize(self):
        return {
            'id': self.id,
            'amount': self.amount,
            'name': self.name,
            'organization': self.organization,
            'deadline': self.deadline,
            'description': self.description_g,
            'url': self.url
        }

    def extended_serialize(self):
        return {
            'id': self.id,
            'amount': self.amount,
            'name': self.name,
            'organization': self.organization,
            'deadline': self.deadline,
            'description': self.description_g,
            'url': self.url,
            'assignments': [assignment.serialize() for assignment in self.assignments if assignment.id > 0],
            'students': [student.serialize() for student in self.users if student.type_ == "student"],
            'non-student': [instructor.serialize() for instructor in self.users if instructor.type_ != "student"]
        }

class Assignment(db.Model):
    __tablename__ = 'assignment'
    id = db.Column(db.Integer, primary_key=True)
    description = db.Column(db.String, nullable=False)
    due_date = db.Column(db.Integer, nullable=False)
    grant_id = db.Column(db.Integer, db.ForeignKey('grant.id'), nullable=False)

    def __init__(self, **kwargs):
        self.description = kwargs.get('description','')
        self.due_date = kwargs.get('due_date',0)
        self.grant_id = kwargs.get('grant_id')

    def serialize(self):
        return {
            'id': self.id,
            'description': self.description,
            'due_date': self.due_date
        }

    def extended_serialize(self, grant_):
        return {
            'id': self.id,
            'description': self.description,
            'due_date': self.due_date,
            'grant': grant_.serialize()
        }

class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    netid = db.Column(db.String, nullable=False)
    year = db.Column(db.String, nullable=False)
    gender = db.Column(db.String, nullable=False)
    ethnicity = db.Column(db.String, nullable=False)
    type_ = db.Column(db.String, nullable=False)
    grants = db.relationship("Grant", secondary=association_table, back_populates="users")

    def __init__(self, **kwargs):
        self.name = kwargs.get('name','')
        self.netid = kwargs.get('netid','')
        self.year = kwargs.get('year','')
        self.gender = kwargs.get('gender','')
        self.ethnicity = kwargs.get('ethnicity','')
        self.type_ = kwargs.get('type','')

    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'netid': self.netid,
            'year': self.year,
            'gender': self.gender,
            'ethnicity': self.ethnicity
        }