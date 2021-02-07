![logo](https://user-images.githubusercontent.com/58757868/107145728-804dd880-6969-11eb-86db-ec7a0c236a7f.png)

# M7-Mind-Install

## Problem-Statement:
We often see many people sharing their emotions and sufferings during a call to their friends or relatives. India reported an average 381 deaths by suicide daily in 2019, totalling 1,39,123 fatalities over the year, according to the latest National Crime Records Bureau (NCRB) data. Seeing suicide as a major concern in our Country we thought of doing something to prevent suicides. In order to prevent suicide, it is necessary to detect suicide-related thoughts and user's suicide ideation in real-world by sentiment analysis method.

Along with that, sometimes it is also important to understand any abusive expressions of the person on the other side of a phone call in order to prevent any future casualities.

## Team Details 
**Team Name:** Mind Install

**Members:**

 - Astel Thottankara 
 - Dhrutik Patel
 - Dhruv Oza
 - Krishna Patel
 - Pranav Dherange
 

# What it does
We get various random audio call files from the Internet. We then convert the audio into text and use our Machine Learning model to detect if any suicidal words were used in the particular call.


# How we built it

- The user interface will be built on Flutter where user will given an option to upload an audio file containing the conversation of the interested person
- The audio file will be then sent to a Flask API deployed on Heroku. The Flask app will contain the logic to analyze the audio file.
- Firstly it will be converted to a text file using Speech Recognition which will then be feeded into another Machine Learning model where it will be classified as suicidal, abusive, threatening or completely normal
- The result of the model will then be sent as a response to the Flutter app where it will display the response of the model accordingly.


# Tech Stack

- PRAW(Python Reddit API Wrapper) for scraping reddit data
- Flask
- Flutter
- Machine Learning
- Speech Recognition
- LDA(latent Dirichlet Allocation)


# Challenges we ran into


# Accomplishments that we're proud of


# What we learned

