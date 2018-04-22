from firebase_admin import db
import firebase_admin
from twillo import*
from firebase_admin import credentials
import urllib
from urllib.request import*
import json
import requests
import random
def getMsg(treads,users,user):
    print(treads)
    r = requests.get(treads, headers = {'User-agent': 'Chrome'})
    theJson = json.loads(r.text)
    treadArray = theJson["data"]["children"]
    curAry = random.choice(treadArray)
    childData = curAry["data"]
    msg = childData["subreddit_name_prefixed"] + '\n' + childData["title"] + '\n' + childData["url"] + '\n'
    for lookUp in users:
        if lookUp["userID"] == user["userID"]:
            continue
        for Foundtread in lookUp["threads"]:
            if Foundtread == treads:
                if len(lookUp["threads"]) == 0:
                        break
                recommendTread = None
                while (recommendTread is None and recommendTread == treads):
                    recommendTread = random.choice(lookUp["threads"])
                if recommendTread == None:
                    print(msg)
                    return msg
                newFeed = requests.get(recommendTread, headers = {'User-agent': 'Chrome'})
                newJson = json.loads(newFeed.text)
                newTreadArray = newJson["data"]["children"]
                curAry = random.choice(newTreadArray)
                childData = curAry["data"]
                msg += "You should checkout " + childData["title"] + " from " + childData["subreddit_name_prefixed"] + '\n' + childData["url"] + '\n'
    print (msg)
    return msg
cred = credentials.Certificate("redtext.json")
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://redtext-341e1.firebaseio.com/'
})

ref = db.reference("User")

# Read the data at the posts reference (this is a blocking operation)
users = ref.get()
for user in users:
    number = user["number"]
    msg = "UserID: " + user["userID"] + '\n'
    for treads in user["threads"]:
        msg += getMsg(treads,users,user)
    msg = msg[:-1]
    #sendMsg(number,msg)
    print(msg)

