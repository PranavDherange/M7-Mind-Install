from flask import Flask, jsonify, request
from flask_cors import CORS

app = Flask(__name__)
CORS(app)
@app.route("/",methods=['POSTS']) 
def res():
	query = dict(request.form)['query']
	res="this is krishna"
	return jsonify({"response": "res"})
if __name__ == '__main__':
	app.run()