from flask import Flask, request, jsonify, make_response
from werkzeug.wsgi import DispatcherMiddleware
from werkzeug.serving import run_simple

app = Flask(__name__)

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
    subdir = os.getenv("HOSTNAME")
    application = DispatcherMiddleware(
        None, {
            '/' + subdir: app
        }
    )

    run_simple(host='0.0.0.0', port=8099, application, use_reloader=True)

