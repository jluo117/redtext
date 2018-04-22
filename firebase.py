from firebase_admin import db
import firebase_admin
from twillo import*
from firebase_admin import credentials
import urllib
from urllib.request import*
import json
import requests
import random
def getMsg(treads,userAry,photoAry):
    r = requests.get(treads, headers = {'User-agent': 'Chrome'})
    theJson = json.loads(r.text)
    treadArray = theJson["data"]["children"]
    curAry = random.choice(treadArray)
    childData = curAry["data"]
    jsonConfig = "https://www.reddit.com" + childData["permalink"] + ".json"
    userAry.append(jsonConfig)
    photodata = (childData["preview"]["images"])
    photoAry.append(photodata[0]["source"]["url"])
    msg = childData["subreddit_name_prefixed"] + '\n' + childData["title"] + '\n' + "https://www.reddit.com" +childData["permalink"] + '\n'
    return msg
def setData(permalinks, userNumber):
    ref = db.reference("User/" + userNumber +"/permaLinks/" )
    refData = ref.set(permalinks)
    ''' for data in refData:
        if data["userID"] == userNumber:
            userRef = data
            print(permalinks)
            userRef["permaLinks"].set(permalinks)
   # for link in permalinks:
    #    i += 1
'''
def get_recFeed(curUsr,users,userAry,photoAry):
    msg = ""
    for recUser in users:
        recFeed = None
        if recUser["userID"] == curUsr["userID"]:
            continue
        for recuserFeed in recUser["threads"]:
            for userFeed in curUsr["threads"]:
                if recuserFeed == userFeed:
                    feedAry = recUser["threads"]
                    if len(feedAry) == 1 or len(feedAry) == 0:
                        break
                    curFeed = userFeed
                    while(curFeed == userFeed):
                        curFeed = random.choice(feedAry)
                    newFeed = requests.get(curFeed, headers = {'User-agent': 'Chrome'})
                    newJson = json.loads(newFeed.text)
                    newTreadArray = newJson["data"]["children"]
                    curAry = random.choice(newTreadArray)
                    childData = curAry["data"]
                    photoAry.append(childData["thumbnail"])
                    jsonConfig = "https://www.reddit.com" + childData["permalink"] + ".json"
                    userAry.append(jsonConfig)
                    msg = "You should checkout " + childData["title"] + " from " + childData["subreddit_name_prefixed"] + '\n' + childData["permalink"] + '\n'
                    return msg
    return msg
cred = credentials.Certificate("redtext.json")
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://redtext-341e1.firebaseio.com/'
})

ref = db.reference("User")

# Read the data at the posts reference (this is a blocking operation)
users = ref.get()
for user in users:
    userAry = []
    photoAry = []
    number = user["number"]
    msg = "UserID: " + user["userID"] + '\n'
    for treads in user["threads"]:
        msg += getMsg(treads,userAry,photoAry)
    msg += get_recFeed(user,users,userAry,photoAry)
    msg = msg[:-1]
    setData(userAry,user["userID"])
  #  sendMsg(number,msg,photoAry)
    print(msg)

