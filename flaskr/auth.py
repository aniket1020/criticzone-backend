import functools

from flask import (
    Blueprint, flash, g, redirect, render_template, request, session, url_for
)
from werkzeug.security import check_password_hash, generate_password_hash

from flaskr.db import get_db

bp = Blueprint('auth', __name__, url_prefix='/auth')


@bp.route('/register', methods=('GET', 'POST'))
def register():
    if request.method == 'POST':
        user_email = request.form['user_email']
        user_password = request.form['user_password']
        db = get_db()
        error = None

        if not user_email:
            error = 'User email is required.'
        elif not user_password:
            error = 'Password is required.'
        elif db.execute( 'SELECT user_email FROM users WHERE user_email = ?',(user_email,)).fetchone():
            error = 'User {} is already registered.'.format(user_email)

        if error is None:
            db.execute(
                'INSERT INTO users (user_email, user_password) VALUES (?, ?)',
                (user_email, generate_password_hash(user_password),)
            )
            db.commit()
            return redirect(url_for('auth.login'))

        flash(error)

    return render_template('register.html')


@bp.route('/login', methods=('GET', 'POST'))
def login():
    if request.method == 'POST':
        user_email = request.form['user_email']
        user_password = request.form['user_password']
        db = get_db()
        error = None
        user = db.execute(
            'SELECT * FROM users WHERE user_email = ?', (user_email,)
        ).fetchone()

        if user is None:
            error = 'Incorrect User Email'
        elif not check_password_hash(user['user_password'], user_password):
            error = 'Incorrect password.'

        if error is None:
            session.clear()
            session['user_id'] = user['user_id']
            return redirect('/index')
        print(error)
        flash(error)
    return render_template('login.html')


def login_required(view):
    @functools.wraps(view)
    def wrapped_view(**kwargs):
        if g.user is None:
            return redirect(url_for('auth.login'))
        return view(**kwargs)
    return wrapped_view


@bp.before_app_request
def load_logged_in_user():
    user_id = session.get('user_id')
    if user_id is None:
        g.user = None
    else:
        g.user = get_db().execute(
            'SELECT * FROM users WHERE user_id = ?', (user_id,)
        ).fetchone()


@bp.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('home'))
