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
    db.Column('class_id', db.Integer, db.ForeignKey('class.id')),
    db.Column('user_id', db.Integer, db.ForeignKey('user.id'))
)

class Class(db.Model):
    __tablename__ = 'class'
    id = db.Column(db.Integer, primary_key=True)
    code = db.Column(db.String, nullable=False)
    name = db.Column(db.String, nullable=False)
    assignments = db.relationship('Assignment', cascade='delete')
    users = db.relationship("User", secondary=association_table, back_populates="classes")

    def __init__(self, **kwargs):
        self.code = kwargs.get('code','')
        self.name = kwargs.get('name','')

    def serialize(self):
        return {
            'id': self.id,
            'code': self.code,
            'name': self.name
        }

    def extended_serialize(self):
        return {
            'id': self.id,
            'code': self.code,
            'name': self.name,
            'assignments': [assignment.serialize() for assignment in self.assignments if assignment.id > 0],
            'students': [student.serialize() for student in self.users if student.type_ == "student"],
            'instructors': [instructor.serialize() for instructor in self.users if instructor.type_ == "instructor"]
        }

class Assignment(db.Model):
    __tablename__ = 'assignment'
    id = db.Column(db.Integer, primary_key=True)
    description = db.Column(db.String, nullable=False)
    due_date = db.Column(db.Integer, nullable=False)
    class_id = db.Column(db.Integer, db.ForeignKey('class.id'), nullable=False)

    def __init__(self, **kwargs):
        self.description = kwargs.get('description','')
        self.due_date = kwargs.get('due_date',0)
        self.class_id = kwargs.get('class_id')

    def serialize(self):
        return {
            'id': self.id,
            'description': self.description,
            'due_date': self.due_date
        }

    def extended_serialize(self, class_):
        return {
            'id': self.id,
            'description': self.description,
            'due_date': self.due_date,
            'class': class_.serialize()
        }

class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    netid = db.Column(db.String, nullable=False)
    type_ = db.Column(db.String, nullable=False)
    classes = db.relationship("Class", secondary=association_table, back_populates="users")

    def __init__(self, **kwargs):
        self.name = kwargs.get('name','')
        self.netid = kwargs.get('netid','')
        self.type_ = kwargs.get('type','')

    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'netid': self.netid
        }