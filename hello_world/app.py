from flask import Flask
from flask import Response
from redis import StrictRedis

app = Flask(__name__)
bdd = StrictRedis(host="redis", port=6379, db=0, decode_responses=True)


@app.route("/")
def hello_world():
    counter = int(bdd.get("counter"))
    counter += 1
    bdd.set("counter", counter)

    resp = Response("Hello World! {} visites".format(counter))

    return resp


if __name__ == "__main__":
    if bdd.get("counter") == None:
        bdd.set("counter", 0)
    app.run(host="0.0.0.0", port=8080, debug=False)
