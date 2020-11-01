from flask import Flask
from flask import request
from flask import Response
from pymongo import MongoClient
import json 

app = Flask(__name__)
client = MongoClient('mongodb://admin:6EQUJ5wow@mongodb')
db=client.user_service_db
users_collection = db['users'] 

@app.route("/put_name/<name>",methods=['GET','POST'])
def setUser(name):
    
    if request.method == 'GET':
      resp = Response("Only POST method are allowed on this route")
      resp.status_code = 405
      return resp
    
    users_collection.insert_one({'name': name})
   
    body = {
      'users' : []
    }
    for user in users_collection.find({}):
      body['users'].append(user.get('name'))

    resp = Response(json.dumps(body,indent=2))

    return resp



@app.route("/get_users",methods=['GET'])
def getUser():
    body = {
      'users' : []
    }
    for user in users_collection.find({}):
      body['users'].append(user.get('name'))

    resp = Response(json.dumps(body,indent=2))

    return resp

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080, debug=False)
