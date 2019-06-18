var db = require('../database')
const poolPromise = require('../database')

//Pedido

exports.crearPedido = async (req, res) => {
  const body = req.body;
  if(body.estatusPedido === undefined || body.fecha === undefined || body.idEmpleado === undefined || body.idFabrica === undefined) {
    return res.json({status : -1, message : "Faltan parametros"});
  }
  else {
    const pool = await poolPromise;
    const query = await pool.request.query('InsertarPedido ' + body.estatusPedido + ',' + body.fecha + ',' + body.idEmpleado + ',' + body.idFabrica)
    //TODO
  }
};

exports.aprobarPedido = async (req, res) => {
  const body = req.body;
  if(body.idPedido === undefined) {
    return res.json({status : -1, message : "El ID es necesario"});
  }
  else {
    const pool = await poolPromise;
    const query = await pool.request.query('AprobarPedido ' + body.idPedido)
    //TODO
  }
};

//Facturar

exports.facturarCredito = async (req, res) => {
  const body = req.body;
  if(body.prima === undefined || body.idEmpleado === undefined || body.idVehiculo === undefined || body.idCliente === undefined || body.comentario === undefined || body.impuesto === undefined || body.descuento === undefined || body.tipoPago === undefined || body.tipoModalidad === undefined || body.subTotal === undefined || body.idSucursal === undefined) {
    return res.json({status : -1, message : "Informacion incompleta"});
  }
  else {
    const pool = await poolPromise;
    const query = await pool.request().query('FacturarCredito ' + body.prima + ',' + body.idEmpleado + ',' + body.idVehiculo + ',' + body.idCliente + ',' + body.comentario + ',' + body.impuesto + ',' + body.descuento + ',' + body.tipoPago + ',' + body.tipoModalidad + ',' + body.subTotal + ',' + body.idSucursal);
    //TODO
  }
};

exports.facturarContado = async (req, res) => {
  const body = req.body;
  if(body.idEmpleado === undefined || body.idVehiculo === undefined || body.idCliente === undefined || body.comentario === undefined || body.impuesto === undefined || body.descuento === undefined || body.tipoPago === undefined || body.tipoModalidad === undefined || body.subTotal === undefined || body.idSucursal === undefined) {
    return res.json({status : -1, message : "Informacion incompleta"});
  }
  else {
    const pool = await poolPromise;
    const query = await pool.request().query('FacturarCredito ' + body.idEmpleado + ',' + body.idVehiculo + ',' + body.idCliente + ',' + body.comentario + ',' + body.impuesto + ',' + body.descuento + ',' + body.tipoPago + ',' + body.tipoModalidad + ',' + body.subTotal + ',' + body.idSucursal);
    //TODO
  }
};

//Pago

exports.realizarPago = async (req, res) => {
  const body = req.body;
  if(body.idFactura === undefined || body.cantidad === undefined) {
    return res.json({status : -1, message : "Informacion incompleta"});
  }
  else {
    const pool = await poolPromise;
    const query = await pool.request().query('realizarPago ' + body.idFactura + ',' + body.cantidad);
    //TODO
  }
};
