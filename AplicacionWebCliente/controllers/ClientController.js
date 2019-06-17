var json2html = require('node-json2html');
var db = require('../database')
const { poolPromise } = require('../database')
var t = {'<>':'tr','html':'${title} ${year}'};
    
var d = [
    {"title":"Heat","year":"1995"},
    {"title":"Snatch","year":"2000"},
    {"title":"Up","year":"2009"},
    {"title":"Unforgiven","year":"1992"},
    {"title":"Amadeus","year":"1984"}
];
    
var html = json2html.transform(d,t);

function transformDataWith(data,noMostrar=[],headers=[]) {
  var elems = []
  var headersHtml=` <thead><tr>`
  var headersHtmlEnd = `</tr> </thead><tbody>`
  var endTbody = '</tbody>'
  var t = {'<>':'tr','html':elems};
  if(headers.length>0){
    for(x in headers) {
      elems.push({'<>':'td','html':'${'+x+'}'})
      headersHtml+= '<th>'+x+'</th>';
    }
  }else{
    for(x in data[0]) {

      var noMuestra = noMostrar.includes(x)
      if(!noMuestra){
        elems.push({'<>':'td','html':'${'+x+'}'})
        headersHtml+= '<th>'+x+'</th>';
      } 
    }  
  }
  
  headersHtml+=headersHtmlEnd
  var html = headersHtml 
  html += json2html.transform(data,t);
  html += endTbody
  return html
}

exports.mainPage = function (req, res) {
  res.render('../views/login');;
};

exports.login = function (req, res) {
  if(req.body.name=="1"){
    res.render('../views/dashboardCliente');

  }
  if(req.body.name=="2"){
    res.render('../views/dashboardEmpleado');
  }else {
    res.render('../views/dashboardAdmin');
  }
  
};

exports.verCompras = async (req,res)=> {
  const pool = await poolPromise
  const result = await pool.request().query('SeleccionarFacturas NULL,NULL,NULL,NULL,NULL,NULL,NULL')
  console.log(result)
  var html = transformDataWith(result.recordset);
  res.render('../views/dashboardCliente',{
    resultadoTabla:html
});
};

exports.buscarVehiculosVentana = async (req,res)=> {
 
  res.render('../views/dashboardCliente',{
    buscarVehiculo:{}
  });

};


exports.buscarVehiculo = async (req,res) => {
  var body = req.body;
  var modelo = body.modelo
  var marca = body.marca
  var precioL = body.precioL
  var precioH = body.precioH
  var combustible = body.combustible
  var tipo =body.tipo

  const pool = await poolPromise
  const result = await pool.request().query(`seleccionarVehiculo NULL,NULL,NULL,NULL,NULL,NULL`)
  console.log(result.recordset)
  res.render('../views/dashboardCliente',{
                                dataVehiculo:result.recordset
  });
}
exports.comprarVehiculo = async (req,res) => {


}

exports.verSucursales = (req,res)=> {

};

