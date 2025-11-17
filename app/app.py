from flask import Flask, jsonify

def create_app():
    app = Flask(__name__)

    @app.route("/")
    def index():
        return jsonify({"message": "Hello, World!"})

    return app

# expose a top-level 'app' so gunicorn can load 'app:app'
app = create_app()

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)