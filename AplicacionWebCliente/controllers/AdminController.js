var db = require('../database');
const { poolPromise } = require('../database')
var t = require('../controllers/utils')
//CRUD Sucursal

exports.crearSucursal = async (req, res) => {
  const body = req.body;
  console.log(body)
  if( body.descripcion === undefined ||
      body.locacion === undefined ||
      body.idProvincia === undefined ||
      body.nombre === undefined ||
      body.senas === undefined) {
      res.send({status : -1, message : "Faltan parametros"});
      return
  }
  else {

    var location = "'POINT("+body.locacion+")'"
    const pool = await poolPromise;
    const query = await pool.request().query('insertarUbicacion ' +
    body.senas + ',' +
    location + ',' +
    body.idProvincia);
    var idUbicacion = query.recordset[0].IdUbicacion;
    const poolSucursal = await poolPromise;
    const querySucursal = await poolSucursal.request().query('insertarSucursal ' +
      body.nombre + ',' +
      body.descripcion + ','+
      idUbicacion);

    res.render('../views/dashboardAdmin',{ listo: 'Transaccion Existosa' });
  }
};

exports.vistaAgregarSucursal = (req,res) =>{
  res.render('../views/dashboardAdmin.ejs',{crearSucursal:{}});
}

exports.mostrarVistaSucursal = async(req,res) => {

  res.render('../views/dashboardAdmin', {vistaSucursal:{}});
}

exports.verSucursales = async (req, res) => {
  const body = req.body;
  var nombre = (body.nombre !== '') ? body.nombre : 'NULL';
  var descripcion = (body.descripcion !== '') ? body.descripcion : 'NULL';
  var provincia = (body.provincia !== '') ? body.provincia : 'NULL';
  var pais = (body.pais !== '') ? body.pais : 'NULL';
  const pool = await poolPromise;
  console.log(body)
  console.log(nombre + ',' + descripcion + ',' + provincia + ',' + pais)
  const query = await pool.request().query('seleccionarSucursal '
                                + nombre + ','
                                + descripcion + ','
                                + provincia + ','
                                + pais);
  const results = query.recordset
  const html = t.transformDataWith(results)
  res.render('../views/dashboardAdmin.ejs',{results:html});
}

exports.vistaModificarSucursal = async(req,res) => {
  res.render('../views/dashboardAdmin.ejs',{vistaModificarSucursal:{}});
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
    const query = await pool.request.query('modificarSucursal ' +
    body.nombre + ',' +
    body.nuevoNombre + ',' +
    body.idUbicacion);
    res.render('../views/dashboardAdmin',{ listo: 'Transaccion Existosa' });

  }
}

//CRUD Fabrica
exports.vistaCrearFabrica = async(req,res) => {
  res.render('../views/dashboardAdmin.ejs',{vistaCrearFabrica:{}});
}
exports.vistaModificarFabrica = async(req,res) => {
  res.render('../views/dashboardAdmin.ejs',{vistaModificarFabrica:{}});
}



exports.crearFabrica = async (req, res) => {
  const body = req.body;
  if(body.descripcion === undefined ||
     body.provincia === undefined ||
     body.locacion === undefined ||
     body.senas === undefined) {
    return res.json({status : -1, message : "Falta informacion"});
  }
  else {
    const pool = await poolPromise;
    var location = "'POINT("+body.locacion+")'"
    const query = await pool.request().query('insertarUbicacion ' + body.senas + ',' + body.locacion + ',' + body.idProvincia);
    var idUbicacion = query.recordset[0].idUbicacion;
    const poolFabrica = await poolPromise;
    const queryFabrica = await pool.request.query('InsertarFabrica ' +  body.descripcion + ',' + idUbicacion);
    res.render('../views/dashboardAdmin',{ listo: 'Transaccion Existosa' });

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
  const query = await pool.request().query('SeleccionarFabrica ' + idFabrica + ',' + descripcion + ',' + nombreProvincia + ',' + nombrePais + ',' + idUbicacion);
  const results = query.recordset
  const html = t.transformDataWith(results)
  res.render('../views/dashboardAdmin.ejs',{results:html});

};

//CRUD vehiculo
exports.vistaCrearVehiculo = (req,res) => {
  res.render('../views/dashboardAdmin.ejs',{vistaCrearVehiculo:{}});
}

exports.vistaModificarVehiculo = (req,res) => {
  res.render('../views/dashboardAdmin.ejs',{vistaModificarVehiculo:{}});
}
exports.vistaVerVehiculo = (req,res) => {
  res.render('../views/dashboardAdmin.ejs',{vistaVerVehiculo:{}});
}

exports.crearVehiculo = async (req, res) => {
  const body = req.body;
  if(body.tipo === undefined ||
    body.combustible === undefined ||
    body.marca === undefined ||
    body.modelo === undefined ||
     body.precio === undefined ||
     body.usado === undefined ||
     body.puertas === undefined) {
    return res.json({status : -1, message : "Faltan parametros"});
  }
  else {
    var bit = 'false';
    if(body.usado == 'Usado'){
      bit= 'true'
    }
    console.log(body)

    const pool = await poolPromise;
    const query = await pool.request().query('insertarVehiculo '
        + body.tipo + ','
        + body.combustible + ','
        + body.marca + ','
        + body.modelo + ','
        + body.precio + ','
        + bit + ','
        + body.puertas);
        console.log(query.recordset.length)
      if(query.recordset.length==1){
          res.render('../views/dashboardAdmin.ejs',{listo:query.recordset[0].Error});
      }
      else {
        res.render('../views/dashboardAdmin',{ listo: 'Transaccion Existosa' });

      }

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
  const query = await pool.request().query('seleccionarVehiculo ' + tipo + ',' + combustible + ',' + marca + ',' + modelo + ',' + precioLow + ',' + precioHigh + ',' + usado + ',' + puertas);
  const results = query.recordset
  const html = t.transformDataWith(results)
  res.render('../views/dashboardAdmin.ejs',{results:html});

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
};

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
};

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

//CRUD Consignacion

exports.crearConsignacion = async (req, res) => {
  const body = req.body;
  if(body.idCliente === undefined || body.idVehiculo === undefined || body.ganancia === undefined) {
    return res.json({status : -1, message : "Faltan parametros"});
  }
  else {
    const pool = await poolPromise;
    const query = await pool.request().query('insertarConsignacion ' + body.idCliente + ',' + body.idVehiculo + ',' + body.ganancia);
    //TODO
  }
};

exports.modificarConsignacion = async (req, res) => {
  const body = req.body;
  if(body.idConsignacion === undefined) {
    return res.json({status : -1, message : "Faltan parametros"});
  }
  else {
    var idCliente = (body.idCliente !== undefined) ? body.idCliente : 'NULL';
    var idVehiculo = (body.idVehiculo !== undefined) ? body.idVehiculo : 'NULL';
    var ganancia = (body.ganancia !== undefined) ? body.ganacia : 'NULL';
    const pool = await poolPromise;
    const query = await pool.request().query('modificarConsignacion ' + body.idConsignacion + ',' + idCliente + ',' + idVehiculo + ',' + ganacia);
    //TODO
  }
}

exports.seleccionarConsignacion = async (req, res) => {
  const body = req.body;
  var idConsignacion = (body.idConsignacion !== undefined) ? body.idConsignacion : 'NULL';
  var cedulaCliente = (body.cedulaCliente !== undefined) ? body.cedulaCliente : 'NULL';
  var idVehiculo = (body.idVehiculo !== undefined) ? body.idVehiculo : 'NULL';
  var gananciaLow = (body.gananciaLow !== undefined) ? body.gananciaLow : 'NULL';
  var gananciaHigh = (body.gananciaHigh !== undefined) ? body.gananciaHigh : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request().query('seleccionarConsignacion ' + idConsignacion + ',' + cedulaCliente + ',' + idVehiculo + ',' + gananciaLow + ',' + gananciaHigh);
  //TODO
};

//CRUD Comision

exports.modificarComision = async (req, res) => {
  const body = req.body;
  if(body.idComision === undefined) {
    return res.json({status : -1, message : "Faltan parametros"});
  }
  else {
    var idFactura = (body.idFactura !== undefined) ? body.idFactura : 'NULL';
    var idEmpleado = (body.idEmpleado !== undefined) ? body.idEmpleado : 'NULL';
    var comision = (body.comision !== undefined) ? body.comision : 'NULL';
    const pool = await poolPromise;
    const query = await pool.request().query('ActualizarComision ' + body.idComision + ',' + idFactura + ',' + idEmpleado + ',' + comision);
    //TODO
  }
};

exports.seleccionarComisiones = async (req, res) => {
  const body = req.body;
  var idComision = (body.idComision !== undefined) ? body.idComision : 'NULL';
  var comisionInicial = (body.comisionInicial !== undefined) ? body.comisionInicial : 'NULL';
  var comisionFinal = (body.comisionFinal !== undefined) ? body.comisionFinal : 'NULL';
  var fechaInicial = (body.fechaInicial !== undefined) ? body.fechaInicial : 'NULL';
  var fechaFinal = (body.fechaFinal !== undefined) ? body.fechaFinal : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request().query('SeleccionarComisiones ' + idComision + ',' + comisionInicial + ',' + comisionFinal + ',' + fechaInicial + ',' + fechaFinal);
  //TODO
};

//CRUD Empleados

exports.crearEmpleadoSucursal = async (req, res) => {
  const body = req.body;
  if(body.nombre === undefined
    || body.apellido === undefined
    || body.telefono === undefined
    || body.correo === undefined
    || body.supervisor === undefined
    || body.puesto === undefined
    || body.idSucursal === undefined
    || body.cedula === undefined
    || body.password === undefined) {
    res.json({status : -1, message : "Faltan parametros"});
    return
  }
  else {
    const pool = await poolPromise;
    const query = await pool.request().query('insertarEmpleadoSucursal ' + body.nombre + ',' + body.apellido + ',' + body.telefono + ',' + body.correo + ',' + body.supervisor + ',' + body.puesto + ',' + body.idSucursal + ',' + body.cedula + ',' + body.password);
    //TODO
  }
};

exports.crearEmpleadoFabrica = async (req, res) => {
  const body = req.body;
  if(body.nombre === undefined || body.apellido === undefined ||
    body.telefono === undefined || body.correo === undefined ||
     body.supervisor === undefined || body.puesto === undefined ||
      body.idFabrica === undefined || body.cedula === undefined ||
       body.password === undefined) {
    return res.json({status : -1, message : "Faltan parametros"});
  }
  else {
    const pool = await poolPromise;
    const query = await pool.request().query('insertarEmpleadoSucursal ' + body.nombre + ',' + body.apellido + ',' + body.telefono + ',' + body.correo + ',' + body.supervisor + ',' + body.puesto + ',' + body.idFabrica + ',' + body.cedula + ',' + body.password);
    //TODO
  }
};

exports.modificarEmpleado = async (req, res) => {
  const body = req.body;
  if(body.cedula === undefined) {
    return res.json({status : -1, message : "Faltan parametros"});
  }
  else {
    var nombre = (body.nombre !== undefined) ? body.nombre : 'NULL';
    var apellido = (body.apellido !== undefined) ? body.apellido : 'NULL';
    var telefono = (body.telefono !== undefined) ? body.telefono : 'NULL';
    var correo = (body.correo !== undefined) ? body.correo : 'NULL';
    var supervisor = (body.supervisor !== undefined) ? body.supervisor : 'NULL';
    var puesto = (body.puesto !== undefined) ? body.puesto : 'NULL';
    const pool = await poolPromise;
    const query = await pool.request().query('modificarEmpleado ' + nombre + ',' + apellido + ',' +
                telefono + ',' + correo + ',' + supervisor + ',' + puesto + ','+ body.cedula);
    //TODO
  }
};

exports.seleccionarEmpleadosFabrica = async (req, res) => {
  const body = req.body;
  var nombre = (body.nombre !== undefined) ? body.nombre : 'NULL';
  var apellido = (body.apellido !== undefined) ? body.apellido : 'NULL';
  var telefono = (body.telefono !== undefined) ? body.telefono : 'NULL';
  var correo = (body.correo !== undefined) ? body.correo : 'NULL';
  var supervisor = (body.supervisor !== undefined) ? body.supervisor : 'NULL';
  var puesto = (body.puesto !== undefined) ? body.puesto : 'NULL';
  var fabrica = (body.fabrica !== undefined) ? body.fabrica : 'NULL';
  var cedula = (body.cedula !== undefined) ? body.cedula : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request().query('SeleccionarEmpleadosFabrica ' + nombre + ',' + apellido + ',' + telefono + ',' + correo + ',' + supervisor + ',' + puesto + ',' + fabrica + ',' + cedula);
  //TODO
};

exports.seleccionarEmpleadosSucursal = async (req, res) => {
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
  const query = await pool.request().query('SeleccionarEmpleadosSucursal ' + nombre + ',' + apellido + ',' + telefono + ',' + correo + ',' + supervisor + ',' + puesto + ',' + sucursal + ',' + cedula);
  //TODO
};

//Pedidos

//Despachos

exports.crearDespacho = async (req, res) => {
  const body = req.body;
  if(body.telefono === undefined || body.correo === undefined || body.extension === undefined || body.idFabrica === undefined) {
    return res.json({status : -1, message : "Faltan parametros"});
  }
  else {
    const pool = await poolPromise;
    const query = await pool.request().query('insertarDespacho ' + body.telefono + ',' + body.extension + ',' + body.correo + ',' + body.idFabrica);
    //TODO
  }
};

exports.modificarDespacho = async (req, res) => {
  const body = req.body;
  if(body.idDespacho === undefined) {
    return res.json({status : -1, message : "Faltan parametros"});
  }
  else {
    var telefono = (body.telefono !== undefined) ? body.telefono : 'NULL';
    var correo = (body.correo !== undefined) ? body.correo : 'NULL';
    var extension = (body.extension !== undefined) ? body.extension : 'NULL';
    var idFabrica = (body.idFabrica !== undefined) ? body.idFabrica : 'NULL';
    const pool = await poolPromise;
    const query = await pool.request().query('modificarDespacho ' + body.idDespacho + ',' + telefono + ',' + extension + ',' + correo + ',' + idFabrica);
    //TODO
  }
};

exports.seleccionarDespacho = async (req, res) => {
  const body = req.body;
  var idDespacho = (body.idDespacho !== undefined) ? body.idDespacho : 'NULL';
  var telefono = (body.telefono !== undefined) ? body.telefono : 'NULL';
  var correo = (body.correo !== undefined) ? body.correo : 'NULL';
  var extension = (body.extension !== undefined) ? body.extension : 'NULL';
  var idFabrica = (body.idFabrica !== undefined) ? body.idFabrica : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request().query('seleccionarDespacho ' + idDespacho + ',' + telefono + ',' + extension + ',' + correo + ',' + idFabrica);
  //TODO
};

//Reporte Ventas

exports.reporteVentas = async (req, res) => {
  const body = req.body;
  var idFactura = (body.idFactura !== undefined) ? body.idFactura : 'NULL';
  var numeroFactura = (body.numeroFactura !== undefined) ? body.numeroFactura : 'NULL';
  var precioInicial = (body.precioInicial !== undefined) ? body.precioInicial : 'NULL';
  var precioFinal = (body.precioFinal !== undefined) ? body.precioFinal : 'NULL';
  var fechaInicial = (body.fechaInicial !== undefined) ? body.fechaInicial : 'NULL';
  var fechaFinal = (body.fechaFinal !== undefined) ? body.fechaFinal : 'NULL';
  var tipoPago = (body.tipoPago !== undefined) ? body.tipoPago : 'NULL';
  var pais = (body.pais !== undefined) ? body.pais : 'NULL';
  var tipoVehiculo = (body.tipoVehiculo !== undefined) ? body.tipoVehiculo : 'NULL';
  var sucursal = (body.sucursal !== undefined) ? body.sucursal : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request.query('SeleccionarFacturas ' + idFactura + ',' + numeroFactura + ',' + precioInicial + ';' + precioFinal + ',' + fechaInicial + ',' + fechaFinal + ',' + tipoPago + ',' + pais + ',' + tipoVehiculo + ',' + sucursal);
  //TODO
};

//Reporte Vehiculos

exports.reporteTopVehiculos = async (req, res) => {
  const body = req.body;
  var tipo = (body.tipo !== undefined) ? body.tipo : 'NULL';
  var combustible = (body.combustible !== undefined) ? body.combustible : 'NULL';
  var marca = (body.marca !== undefined) ? body.marca : 'NULL';
  var modelo = (body.modelo !== undefined) ? body.modelo : 'NULL';
  var precioLow = (body.precioLow !== undefined) ? body.precioLow : 'NULL';
  var precioHigh = (body.precioHigh !== undefined) ? body.precioHigh : 'NULL';
  var idSucursal = (body.idSucursal !== undefined) ? body.idSucursal : 'NULL';
  const pool = await poolPromise;
  const query = await pool.request().query('seleccionarTopVehiculos ' + tipo + ',' + combustible + ',' + marca + ',' + modelo + ',' + precioLow + ',' + precioHigh + ',' + idSucursal);
  //TODO
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
