import os
import sys

from flask import Flask, request, jsonify, make_response
from werkzeug.middleware.dispatcher import DispatcherMiddleware
from werkzeug.serving import run_simple

app = Flask(__name__)

@app.route('/')
def hello_world():
    print("Hello world", file=sys.stderr)
    response = make_response(
        jsonify(
            dict(request.headers)
        ),
        200,
    )
    response.headers["Content-Type"] = "application/json"
    return response

if __name__ == '__main__':
    base_url = "/" + os.getenv("HOSTNAME").replace("-", "_")  # FIXME: Not sure if that is reliable enough...
    print(base_url, file=sys.stderr)
    application = DispatcherMiddleware(app, {
        base_url: app
    })

    run_simple(hostname='0.0.0.0', port=8099, application=application, use_reloader=True)

