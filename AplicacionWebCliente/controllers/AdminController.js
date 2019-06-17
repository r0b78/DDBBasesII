var db = require('../database');
const poolPromise = require('../database');

//CRUD Sucursal

exports.crearSucursal = async (req, res) => {
  const body = req.body;

  if( body.descripcion === undefined ||
      body.locacion === undefined ||
      body.idProvincia === undefined ||
      body.nombre === undefined ||
      body.senas === undefined) {
      return res.json({status : -1, message : "Faltan parametros"});
  }
  else {
    const pool = await poolPromise;
    const query = await pool.request.query('insertarUbicacion ' + body.senas + ',' + body.locacion + ',' + body.idProvincia);
    var idUbicacion = query.recordset.idUbicacion;
    const poolSucursal = await poolPromise;
    const querySucursal = await poolSucursal.request.query('insertarSucursal ' + body.nombre + ',' + body.descripcion + ','+ idUbicacion);
    res.render('../views/dashboardAdmin',{ listo: 'Transaccion Existosa' });
  }
};

exports.vistaAgregarSucursal = (req,res) =>{
  res.render('../views/dashboardAdmin.ejs',{vistaSucursal:{}});
}

exports.mostrarVistaSucursal = async(req,res) => {

  res.render('../views/dashboardAdmin', {vistaSucursal:{}});
}

exports.verSucursales = async (req, res) => {
  const body = req.body;
  var nombre = (body.nombre !== undefined) ? body.nombre : 'NULL';
  var descripcion = (body.descripcion !== undefined) ? body.descripcion : 'NULL';
  var provincia = (body.provincia !== undefined) ? body.provincia : 'NULL';
  var pais = (body.pais !== undefined) ? body.pais : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request.query('seleccionarSucursal ' + nombre + ',' + descripcion + ',' + provincia + ',' + pais);
  //TODO
}

exports.modificarSucursal = async (req, res) => {
  const body = req.body;
  if(body.nombre === undefined) {
    return res.json({status : -1, message : "Es necesario el nombre"});
  }
  else {
    var nuevoNombre = (body.nuevoNombre !== undefined) ? body.nuevoNombre : 'NULL';
    var descripcion = (body.descripcion !== undefined) ? body.descripcion : 'NULL';
    var idUbicacion = (body.idUbicacion !== undefined) ? body.idUbicacion : 'NULL';
    const pool = await poolPromise;
    const query = await pool.request.query('modificarSucursal ' + body.nombre + ',' + body.nuevoNombre + ',' + body.idUbicacion);
    //TODO
  }
}

//CRUD Fabrica

exports.crearFabrica = async (req, res) => {
  const body = req.body;
  if(body.descripcion === undefined || body.provincia === undefined || body.locacion === undefined || body.senas === undefined) {
    return res.json({status : -1, message : "Falta informacion"});
  }
  else {
    const pool = await poolPromise;
    const query = await pool.request.query('insertarUbicacion ' + body.senas + ',' + body.locacion + ',' + body.idProvincia);
    var idUbicacion = query.recordset.idUbicacion;
    const poolFabrica = await poolPromise;
    const queryFabrica = await pool.request.query('InsertarFabrica ' +  body.descripcion + ',' + idUbicacion);
    //TODO
  }
};

exports.modificarFabrica = async (req, res) => {
  const body = req.body;
  if(body.idFabrica === undefined) {
    return res.json({status : -1, message : "Falta informacion"});
  }
  else {
    var descripcion = (body.descripcion !== undefined) ? body.descripcion : 'NULL';
    var idUbicacion = (body.idUbicacion !== undefined) ? body.idUbicacion : 'NULL';
    const pool = await poolPromise;
    const query = await pool.request.query('ModificarFabrica ' + body.idFabrica + ',' + descripcion + ',' + idUbicacion);
    //TODO
  }
};

exports.seleccionarFabrica = async (req, res) => {
  const body = req.body;
  var idFabrica = (body.idFabrica !== undefined) ? body.idFabrica : 'NULL';
  var descripcion = (body.descripcion !== undefined) ? body.descripcion : 'NULL';
  var nombreProvincia = (body.nombreProvincia !== undefined) ? body.nombreProvincia : 'NULL';
  var nombrePais = (body.nombrePais !== undefined) ? body.nombrePais : 'NULL';
  var idUbicacion = (body.idUbicacion !== undefined) ? body.idUbicacion : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request.query('SeleccionarFabrica ' + idFabrica + ',' + descripcion + ',' + nombreProvincia + ',' + nombrePais + ',' + idUbicacion);
  //TODO
};

//CRUD vehiculo

exports.crearVehiculo = async (req, res) => {
  const body = req.body;
  if(body.tipo === undefined || body.combustible === undefined || body.marca === undefined || body.modelo === undefined || body.precio === undefined || body.usado === undefined || body.puertas === undefined) {
    return res.json({status : -1, message : "Faltan parametros"});
  }
  else {
    const pool = await poolPromise;
    const query = await pool.request.query('insertarVehiculo ' + body.tipo + ',' + body.combustible + ',' + body.marca + ',' + body.modelo + ',' + body.precio + ',' + body.usado + ',' + body.puertas);
    //TODO
  }
}

exports.modificarVehiculo = async (req, res) => {
  const body = req.body;
  if(body.idVehiculo === undefined) {
    return res.json({status : -1, message : "Es necesario el ID"});
  }
  else {
    var tipo = (body.tipo !== undefined) ? body.tipo : 'NULL';
    var combustible = (body.combustible !== undefined) ? body.combustible : 'NULL';
    var marca = (body.marca !== undefined) ? body.marca : 'NULL';
    var modelo = (body.modelo !== undefined) ? body.modelo : 'NULL';
    var precio = (body.precio !== undefined) ? body.precio : 'NULL';
    var puertas = (body.puertas !== undefined) ? body.puertas : 'NULL';
    const pool = await poolPromise;
    const query = await pool.request.query('modificarVehiculo ' + tipo + ',' + combustible + ',' + marca + ',' + modelo + ',' + precio + ',' + puertas);
    //TODO
  }
};

exports.verVehiculos = async (req, res) => {
  const body = req.body;
  var tipo = (body.tipo !== undefined) ? body.tipo : 'NULL';
  var combustible = (body.combustible !== undefined) ? body.combustible : 'NULL';
  var marca = (body.marca !== undefined) ? body.marca : 'NULL';
  var modelo = (body.modelo !== undefined) ? body.modelo : 'NULL';
  var precioLow = (body.precioLow !== undefined) ? body.precioLow : 'NULL';
  var precioHigh = (body.precioHigh !== undefined) ? body.precioHigh : 'NULL';
  var usado = (body.usado !== undefined) ? body.usado : 'NULL';
  var puertas = (body.puertas !== undefined) ? body.puertas : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request.query('seleccionarVehiculo ' + tipo + ',' + combustible + ',' + marca + ',' + modelo + ',' + precioLow + ',' + precioHigh + ',' + usado + ',' + puertas);
  //TODO
};

//CRUD Extras

exports.crearExtra = async (req, res) => {
  const body = req.body;
  if(body.descripcion === undefined || body.nombre === undefined || body.precio === undefined) {
    return res.json({status : -1, message : "Informacion incompleta"});
  }
  else {
    const pool = await poolPromise;
    const query = await pool.request.query('insertarExtra ' + body.nombre + ',' + body.descripcion + ',' + body.precio);
    //TODO
  }
};

exports.modificarExtra = async (req, res) => {
  const body = req.body;
  var nombre = (body.nombre !== undefined) ? body.nombre : 'NULL';
  var descripcion = (body.descripcion !== undefined) ? body.descripcion : 'NULL';
  var nuevoNombre = (body.nuevoNombre !== undefined) ? body.nuevoNombre : 'NULL';
  var precio = (body.precio !== undefined) ? body.precio : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request.query('modificarExtra ' + nombre + ',' + nuevoNombre + ',' + descripcion + ',' + precio);
  //TODO
};

exports.selecionarExtra = async (req, res) => {
  const body = req.body;
  var nombre = (body.nombre !== undefined) ? body.nombre : 'NULL';
  var descripcion = (body.descripcion !== undefined) ? body.descripcion : 'NULL';
  var precio = (body.precio !== undefined) ? body.precio : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request.query('modificarExtra ' + nombre + ',' + descripcion + ',' + precio);
  //TODO
};

exports.insertarExtraVehiculo = async (req, res) => {
  const body = req.body;
  if(body.idExtra === undefined || body.idVehiculo === undefined) {
    return res.json({status : -1, message : "Informacion incompleta"});
  }
  else {
    const pool = await poolPromise;
    const query = await pool.request.query('insertarExtraXVehiculo ' + body.idExtra + ',' + body.idVehiculo);
    //TODO
  }
};

exports.seleccionarExtraVehiculo = async (req, res) => {
  const body = req.body;
  var idExtra = (body.idExtra !== undefined) ? body.idExtra : 'NULL';
  var idVehiculo = (body.idVehiculo !== undefined) ? body.idVehiculo : 'NULL';
  var precioLow = (body.precioLow !== undefined) ? body.precioLow : 'NULL';
  var precioHigh = (body.precioHigh !== undefined) ? body.precioHigh : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request.query('seleccionarExtraXVehiculo ' + idExtra + ',' + idVehiculo + ',' + precioLow + ',' + precioHigh);
  //TODO
};

//CRUD Caracteristicas

exports.crearCaracteristica = async (req, res) => {
  const body = req.body;
  if(body.caracteristica === undefined || body.dato === undefined) {
    return res.json({status : -1, message : "Informacion incompleta"});
  }
  else {
    const pool = await poolPromise;
    const query = await pool.request.query('insertarCaracteristica ' + body.caracteristica + ',' + body.dato);
    //TODO
  }
};

exports.modificarCaracteristica = async (req, res) => {
  const body = req.body;
  if(body.dato === undefined) {
    return res.json({status : -1, message : "Informacion incompleta"});
  }
  else {
    var nuevoDato = (body.nuevoDato !== undefined) ? body.nuevoDato : 'NULL';
    var caracteristica = (body.caracteristica !== undefined) ? body.caracteristica : 'NULL';
    const pool = await poolPromise;
    const query = await pool.request.query('modificarCaracteristica ' + body.dato + ',' + body.nuevoDato + ',' + body.caracteristica);
    //TODO
  }
};

exports.seleccionarCaracteristica = async (req, res) => {
  const body = req.body;
  var caracteristica = (body.caracteristica !== undefined) ? body.caracteristica : 'NULL';
  var dato = (body.dato !== undefined) ? body.dato : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request.query('seleccionarCaracteristica ' + caracteristica + ',' + dato);
  //TODO
}

exports.insertarCaracteristicaVehiculo = async (req, res) => {
  const body = req.body;
  if(body.idCaracteristica === undefined || body.idVehiculo === undefined) {
    return res.json({status : -1, message : "Informacion incompleta"});
  }
  else {
    const pool = await poolPromise;
    const query = await pool.request.query('insertarCaracteristicaXVehiculo ' + body.idCaracteristica + ',' + body.idVehiculo);
    //TODO
  }
};

exports.seleccionarCaracteristicaVehiculo = async (req, res) => {
  const body = req.body;
  var idCaracteristica = (body.idCaracteristica !== undefined) ? body.idCaracteristica : 'NULL';
  var idVehiculo = (body.idVehiculo !== undefined) ? body.idVehiculo : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request.query('seleccionarCaracteristicaXVehiculo ' + idCaracteristica + ',' + idVehiculo);
  //TODO
};

//Inventario Sucursal

exports.insertarVehiculoSucursal = async (req, res) => {
  const body = req.body;
  if(body.idVehiculo === undefined || body.idSucursal === undefined) {
    return res.json({status : -1, message : "Faltan parametros"});
  }
  else {
    var idVehiculo = (body.idVehiculo !== undefined) ? body.idVehiculo : 'NULL';
    var idSucursal = (body.idSucursal !== undefined) ? body.idSucursal : 'NULL';
    const pool = await poolPromise;
    const query = await pool.request.query('insertarVehiculoXSucursal ' + body.idVehiculo + ',' + body.idSucursal);
    //TODO
  }
};

exports.seleccionarVehiculoSucursal = async (req, res) => {
  const body = req.body;
  var idVehiculo = (body.idVehiculo !== undefined) ? body.idVehiculo : 'NULL';
  var idSucursal = (body.idSucursal !== undefined) ? body.idSucursal : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request.query('seleccionarVehiculoXSucursal ' + body.idVehiculo + ',' + body.idSucursal);
  //TODO
}

exports.modificarVehiculoSucursal = async(req, res) => {
  const body = req.body;
  if(body.idVehiculoXSucursal == undefined) {
    return res.json({status : -1, message : "Faltan parametros"});
  }
  else {
    var idSucursal = (body.idSucursal !== undefined) ? body.idSucursal : 'NULL';
    var idVehiculo = (body.idVehiculo !== undefined) ? body.idVehiculo : 'NULL';
    const pool = await poolPromise;
    const query = await pool.request.query('modificarVehiculoXSucursal ' + body.idVehiculoXSucursal + ',' + idSucursal + ',' + idVehiculo);
    //TODO
  }
};

//Aun no se que es

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

exports.modificarEmpleado = async (req, res) => {
  const body = req.body;
  if(body.cedula === undefined) {
    return res.json({status : -1, message : "Es necesaria la cedula"});
  }
  else {
    var nombre = (body.nombre !== undefined) ? body.nombre : 'NULL';
    var apellido = (body.apellido !== undefined) ? body.apellido : 'NULL';
    var telefono = (body.telefono !== undefined) ? body.telefono : 'NULL';
    var correo = (body.correo !== undefined) ? body.correo : 'NULL';
    var supervisor = (body.supervisor !== undefined) ? body.supervisor : 'NULL';
    var puesto = (body.puesto !== undefined) ? body.puesto : 'NULL';
    var sucursal = (body.sucursal !== undefined) ? body.sucursal : 'NULL';
    const pool = await poolPromise;
    const query = await pool.request.query('modificarEmpleado ' + body.nombre + ',' + body.apellido + ',' + body.telefono + ',' + body.correo + ',' + supervisor + ',' + body.puesto + ',' + body.sucursal + ',' + body.cedula);
    //TODO
  }
};

exports.verVehiculosComprados = async (req, res) => {
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
