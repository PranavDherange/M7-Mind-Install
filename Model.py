from sklearn.decomposition import LatentDirichletAllocation
from sklearn.feature_extraction.text import CountVectorizer
import numpy as np
import pandas as pd
import random

data = pd.read_csv('reddit-data/train_sw.csv')
to_drop = ['Unnamed: 1', 'Unnamed: 2']
data_f = data.drop(to_drop, axis = 'columns')

# Input 
text = 'Most hotlines are at least partially staffed by trained volunteers, so check out agencies in your area.'

pred = {'body': text}
data = data_f.append(pred, ignore_index = True);

cv = CountVectorizer(max_df=0.9,min_df=2,stop_words='english')
dtm = cv.fit_transform(data['body'])

LDA = LatentDirichletAllocation(n_components=3,random_state=32)
LDA.fit(dtm)

random_word_id = random.randint(0,1610)
cv.get_feature_names()[random_word_id]

single_topic = LDA.components_[0]
top_ten_words = single_topic.argsort()[-20:]

topic_results = LDA.transform(dtm)
data['Topic'] = topic_results.argmax(axis=1)

# Output
def predict(val):
    if val == 0:
        print('Suicidal')
    elif val == 1:
        print('Abusive/Threatening')
    else:
        print('Completely Normal')




val = data['Topic'][len(data)-1]
predict(val)
