var json2html = require('node-json2html');
var db = require('../database')
var t = {'<>':'tr','html':'${title} ${year}'};
    
var d = [
    {"title":"Heat","year":"1995"},
    {"title":"Snatch","year":"2000"},
    {"title":"Up","year":"2009"},
    {"title":"Unforgiven","year":"1992"},
    {"title":"Amadeus","year":"1984"}
];
    
var html = json2html.transform(d,t);


exports.mainPage = function (req, res) {
  res.render('../views/login');;
};

exports.login = function (req, res) {
  res.render('../views/dashboardCliente');;
};

exports.verCompras = async (req,res)=> {
  var results = await db.executeQeury("SeleccionarFacturas NULL,NULL,NULL,NULL,NULL,NULL,NULL")
  
  res.html(results)
};

exports.buscarVehiculos = (req,res)=> {

};

exports.verSucursales = (req,res)=> {

};

