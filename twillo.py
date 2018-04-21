# /usr/bin/env python
# Download the twilio-python library from twilio.com/docs/libraries/python
from twilio.rest import Client

# Find these values at https://twilio.com/user/account
def sendMsg(msg):
    account_sid = "ACba628f6addcff045f5aac1f66150b302"
    auth_token = "47f545a1e86f99e40f35d3d7ca91e576"

    client = Client(account_sid, auth_token)

    client.api.account.messages.create(
        to="+14158109857",
        from_="+16193040288",
        body=msg)


