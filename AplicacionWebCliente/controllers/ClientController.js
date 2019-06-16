var json2html = require('node-json2html');

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
