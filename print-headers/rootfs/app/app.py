import os
import sys

from flask import Flask, request, jsonify, make_response
from werkzeug.middleware.dispatcher import DispatcherMiddleware
from werkzeug.serving import run_simple

app = Flask(__name__)
app.url_map.strict_slashes = False
@app.route('/')
def hello_world():
    response = make_response(
        jsonify(
            dict(request.headers)
        ),
        200,
    )
    response.headers["Content-Type"] = "application/json"
    return response

if __name__ == '__main__':
    base_url = os.getenv("INGRESS_URL")
    application = DispatcherMiddleware(app, {
        base_url: app
    })
    run_simple(hostname='0.0.0.0', port=8099, application=application, use_reloader=True)

