from firebase_admin import db
import firebase_admin
from firebase_admin import credentials
# Get a database reference to our posts
cred = credentials.Certificate("redtext.json")
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://redtext-341e1.firebaseio.com/'
})

ref = db.reference("User")

# Read the data at the posts reference (this is a blocking operation)
print (ref.get())
