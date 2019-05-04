import json
from flask import Flask, request
from db import db, Post, Comment, Class, Assignment, User

app = Flask(__name__)
db_filename = 'todo.db'

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///%s' % db_filename
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = True

db.init_app(app)
with app.app_context():
    db.create_all()

@app.route('/api/posts/')
def get_posts():
    posts = Post.query.all()
    res = {'success': True, 'data': [post.serialize() for post in posts]
    }
    return json.dumps(res), 200

@app.route('/api/posts/', methods=['POST'])
def create_post():
    post_body = json.loads(request.data)
    
    post = Post(
        text = post_body.get('text'),
        username = post_body.get('username')
    )
    db.session.add(post)
    db.session.commit()
    
    return json.dumps({'success': True, 'data': 
    post.serialize()}), 201

@app.route('/api/post/<int:post_id>/')
def get_post(post_id):
    post = Post.query.filter_by(id=post_id).first()
    if post is None:
        return json.dumps({'success': False, 'error': 
        'Post not found!'}), 404
    return json.dumps({'success': True, 'data': 
    post.serialize()}), 200
    

@app.route('/api/post/<int:post_id>/', methods=['POST'])
def edit_post(post_id):
    post = Post.query.filter_by(id=post_id).first()
    if post is None:
        return json.dumps({'success': False, 'error': 
        'Post not found!'}), 404
    post_body = json.loads(request.data)
    post.text = post_body.get('text', post.text)
    post.username = post_body.get('username', post.username)
    db.session.commit()
    return json.dumps({'success': True, 'data': 
    post.serialize()}), 200

@app.route('/api/post/<int:post_id>/', methods=['DELETE'])
def delete_post(post_id):
    post = Post.query.filter_by(id=post_id).first()
    if post is not None:
        db.session.delete(post)
        db.session.commit()
        return json.dumps({'success': True, 'data': 
        post.serialize()}), 200
    return json.dumps({'success': False, 'error': 
    'Post not found!'}), 404

@app.route('/api/post/<int:post_id>/comments/')
def get_comments(post_id):
    post = Post.query.filter_by(id=post_id).first()
    if post is None:
        return json.dumps({'success': False, 'error': 
        'Post not found!'}), 404
    comments = [comment.serialize() for comment in post.comments]
    return json.dumps({'success': True, 'data': 
    comments}), 200

@app.route('/api/post/<int:post_id>/comment/', methods=['POST'])
def create_comment(post_id):
    post = Post.query.filter_by(id=post_id).first()
    if post is None:
        return json.dumps({'success': False, 'error': 
        'Post not found!'}), 404
    comment_body = json.loads(request.data)
    comment = Comment(
        text = comment_body.get('text'),
        username = comment_body.get('username'),
        post_id = post.id
    )
    post.comments.append(comment)
    db.session.add(comment)
    db.session.commit()
    return json.dumps({'success': True, 'data': 
    comment.serialize()}), 201

@app.route('/api/classes/')
def get_classes():
    classes = Class.query.all()

    res = {'success': True, 'data': [class_.extended_serialize() for class_ in classes]
    }
    return json.dumps(res), 200

@app.route('/api/classes/', methods=['POST'])
def create_class():
    class_body = json.loads(request.data)
    
    class_ = Class(
        code = class_body.get('code'),
        name = class_body.get('name')
    )
    db.session.add(class_)
    db.session.commit()
   
    return json.dumps({'success': True, 'data': 
    class_.extended_serialize()}), 201

@app.route('/api/class/<int:class_id>/')
def get_class(class_id):
    class_ = Class.query.filter_by(id=class_id).first()
    if class_ is None:
        return json.dumps({'success': False, 'error': 
        'Class not found!'}), 404
    return json.dumps({'success': True, 'data': 
    class_.extended_serialize()}), 200

@app.route('/api/class/<int:class_id>/', methods=['DELETE'])
def delete_class(class_id):
    class_ = Class.query.filter_by(id=class_id).first()
    if class_ is not None:
        db.session.delete(class_)
        db.session.commit()
        return json.dumps({'success': True, 'data': 
        class_.extended_serialize()}), 200
    return json.dumps({'success': False, 'error': 
    'Class not found!'}), 404

@app.route('/api/users/', methods=['POST'])
def create_user():
    user_body = json.loads(request.data)
    
    user = User(
        name = user_body.get('name'),
        netid = user_body.get('netid')
    )
    db.session.add(user)
    db.session.commit()
   
    return json.dumps({'success': True, 'data': 
    user.serialize()}), 201

@app.route('/api/user/<int:user_id>/')
def get_user(user_id):
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return json.dumps({'success': False, 'error': 
        'User not found!'}), 404
    return json.dumps({'success': True, 'data': 
    user.serialize()}), 200

@app.route('/api/class/<int:class_id>/add/', methods=['POST'])
def add_user(class_id):
    class_ = Class.query.filter_by(id=class_id).first()
    if class_ is None:
        return json.dumps({'success': False, 'error': 
        'Class not found!'}), 404
    user_body = json.loads(request.data)
    user_id = user_body.get('user_id')
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return json.dumps({'success': False, 'error': 
        'User not found!'}), 404
    user.type_ = user_body.get('type')
    class_.users.append(user)
    db.session.add(user)
    db.session.commit()
    return json.dumps({'success': True, 'data': 
    class_.extended_serialize()}), 200

@app.route('/api/class/<int:class_id>/assignments/')
def get_assignments(class_id):
    class_ = Class.query.filter_by(id=class_id).first()
    if class_ is None:
        return json.dumps({'success': False, 'error': 
        'Class not found!'}), 404
    assignments = [assignment.serialize() for assignment in class_.assignments]
    return json.dumps({'success': True, 'data': 
    assignments}), 200

@app.route('/api/class/<int:class_id>/assignment/', methods=['POST'])
def create_assignment(class_id):
    class_ = Class.query.filter_by(id=class_id).first()
    if class_ is None:
        return json.dumps({'success': False, 'error': 
        'Class not found!'}), 404
    assignment_body = json.loads(request.data)
    assignment = Assignment(
        description = assignment_body.get('description'),
        due_date = assignment_body.get('due_date'),
        class_id = class_.id
    )
    class_.assignments.append(assignment)
    db.session.add(assignment)
    db.session.commit()
    class_ = Class.query.filter_by(id=class_id).first()
    return json.dumps({'success': True, 'data': 
    assignment.extended_serialize(class_)}), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
