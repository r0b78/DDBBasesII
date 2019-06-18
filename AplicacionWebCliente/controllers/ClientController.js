var db = require('../database')
const { poolPromise } = require('../database')
var cookieParser = require('cookie-parser');


function transformDataWith(data,noMostrar=[],headers=[]) {
  var json2html = require('node-json2html');
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

exports.login = async(req, res)=> {
  var name = req.body.name
  var password = req.body.password
  console.log(name)
  console.log(password)
  const pool = await poolPromise
  const result = await pool.request().query('loginUsuario '+name+','+password)
  const objectoCliente= result.recordset
  console.log(objectoCliente)

  if(objectoCliente[0].Privilegio === 'Cliente') {
    res.cookie('IdUsuario' ,''+objectoCliente.IdUsuario );
    res.render('../views/dashboardCliente');
    return
  }
  if(objectoCliente[0].Privilegio === 'Administrador') {
    res.cookie('IdUsuario' ,''+objectoCliente.IdUsuario );
    res.render('../views/dashboardAdmin');
    return
  }
  if(objectoCliente[0].Privilegio === 'Empleado'){
    res.cookie('IdUsuario' ,''+objectoCliente.IdUsuario );
    res.render('../views/dashboardEmpleado');
    return
  }else {
    res.send('Usuario No Valido')
  }

};

exports.verCompras = async (req,res)=> {
  const pool = await poolPromise
  const result = await pool.request().query('SeleccionarFacturas NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL')
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
  const result = await pool.request().query(`seleccionarVehiculo NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL`)
  console.log(result.recordset)
  res.render('../views/dashboardCliente',{
                                dataVehiculo:result.recordset
  });
}
exports.verCompraVehiculo = async(req,res) => {
  var IDVehiculo = req.params.id
  const pool = await poolPromise
  const result = await pool.request().query('seleccionarVehiculo2 '+IDVehiculo)
  res.render('../views/dashboardCliente',{
    compraVehiculo:result.recordset
  });
}



exports.comprarVehiculo = async (req,res) => {
  var IDVehiculo = req.params.id
  var IDCliente = ""
  var comentario =  ""
  var subtotal = ""
  var impuesto = ""
  var descuento = ""
  var tipoPago = ""
  var modalidad = ""

}

exports.comprar = async(req, res) => {
  const body = req.body;
  if(body.idVehiculo === undefined || body.idCliente === undefined || body.comentario === undefined || body.impuesto === undefined || body.descuento === undefined || body.tipoPago === undefined || body.tipoModalidad === undefined) {
    return res.json({status : -1, message : "Informacion incompleta"});
  }
  else {
    const pool = await poolPromise;
    const query = await pool.request.query('Comprar ' + body.idVehiculo + ',' + body.idCliente + ',' + body.comentario + ',' + body.impuesto + ',' + body.descuento + ',' + body.tipoPago + ',' + body.tipoModalidad);
    //TODO
  }
}

exports.verSucursales = (req,res)=> {

};
