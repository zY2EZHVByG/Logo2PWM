from flask import Flask, session, g, render_template
# from flask.ext.openid import OpenID

app = Flask(__name__)


@app.errorhandler(404)
def not_found(error):
    return render_template('404.html'), 404

from app import views

