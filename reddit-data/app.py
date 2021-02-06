import praw
import pandas as pd

posts = []

# Creating instance praw
reddit = praw.Reddit(client_id='e6qeyZCLeP9IQQ', client_secret='l_6dsZYdeYXvvLuO4MZ1v2Sx-5w4Lw', user_agent='Reddit WebScraping')

# get all posts from the subreddit
sw_subreddit = reddit.subreddit('SuicideWatch').hot(limit=40)
ab_subreddit = reddit.subreddit('abuse').hot(limit=20)

for post in sw_subreddit:
    # Adding main thread details
    posts.append([post.title])
    
    # Adding replies of current thread
    submission = reddit.submission(url=post.url)
    submission.comments.replace_more(limit=0)
    for comment in submission.comments.list():
        posts.append([comment.body])

for post in ab_subreddit:
    # Adding main thread details
    posts.append([post.title])
    
    # Adding replies of current thread
    submission = reddit.submission(url=post.url)
    submission.comments.replace_more(limit=0)
    for comment in submission.comments.list():
        posts.append([comment.body])

# Conversion and exporting
posts = pd.DataFrame(posts,columns=['body'])
print(posts)

compression_opts = dict(method='zip', archive_name='out.csv')  
posts.to_csv('out.zip', index=False, compression=compression_opts)  