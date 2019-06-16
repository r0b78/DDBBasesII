var express = require('express');
var app = express();
var json2html = require('node-json2html');
var client = require('./controllers/ClientController')
var bodyParser=require('body-parser')
app.set("view engine","ejs")
app.use(express.static('public'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:true}));


app.get('/', client.mainPage);

app.post('/login', client.login);





app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});