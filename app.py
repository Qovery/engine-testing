
import os
import pymongo
import flask
import time

time.sleep(30)

client = pymongo.MongoReplicaSetClient(os.environ["QOVERY_DATABASE_MY_DDB_CONNECTION_URI"])
print("Mongo info:")
print(client.server_info())

app = flask.Flask()

@app.route("/")
def index():
    return f"It works"
