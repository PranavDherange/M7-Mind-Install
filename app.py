from flask import Flask, jsonify, request
import speech_recognition as sr

app = Flask(__name__)

@app.route("/") 
def home_view(): 
	return "<h1>Mind Install</h1>"

@app.route("/voiceToText", methods=["POST"])
def voiceToText():
    # Return error if file is not uploaded
    if "file" not in request.files:
        return jsonify(error="No audio file detected")

    file = request.files["file"]
    
    # Return error if filename is empty
    if file.filename == "":
        return jsonify(error="Filename empty")
    
    # Convert voice to text 
    if file:
        recognizer = sr.Recognizer()

        with sr.AudioFile(file) as source:
            audio = recognizer.record(source)
            
            # Recognize method will throw a request error if API is unreachable
            try:
                # Using google speech recognition
                text = recognizer.recognize_google(audio)
                print(text)
                return jsonify(text=text)
            except Exception as error:
                print(error)
                return jsonify(error="Server error")
    
@app.route("/predictEmotion", methods=["POST"])
def predictEmotion():
    # Loading trained model and feeding it text
    # Returning the emotion 
    return "Emotion"

if __name__ == "__main__":
	app.run(debug=True)
