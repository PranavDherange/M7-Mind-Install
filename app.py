from flask import Flask, jsonify, request
# from flask_cors import CORS

app = Flask(__name__)
# CORS(app)
@app.route("/") 
def res():
	return "hi"
if __name__ == '__main__':
	app.run(host="192.186.0.103")