var express = require('express');
var app = express();
var json2html = require('node-json2html');
var client = require('./controllers/ClientController')
var admin = require('./controllers/AdminController')
var empleado = require('./controllers/EmpleadoController')
var bodyParser=require('body-parser')
app.set("view engine","ejs")

app.use(express.static('public'));

app.use(bodyParser.urlencoded({
  extended: true
}));
app.use(bodyParser.json());

app.get('/',function(req,res){
    res.redirect('/login');
})
app.get('/login', client.mainPage);
app.post('/login', client.login);

//Cliente

app.get('/verCompras',client.verCompras)
app.get('/buscarVehiculos',client.buscarVehiculos)
app.get('/verSucursales',client.verSucursales)

//Admin





app.listen(3000, function () {
  console.log('Servidor iniciado');
});
