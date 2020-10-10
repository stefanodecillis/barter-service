const express = require("express");
const mongo = require("mongodb");
const bodyParser = require("body-parser");
const port = 3000;

// Connection URL
const url = "mongodb://root:barter@mongo:27017";

// Database Name
const dbName = "barter";

const app = express();
const jsonParser = bodyParser.json();

class User {
  constructor(firstname, lastname, email) {
    this.firstname = firstname;
    this.lastname = lastname;
    this.email = email;
    this.items = [];
  }

  isCorrect() {
    if (
      this.firstname == undefined ||
      this.lastname == undefined ||
      this.email == undefined
    ) {
      return false;
    }
    return true;
  }
}

class Item {
  constructor(title, description, imgUrl, owner) {
    this.title = title;
    this.owner = owner;
    this.description = description;
    this.imgUrl = imgUrl;
  }

  isCorrect() {
    if (
      this.title == undefined ||
      this.imgUrl == undefined ||
      this.owner == undefined ||
      this.description == undefined
    ) {
      return false;
    }
    return true;
  }
}

async function insertDB(collection, obj) {
  const db = await mongo.MongoClient.connect(url);
  var dbo = db.db(dbName);
  const res = await dbo.collection(collection).insertOne(obj);
  db.close();
  return res.ops[0]._id;
}

async function addItemToUser(userid, item) {
  const db = await mongo.MongoClient.connect(url);

  var dbo = db.db(dbName);
  var collection = dbo.collection("users");
  var myquery = { _id: mongo.ObjectID(userid) };
  var res_query = await collection.findOne(myquery);
  res_query.items.push(item);
  const res = await collection.updateOne(myquery, {
    $set: { items: res_query.items },
  });
  db.close();
}

mongo.MongoClient.connect(url, async function (err, client) {
  if (err) throw err;
  console.log("Connected successfully to mongodb");

  const db = client.db(dbName); //mongodb will create the database if not found!

  client.close();
});

// getting status of the backend
app.get("/status", (req, res) => {
  res.send("barter service is working smoothly!");
});

app.post("/api/items", jsonParser, (req, res) => {
  console.log(req.body);
  res.send(req.body);
});

app.post("/api/create/user", jsonParser, async (req, res) => {
  const user = new User(req.body.firstname, req.body.lastname, req.body.email);
  if (user.isCorrect()) {
    await insertDB("users", user)
      .then((id) => {
        res.sendStatus(200);
      })
      .catch((err) => {
        console.log(err);
        res.sendStatus(500);
      });
  }
});

app.post("/api/create/item", jsonParser, async (req, res) => {
  const item = new Item(
    req.body.title,
    req.body.description,
    req.body.imgUrl,
    req.body.owner
  );
  if (item.isCorrect()) {
    var item_id = await insertDB("items", item);
    addItemToUser(item.owner, item);
    res.sendStatus(200);
  }
});

app.listen(port, () => {
  console.log("server is listening on port 3000");
});
