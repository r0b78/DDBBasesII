var db = require('../database')
const poolPromise = require('../database')

exports.crearDescuento = async (req, res) => {
  const body = req.body;
  if(body.nombre === undefined || body.descuento === undefined) {
    return res.json({status : -1, message : "Faltan parametros"});
  }
  else {
    const pool = await poolPromise;
    try {
      const query = await pool.request.query('InsertarDescuento ' + body.nombre + ',' + body.descuento);
      //TODO
    }
    catch(error) {
      return res.json({status : -2, message : "Fallo al insertar"});
    }
  }
};

exports.verEmpleados = async (req, res) => {
  const body = req.body;
  var nombre = (body.nombre !== undefined) ? body.nombre : 'NULL';
  var apellido = (body.apellido !== undefined) ? body.apellido : 'NULL';
  var telefono = (body.telefono !== undefined) ? body.telefono : 'NULL';
  var correo = (body.correo !== undefined) ? body.correo : 'NULL';
  var supervisor = (body.supervisor !== undefined) ? body.supervisor : 'NULL';
  var puesto = (body.puesto !== undefined) ? body.puesto : 'NULL';
  var sucursal = (body.sucursal !== undefined) ? body.sucursal : 'NULL';
  var cedula = (body.cedula !== undefined) ? body.cedula : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request.query('seleccionarEmpleado ' + nombre + ',' + apellido + ',' + telefono + ',' + correo + ',' + supervisor + ',' + puesto + ',' + sucursal + ',' + cedula + ',');
  //TODO
};

exports.crearEmpleado = async (req, res) => {
  const body = req.body;
  if( body.nombre === undefined || body.apellido === undefined || body.telefono === undefined || body.correo === undefined ||
      body.puesto === undefined || body.sucursal === undefined || body.cedula === undefined || body.idUsuario === undefined) {
        return res.json({status : -1, message : "Faltan parametros"});
      }
  else {
    var supervisor = (body.supervisor !== undefined) ? body.supervisor : 'NULL';
    const pool = await poolPromise;
    const query = await pool.request.query('insertarEmpleado ' + body.nombre + ',' + body.apellido + ',' + body.telefono + ',' + body.correo + ',' + supervisor + ',' + body.puesto + ',' + body.sucursal + ',' + body.cedula + ',' + body.idUsuario);
    //TODO
  }
}

exports.verVehiculos = async (req, res) => {
  const body = req.body;
  var tipo = (body.tipo !== undefined) ? body.tipo : 'NULL';
  var combustible = (body.combustible !== undefined) ? body.combustible : 'NULL';
  var marca = (body.marca !== undefined) ? body.marca : 'NULL';
  var modelo = (body.modelo !== undefined) ? body.modelo : 'NULL';
  var precioLow = (body.precioLow !== undefined) ? body.precioLow : 'NULL';
  var precioHigh = (body.precioHigh !== undefined) ? body.precioHigh : 'NULL';
  var usado = (body.usado !== undefined) ? body.usado : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request.query('seleccionarVehiculo ' + tipo + ',' + combustible + ',' + marca + ',' + modelo + ',' + precioLow + ',' + precioHigh + ',' + usado);
  //TODO
};

exports.verVehiculosComprado = async (req, res) => {
  const body = req.body;
  var tipo = (body.tipo !== undefined) ? body.tipo : 'NULL';
  var combustible = (body.combustible !== undefined) ? body.combustible : 'NULL';
  var marca = (body.marca !== undefined) ? body.marca : 'NULL';
  var modelo = (body.modelo !== undefined) ? body.modelo : 'NULL';
  var precioLow = (body.precioLow !== undefined) ? body.precioLow : 'NULL';
  var precioHigh = (body.precioHigh !== undefined) ? body.precioHigh : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request.query('seleccionarVehiculoComprado ' + tipo + ',' + combustible + ',' + marca + ',' + modelo + ',' + precioLow + ',' + precioHigh + ',');
  //TODO
};

exports.crearVehiculo = async (req, res) => {
  const body = req.body;
  if(body.tipo === undefined || body.combustible === undefined || body.marca === undefined || body.modelo === undefined || body.precio === undefined) {
    return res.json({status : -1, message : "Faltan parametros"});
  }
  else {
    const pool = await poolPromise;
    const query = await pool.request.query('insertarVehiculo ' + body.tipo + ',' + body.combustible + ',' + body.marca + ',' + body.modelo + ',' + body.precio);
    //TODO
  }
}

exports.vehiculoFabrica = async (req, res) => {
  const body = req.body;
  var idVehiculoFabrica = (body.idVehiculoFabrica !== undefined) ? body.idVehiculoFabrica : 'NULL';
  var idVehiculo = (body.idVehiculo !== undefined) ? body.idVehiculo : 'NULL';
  var costoVehiculo = (body.costoVehiculo !== undefined) ? body.costoVehiculo : 'NULL';
  var idInventario = (body.idInventario !== undefined) ? body.idInventario : 'NULL';
  var idFabrica = (body.idFabrica !== undefined) ? body.idFabrica : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request.query('SeleccionarVehiculoFabrica ' + idVehiculoFabrica + ',' + idVehiculo + ',' + costoVehiculo + ',' + idInventario + ',' + idFabrica);
  //TODO
};

exports.verSucursales = async (req, res) => {
  const body = req.body;
  var nombre = (body.nombre !== undefined) ? body.nombre : 'NULL';
  var descripcion = (body.descripcion !== undefined) ? body.descripcion : 'NULL';
  var idUbicacion = (body.idUbicacion !== undefined) ? body.idUbicacion : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request.query('seleccionarSucursal ' + nombre + ',' + descripcion + ',' + idUbicacion);
  //TODO
}

exports.reporteVentas = async (req, res) => {
  const body = req.body;
  var idFactura = (body.idFactura !== undefined) ? body.idFactura : 'NULL';
  var numeroFactura = (body.numeroFactura !== undefined) ? body.numeroFactura : 'NULL';
  var precioInicial = (body.precioInicial !== undefined) ? body.precioInicial : 'NULL';
  var precioFinal = (body.precioFinal !== undefined) ? body.precioFinal : 'NULL';
  var fechaInicial = (body.fechaInicial !== undefined) ? body.fechaInicial : 'NULL';
  var fechaFinal = (body.fechaFinal !== undefined) ? body.fechaFinal : 'NULL';
  var tipoPago = (body.tipoPago !== undefined) ? body.tipoPago : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request.query('SeleccionarFacturas ' + idFactura + ',' + numeroFactura + ',' + precioInicial + ';' + precioFinal + ',' + fechaInicial + ',' + fechaFinal + ',' + tipoPago)
  //TODO
};

exports.empleadosFabrica = async (req, res) => {
  const body = req.body;
  var nombre = (body.nombre !== undefined) ? body.nombre : 'NULL';
  var apellido = (body.apellido !== undefined) ? body.apellido : 'NULL';
  var telefono = (body.telefono !== undefined) ? body.telefono : 'NULL';
  var correo = (body.correo !== undefined) ? body.correo : 'NULL';
  var supervisor = (body.supervisor !== undefined) ? body.supervisor : 'NULL';
  var puesto = (body.puesto !== undefined) ? body.puesto : 'NULL';
  var sucursal = (body.sucursal !== undefined) ? body.sucursal : 'NULL';
  var cedula = (body.cedula !== undefined) ? body.cedula : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request.query('seleccionarEmpleado ' + nombre + ',' + apellido + ',' + telefono + ',' + correo + ',' + supervisor + ',' + puesto + ',' + sucursal + ',' + cedula + ',');
  //TODO
};
