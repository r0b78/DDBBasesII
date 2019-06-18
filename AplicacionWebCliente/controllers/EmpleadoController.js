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

//CRUD Clientes

exports.crearCliente = async (req, res) => {
  const body = req.body;
  if(body.fecha === undefined || body.password === undefined || body.cedula === undefined || body.nombre === undefined ||  body.apellido === undefined || body.telefono === undefined || body.correo === undefined || body.locacion === undefined || body.descripcion === undefined || body.provincia === undefined) {
    return res.json({status : -1, message : "Informacion incompleta"});
  }
  else {
    const pool = await poolPromise;
    const query = await pool.request().query('InsertarCliente ' + body.fecha + ',' + body.password + ',' + body.cedula + ',' + body.nombre + ',' + body.apellido + ',' + body.telefono + ',' + body.correo + ',' + body.locacion + ',' + body.descripcion + ',' + body.provincia);
    //TODO
  }
};

exports.modificarCliente = async (req, res) => {
  const body = req.body;
  if(body.idCliente === undefined) {
    return res.json({status : -1, message : "Informacion incompleta"});
  }
  else {
    var nombre = (body.nombre !== undefined) ? body.nombre : 'NULL';
    var apellido = (body.apellido !== undefined) ? body.apellido : 'NULL';
    var telefono = (body.telefono !== undefined) ? body.telefono : 'NULL';
    var correo = (body.correo !== undefined) ? body.correo : 'NULL';
    const pool = await poolPromise;
    const query = await pool.request().query('ActualizarCliente ' + body.idCliente + ',' + nombre + ',' + apellido + ',' + telefono + ',' + correo);
    //TODO
  }
};

exports.seleccionarClientes = async (req, res) => {
  const body = req.body;
  var nombre = (body.nombre !== undefined) ? body.nombre : 'NULL';
  var apellido = (body.apellido !== undefined) ? body.apellido : 'NULL';
  var telefono = (body.telefono !== undefined) ? body.telefono : 'NULL';
  var correo = (body.correo !== undefined) ? body.correo : 'NULL';
  var provincia = (body.provincia !== undefined) ? body.provincia : 'NULL';
  var pais = (body.pais !== undefined) ? body.pais : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request().query('SeleccionarClientes ' + nombre + ',' + apellido + ',' + telefono + ',' + correo + ',' + provincia + ',' + pais);
  //TODO
};
