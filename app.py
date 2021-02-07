from flask import Flask, jsonify, request


app = Flask(__name__)

@app.route("/hi",methods=['POSTS']) 
def res():
	query = dict(request.form)['query']
	res="this is krishna"
	return jsonify({"response": res})
if __name__ == '__main__':
	app.run()