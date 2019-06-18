var db = require('../database')
const poolPromise = require('../database')

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
}

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

exports.facturar = async (req, res) => {
  const body = req.body;
  if(body.idFactura === undefined || body.idEmpleado === undefined) {
    return res.json({status : -1, message : "Informacion incompleta"});
  }
  else {
    const pool = await poolPromise;
    const query = await pool.request.query('Facturar ' + body.idFactura + ',' + body.idEmpleado);
    //TODO
  }
};
