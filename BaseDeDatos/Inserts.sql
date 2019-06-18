USE Proyecto_BasesII;
GO

SELECT *
FROM PuestoEmpleado

SELECT *
FROM EmpleadoXFabrica

DECLARE @fecha DATETIME;
SET @fecha = GETDATE();

INSERT INTO TipoModalidad(Nombre)
VALUES	('Credito'),
		('Contado');

INSERT INTO Usuario(Usuario, Pass, Privilegio)
VALUES	('Usuario', 'Pass', 'Cliente'),
		('Administrador', 'Pass', 'Administrador'),
		('Empleado', 'Pass', 'Empleado')

EXEC insertarPais 'Costa Rica', 'LINESTRING (100 100, 20 180, 180 180)'
EXEC insertarPais 'Argentina', 'LINESTRING (100 100, 20 180, 180 180)'
EXEC insertarPais 'Venezuela', 'LINESTRING (100 100, 20 180, 180 180)'

EXEC insertarProvincia 'Alajuela', 'LINESTRING (100 100, 20 180, 180 180)', 1
EXEC insertarProvincia 'Cartago', 'LINESTRING (100 100, 20 180, 180 180)', 2
EXEC insertarProvincia 'Heredia', 'LINESTRING (100 100, 20 180, 180 180)', 3

EXEC insertarUbicacion 'Casa 24F', 'POINT(2 2)', 'Alajuela'
EXEC insertarUbicacion 'Casa 25F', 'POINT(4 2)', 'Cartago'
EXEC insertarUbicacion 'Casa 26F', 'POINT(9 2)', 'Heredia'
EXEC insertarUbicacion 'Casa 27F', 'POINT(2 6)', 'Alajuela'
EXEC insertarUbicacion 'Casa 28F', 'POINT(4 10)', 'Cartago'
EXEC insertarUbicacion 'Casa 29F', 'POINT(9 20)', 'Heredia'

EXEC insertarCaracteristica 'Spoiler1', 'Rojo'
EXEC insertarCaracteristica 'Spoiler2', 'Azul'
EXEC insertarCaracteristica 'Spoiler3', 'Verde'

EXEC insertarExtra 'Nombre 1', 'Descripcion 1', 150000
EXEC insertarExtra 'Nombre 2', 'Descripcion 2', 250000
EXEC insertarExtra 'Nombre 3', 'Descripcion 3', 350000

EXEC insertarTipoVehiculo '4X4'
EXEC insertarTipoVehiculo 'Convertible'
EXEC insertarTipoVehiculo '5X5'

EXEC insertarCombustible 'Diesel'
EXEC insertarCombustible 'Super'
EXEC insertarCombustible 'Hibrido'

EXEC insertarVehiculo '4X4', 'Super', 'Ford', 'Mustang', 10000000,0,2
EXEC insertarVehiculo 'Convertible', 'Hibrido', 'Hyundai', 'Mustang', 1000,0,2
EXEC insertarVehiculo 'Convertible', 'Hibrido', 'Honda', '2009', 100,0,4
EXEC insertarVehiculo 'Convertible', 'Hibrido', 'Hyundai', '2009', 100,0,4

EXEC insertarFotoVehiculo 'C:\Users\pierr\Pictures\imagen.jpg', 'Nombre', @fecha, 1
EXEC insertarFotoVehiculo 'C:\Users\pierr\Pictures\imagen.jpg', 'Nombre', @fecha, 2

EXEC insertarExtraXVehiculo 1, 1
EXEC insertarExtraXVehiculo 2, 1
EXEC insertarExtraXVehiculo 3, 2

EXEC insertarCaracteristicaXVehiculo 1, 1
EXEC insertarCaracteristicaXVehiculo 2, 1
EXEC insertarCaracteristicaXVehiculo 3, 2

EXEC insertarSucursal 'Nombre Sucursal 1', 'Una sucursal', 1
EXEC insertarSucursal 'Nombre Sucursal 2', 'Una sucursal', 2
EXEC insertarSucursal 'Nombre Sucursal 3', 'Una sucursal', 3

EXEC insertarPuestoEmpleado 'Supervisor'
EXEC insertarPuestoEmpleado 'Vendedor'
EXEC insertarPuestoEmpleado 'Facturador'

INSERT INTO Empleado(Nombre, Apellido, Telefono, Correo, IdSupervisor, IdPuestoEmpleado, Cedula, IdUsuario)
VALUES ('Supervisor', 'Supervisor', '1111-1111', 'supervisor@gmail.com', null, 1, '1', 2);

EXEC insertarEmpleadoSucursal 'Gabriel', 'Piedra', '2121-2121', 'usuario@gmail.com', '1', 'Vendedor', 1, '2', 2
EXEC insertarEmpleadoSucursal 'Luis', 'Piedra', '2121-2121', 'usuario@gmail.com', '1', 'Vendedor', 1, '3', 2
EXEC insertarEmpleadoSucursal 'Roberto', 'Piedra', '2121-2121', 'usuario@gmail.com', '1', 'Vendedor', 1, '4', 2

EXEC InsertarCliente '1998-1-1','hola','998', 'Israel', 'Piedra', '1111-1111', 'cliente@gmail', 'POINT(10 12)','Papas','Cartago'
EXEC InsertarCliente '1998-1-1','hola','998', 'Jean', 'Piedra', '1112-1111', 'cliente2@gmail', 'POINT(20 12)','Papas','Cartago'
EXEC InsertarCliente '1998-1-1','hola','998', 'Pablo', 'Piedra', '1113-1111', 'cliente3@gmail', 'POINT(25 12)','Papas','Cartago'

EXEC InsertarDescuento 'Descuento de verano', 20
EXEC InsertarDescuento 'Descuento de verano', 60
EXEC InsertarDescuento 'Descuento de verano', 40

EXEC InsertarImpuesto 'Impuesto', 2
EXEC InsertarImpuesto 'Impuesto', 4
EXEC InsertarImpuesto 'Impuesto', 6

EXEC InsertarTipoPago 'Efectivo'
EXEC InsertarTipoPago 'Tarjeta'
EXEC InsertarTipoPago 'Cheque'

EXEC InsertarDetalleFactura 1, 1, 12000, 1, 'Comentario', 1
EXEC InsertarDetalleFactura 2, 2, 14000, 2, 'Comentario', 2

EXEC InsertarFactura '1', 1, 150000, @fecha
EXEC InsertarFactura '2', 2, 250000, @fecha

EXEC InsertarDescuentoXDetalleFactura 1, 1

EXEC InsertarImpuestoXDetalleFactura 1, 1

EXEC InsertarFacturaXVehiculo 1, 1
EXEC InsertarFacturaXVehiculo 2, 2

EXEC InsertarComision 1, 1, 25
EXEC InsertarComision 2, 2, 50

EXEC InsertarEntrega 1, 4, 'En proceso', @fecha
EXEC InsertarEntrega 2, 5, 'Enviado', @fecha

EXEC InsertarFabrica 'Una fabrica',1
EXEC InsertarFabrica 'Una fabrica',2

EXEC InsertarPedido  'En proceso', @fecha, 1, 1
EXEC InsertarPedido  'Entregado', @fecha, 2, 2
EXEC InsertarPedido  'Cancelado', @fecha, 3, 2

EXEC InsertarPedidoXVehiculo 1, 1, @fecha
EXEC InsertarPedidoXVehiculo 2, 2, @fecha

EXEC InsertarInventario 'Inventario', @fecha, 1
EXEC InsertarInventario 'Inventario', @fecha, 2

EXEC InsertarVehiculoFabrica 1, 150000, 1, 1
EXEC InsertarVehiculoFabrica 2, 450000, 2, 2

EXEC InsertarVehiculoFabricaXEmpleado 1, 3, 'Montar el chasis', @fecha, @fecha, 'Progreso'
EXEC InsertarVehiculoFabricaXEmpleado 2, 3, 'Montar las llantas', @fecha, @fecha, 'Completado'

INSERT INTO VehiculoXSucursal(IdVehiculo, IdSucursal)
VALUES	(1, 1),
		(2, 2),
		(3, 3)
