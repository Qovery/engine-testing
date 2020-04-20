
import os
import pymongo
import flask

client = pymongo.MongoReplicaSetClient(os.environ["QOVERY_DATABASE_MY_DDB_CONNECTION_URI"])
db_name = client.get_default_database().name

app = flask.Flask()

@app.route("/")
def index():
    return f"It works, database name is {db_name}"
