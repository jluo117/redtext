from firebase_admin import db
import firebase_admin
from twillo import*
from firebase_admin import credentials
import urllib
from urllib.request import*
import json
import requests
import random
def getMsg(treads):
    print(treads)
    r = requests.get(treads, headers = {'User-agent': 'Chrome'})
    theJson = json.loads(r.text)
    treadArray = theJson["data"]["children"]
    curAry = random.choice(treadArray)
    childData = curAry["data"]
    msg = childData["subreddit_name_prefixed"] + '\n' + childData["title"] + '\n' + childData["url"] + '\n'
    print (msg)
    return msg
cred = credentials.Certificate("redtext.json")
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://redtext-341e1.firebaseio.com/'
})

ref = db.reference("User")

# Read the data at the posts reference (this is a blocking operation)
for users in ref.get():
    number = users["number"]
    msg = "UserID: " + users["userID"] + '\n'
    for treads in users["threads"]:
        msg += getMsg(treads)
    msg = msg[:-1]
    #sendMsg(number,msg)
    print(msg)

