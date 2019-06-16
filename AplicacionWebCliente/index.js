var express = require('express');
var app = express();
var json2html = require('node-json2html');
var client = require('./controllers/ClientController')
var bodyParser=require('body-parser')
app.set("view engine","ejs")
app.use(express.static('public'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:true}));

app.get('/',function(req,res){
    res.redirect('/login');
})
app.get('/login', client.mainPage);
app.get('/verCompras',client.verCompras)
app.get('/buscarVehiculos',client.buscarVehiculos)
app.get('/verSucursales',client.verSucursales)
app.post('/login', client.login);





app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});
