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
    return render_template('index.html', vars={'movies':movies,'name':'Aniket'})
