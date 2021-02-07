from sklearn.decomposition import LatentDirichletAllocation
from sklearn.feature_extraction.text import CountVectorizer
import numpy as np
import pandas as pd
import random
from flask import Flask, jsonify, request, render_template
import speech_recognition as sr
import subprocess


app = Flask(__name__)


def predict(text):
    data = pd.read_csv('reddit-data/train_sw.csv')
    to_drop = ['Unnamed: 1', 'Unnamed: 2']
    data_f = data.drop(to_drop, axis = 'columns')

    pred = {'body': text}
    data_f = data_f.append(pred, ignore_index = True)

    cv = CountVectorizer(max_df=0.95,min_df=8,stop_words='english')
    dtm = cv.fit_transform(data['body'])

    LDA = LatentDirichletAllocation(n_components=3,random_state=32)
    LDA.fit(dtm)

    random_word_id = random.randint(0,1610)
    cv.get_feature_names()[random_word_id]

    single_topic = LDA.components_[0]
    top_ten_words = single_topic.argsort()[-20:]

    topic_results = LDA.transform(dtm)
    data['Topic'] = topic_results.argmax(axis=1)

    val = data['Topic'][len(data)-1]    
    return val

# Output
def sendReponse(val):
    message=''
    if val == 0:
        message='Suicidal'
    elif val == 1:
        message='Abusive/Threatening'
    else:
        message='Completely Normal'
    print('Person is',message)

    # Returning the message
    return message



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
                print('TRANSCRIPT:',text)
                
                predict_val = predict(text)

                response = sendReponse(predict_val)

                return jsonify(response)

            except Exception as error:
                print(error)
                return jsonify(error="Server error")

                
if __name__ == "__main__":
	app.run(debug=False,host='192.168.0.103',port=5000)
