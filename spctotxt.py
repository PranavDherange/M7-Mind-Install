# To add a new cell, type '# %%'
# To add a new markdown cell, type '# %% [markdown]'
# %%
import speech_recognition as sr


# %%
def speechToAudio(loc):
    recognizer = sr.Recognizer()
    with sr.AudioFile(loc) as src:
        aud=recognizer.listen(src)
    try:
        text=recognizer.recognize_google(aud,language="en-US")
        print(text)
    except Exception as ex:
        print(ex)


# %%
speechToAudio("./sampleData/hi2.wav")


