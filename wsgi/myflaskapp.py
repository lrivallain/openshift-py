from flask import Flask
import sys
app = Flask(__name__)

@app.route("/")
def hello():
    return "<p>Hello World!</p><p><em>Running on Python %s</em></p>" % sys.version

if __name__ == "__main__":
    app.run()

