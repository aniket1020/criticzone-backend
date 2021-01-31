from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for, jsonify
)
from werkzeug.exceptions import abort

from flaskr.auth import login_required
from flaskr.db import get_db

bp = Blueprint('index', __name__)

@bp.route('/index')
def index():
    db = get_db()
    movies = db.execute(
        'SELECT * FROM movies'
    ).fetchall()
    return render_template('index.html', vars={'movies':movies,'name':'Homepage'})

@bp.route('/index/<int:movie_id>',methods=['GET','PUT','POST','DELETE'])
@login_required
def show_movie(movie_id):
    db = get_db()
    if request.method == 'GET':
        movie = db.execute(
            'SELECT * FROM movies WHERE movie_id = ?',(movie_id)
        ).fetchone()
        reviews = db.execute(
            'SELECT * FROM reviews WHERE movie_id = ?',(movie_id)
        ).fetchall()
        #Render Template
        return render_template('movie.html',vars={'movie':movie,'reviews':reviews})
    elif request.method == 'POST':
        if request.form['user_review'] and request.form['user_rating']:
            db.execute(
                'INSERT INTO reviews values (?,?,?,?)',
                (request.session['user_id'],movie_id,request.form['user_review'],request.form['user_rating'])
            )
            db.commit()
        #Update Template
        else:
            db.execute(
                'INSERT INTO reviews values (?,?)',
                (request.session['user_id'],movie_id)
            )
            db.commit()
            #Update Template
    elif request.method == 'PUT':
        db.execute(
            'UPDATE reviews SET user_review = ?, user_rating = ? where user_id = ? and movie_id = ?',
            (request.form['user_review'],request.form['user_rating'],request.session['user_id'],movie_id)
        )
        db.commit()
        #Update Template
    elif request.method == 'DELETE':
        db.execute(
            'DELETE from reviews where user_id = ? and movie_id = ?',
            (request.session['user_id'], movie_id)
        )
        db.commit()
        # Update Template

@bp.route('/wishlist',methods=['GET'])
@login_required
def show_wishlist():
    db = get_db()
    wishlist = db.execute(
        'SELECT * from wishlist where user_id = ?',
        (request.session['user_id'])
    ).fetchall()
    movies = []
    for id in wishlist['movie_id']:
        movies.append(db.execute('SELECT * from movies where movie_id = ?',(id)))
    #render Template
    return render_template('',vars = {'movies':movies})

@bp.route('/wishlist/<int:movie_id>',methods=['DELETE'])
@login_required
def delete_movie_wishlist(movie_id):
    db = get_db()
    db.execute(
        'DELETE from wishlist where user_id = ? and movie_id = ?',
        (request.session['user_id'], movie_id)
    )
    db.commit()
    wishlist = db.execute(
        'SELECT * from wishlist where user_id = ?',
        (request.session['user_id'])
    ).fetchall()
    movies = []
    for id in wishlist['movie_id']:
        movies.append(db.execute('SELECT * from movies where movie_id = ?', (id)))
    # render Template
    return render_template('', vars={'movies': movies})