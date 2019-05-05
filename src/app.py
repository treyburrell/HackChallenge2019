import json
from flask import Flask, request
from db import db, Post, Comment, Grant, Assignment, User

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

@app.route('/api/grants/')
def get_grants():
    grants = Grant.query.all()

    res = {'success': True, 'data': [grant_.extended_serialize() for grant_ in grants]
    }
    return json.dumps(res), 200

@app.route('/api/grants/', methods=['POST'])
def create_grant():
    grant_body = json.loads(request.data)
    
    grant_ = Grant(
        amount = grant_body.get('amount'),
        project = grant_body.get('project'),
        organization = grant_body.get('organization'),
        deadline = grant_body.get('deadline')
    )
    db.session.add(grant_)
    db.session.commit()
   
    return json.dumps({'success': True, 'data': 
    grant_.extended_serialize()}), 201

@app.route('/api/grant/<int:grant_id>/')
def get_grant(grant_id):
    grant_ = Grant.query.filter_by(id=grant_id).first()
    if grant_ is None:
        return json.dumps({'success': False, 'error': 
        'Grant not found!'}), 404
    return json.dumps({'success': True, 'data': 
    grant_.extended_serialize()}), 200

@app.route('/api/grant/<int:grant_id>/', methods=['DELETE'])
def delete_grant(grant_id):
    grant_ = Grant.query.filter_by(id=grant_id).first()
    if grant_ is not None:
        db.session.delete(grant_)
        db.session.commit()
        return json.dumps({'success': True, 'data': 
        grant_.extended_serialize()}), 200
    return json.dumps({'success': False, 'error': 
    'Grant not found!'}), 404

@app.route('/api/users/', methods=['POST'])
def create_user():
    user_body = json.loads(request.data)
    
    user = User(
        name = user_body.get('name'),
        netid = user_body.get('netid'),
        year = user_body.get('year'),
        gender = user_body.get('gender'),
        ethnicity = user_body.get('ethnicity'),
        type_ = user_body.get('type')
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

@app.route('/api/grant/<int:grant_id>/add/', methods=['POST'])
def add_user(grant_id):
    grant_ = Grant.query.filter_by(id=grant_id).first()
    if grant_ is None:
        return json.dumps({'success': False, 'error': 
        'Grant not found!'}), 404
    user_body = json.loads(request.data)
    user_id = user_body.get('user_id')
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return json.dumps({'success': False, 'error': 
        'User not found!'}), 404
    user.type_ = user_body.get('type')
    grant_.users.append(user)
    db.session.add(user)
    db.session.commit()
    return json.dumps({'success': True, 'data': 
    grant_.extended_serialize()}), 200

@app.route('/api/grant/<int:grant_id>/assignments/')
def get_assignments(grant_id):
    grant_ = Grant.query.filter_by(id=grant_id).first()
    if grant_ is None:
        return json.dumps({'success': False, 'error': 
        'Grant not found!'}), 404
    assignments = [assignment.serialize() for assignment in grant_.assignments]
    return json.dumps({'success': True, 'data': 
    assignments}), 200

@app.route('/api/grant/<int:grant_id>/assignment/', methods=['POST'])
def create_assignment(grant_id):
    grant_ = Grant.query.filter_by(id=grant_id).first()
    if grant_ is None:
        return json.dumps({'success': False, 'error': 
        'Grant not found!'}), 404
    assignment_body = json.loads(request.data)
    assignment = Assignment(
        description = assignment_body.get('description'),
        due_date = assignment_body.get('due_date'),
        grant_id = grant_.id
    )
    grant_.assignments.append(assignment)
    db.session.add(assignment)
    db.session.commit()
    grant_ = Grant.query.filter_by(id=grant_id).first()
    return json.dumps({'success': True, 'data': 
    assignment.extended_serialize(grant_)}), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
