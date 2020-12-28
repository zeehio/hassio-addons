
from flask import Flask, request, jsonify, make_response
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
    port = os.getenv("APP_PORT",
    app.run(debug=True, host='0.0.0.0', port=8099)

