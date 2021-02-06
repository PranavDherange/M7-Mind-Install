from flask import Flask
app = Flask(__name__)

@app.route("/")
def home():
    return "Hello, Flask!"

@app.route("/voiceToText", methods=["POST"])
def voiceToText():
    # Loading speech recognition model and feeding user audio
    # Returning the response from model
    return "Voice"
    
@app.route("/predictEmotion", methods=["POST"])
def predictEmotion():
    # Loading trained model and feeding it text
    # Returning the emotion 
    return "Emotion"

if __name__ == "__main__":
    print("Starting Python Flask Server")
    app.run(debug=True
