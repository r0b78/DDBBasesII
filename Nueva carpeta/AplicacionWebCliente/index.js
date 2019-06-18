var express = require('express');
var app = express();
var json2html = require('node-json2html');
var client = require('./controllers/ClientController')
var admin = require('./controllers/AdminController')
var empleado = require('./controllers/EmpleadoController')
var bodyParser=require('body-parser')
var cookieParser = require('cookie-parser');

app.use(cookieParser());
app.set("view engine","ejs")

app.use(express.static('public'));
app.use(bodyParser.urlencoded({
  extended: true
}));
app.use(bodyParser.json());

app.get('/',function(req,res){
    res.redirect('/login');
})
app.get('/login', client.mainPage);
app.post('/login', client.login);

//Cliente

app.get('/verCompras',client.verCompras)

app.get('/buscarVehiculos',client.buscarVehiculosVentana)
app.post('/buscarVehiculos',client.buscarVehiculo)

app.get('/comprarVehiculo/:id',client.verCompraVehiculo)
app.post('/comprarVehiculo/:id',client.comprarVehiculo)

app.get('/verSucursales',client.verSucursales)

//Admin

app.post('/crearDescuento',admin.crearDescuento);

//app.post('/crearEmpleado',admin.crearEmpleado)

//app.post('/verEmpleados',admin.verEmpleados)

//app.post('/modificarEmpleado',admin.modificarVehiculo)

app.post('/verVehiculos', admin.verVehiculos)

app.post('/verVehiculosComprados',admin.verVehiculosComprados)

app.post('/crearVehiculo',admin.crearVehiculo)

app.post('/vehiculoFabrica',admin.vehiculoFabrica)

// Sucursal
app.get('/mostrarVistaSucursal',admin.mostrarVistaSucursal)
app.post('/vistaSucursales', admin.verSucursales);

app.get('/agregarSucursal',admin.vistaAgregarSucursal)
app.post('/agregarSucursal',admin.crearSucursal);

app.get('/modificarSucursal', admin.vistaModificarSucursal)
app.post('/modificarSucursal',admin.modificarSucursal);
//Fabrica
app.get('/crearFabrica', admin.vistaCrearFabrica);
app.post('/crearFabrica', admin.crearFabrica);

app.get('/verFabrica', admin.seleccionarFabrica)
//Vehiculo
app.get('/crearVehiculo', admin.vistaCrearVehiculo);
app.post('/crearVehiculo',admin.crearVehiculo)

app.get('/modificarVehiculo',admin.vistaModificarVehiculo)
app.post('/modificarVehiculo', admin.modificarVehiculo)

app.get('/verVehiculo',admin.vistaVerVehiculo)
app.post('/verVehiculo', admin.verVehiculos)

//Extra
app.get('/crearExtra', admin.vistaCrearExtra)
app.post('/crearExtra', admin.crearExtra)

app.get('/modificarExtra', admin.vistaModificarExtra)
app.post('/modificarExtra', admin.modificarExtra);

app.get('/modificarExtra', admin.vistaModificarExtra)
app.post('/modificarExtra', admin.modificarExtra);

app.get('/verExtra', admin.verExtra);

app.get('/asignarExtraAutomovil', admin.vistaExtraAutomovil)
app.post('/asignarExtraAutomovil', admin.insertarExtraVehiculo)

//Empleado

app.get('/crearEmpleadoSucursal',admin.vistaCrearEmpleadoSucursal)
app.post('/crearEmpleadoSucursal',admin.crearEmpleadoSucursal)

app.get('/crearEmpleadoFabrica', admin.vistaCrearEmpleadoFabrica)
app.post('/crearEmpleadoFabrica',admin.crearEmpleadoFabrica)

app.get('/modificarEmpleadoFabrica', admin.vistaCrearEmpleadoFabrica)
app.post('/modificarEmpleadoFabrica',admin.crearEmpleadoFabrica)

app.get('/seleccionarEmpleadoSucursal',admin.vistaVerEmpleadoSucursal)
app.post('/seleccionarEmpleadoSucursal',admin.seleccionarEmpleadosSucursal)

app.get('/seleccionarEmpleadoFabrica',admin.vistaVerEmpleadoFabrica)
app.post('/seleccionarEmpleadoFabrica',admin.seleccionarEmpleadosFabrica)

app.get('/consultaVentas',admin.vistaReporteVentas );
app.post('/consultaVentas',admin.reporteVentas);

app.listen(3000, function () {
  console.log('Servidor iniciado');
});
