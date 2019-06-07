USE Proyecto_BasesII

CREATE TABLE Pais(
  IdPais                    INT PRIMARY KEY IDENTITY,
  Nombre                    VARCHAR(50),
  Locacion					geometry    
)

CREATE TABLE Provincia(
  IdProvincia               INT PRIMARY KEY IDENTITY,
  Nombre                    VARCHAR(50),
  IdPais                    INT,
  LocacionProvincia			geometry,
  FOREIGN KEY (IdPais)      REFERENCES Pais(IdPais) 
)

CREATE TABLE Ubicacion(
  IdUbicacion               INT PRIMARY KEY IDENTITY,
  IdProvincia               INT,
  Descripcion               VARCHAR(50),
  LocacionExacta			geometry,
  FOREIGN KEY (IdProvincia) REFERENCES Provincia(IdProvincia)
)

CREATE TABLE Caracteristica(
  IdCaracteristica          INT PRIMARY KEY IDENTITY,
  Caracteristica            VARCHAR(50),
  Dato                      VARCHAR(50)
)

CREATE TABLE Extra(
  IdExtra                   INT PRIMARY KEY IDENTITY,
  Nombre                    VARCHAR(50),
  Descripcion               VARCHAR(50),
  Precio                    INT
)

CREATE TABLE TipoVehiculo(
  IdTipoVehiculo            INT PRIMARY KEY IDENTITY,
  Nombre                    VARCHAR(50),
)

CREATE TABLE Combustible(
  IdCombustible             INT PRIMARY KEY IDENTITY,
  Nombre                    VARCHAR(50)
)

CREATE TABLE Vehiculo(
  IdVehiculo                    INT PRIMARY KEY IDENTITY,
  IdTipoVehiculo                INT,
  IdCombustible                 INT,
  Marca                         VARCHAR(50),
  Modelo                        VARCHAR(50),
  Precio                        INT
  FOREIGN KEY (IdTipoVehiculo)  REFERENCES TipoVehiculo(IdTipoVehiculo),
  FOREIGN KEY (IdCombustible)   REFERENCES Combustible(IdCombustible)
)

CREATE TABLE FotoVehiculo(
  IdFotoVehiculo                INT PRIMARY KEY IDENTITY,
  Foto                          VARBINARY(MAX),
  NombreFoto                    VARCHAR(50),
  Fecha                         DATE,
  IdVehiculo                    INT,
  FOREIGN KEY (IdVehiculo)      REFERENCES Vehiculo(IdVehiculo)
)

CREATE TABLE ExtraXVehiculo(
  IdExtraXVehiculo                  INT PRIMARY KEY IDENTITY,
  IdExtra                           INT,
  IdVehiculo                        INT,
  PrecioPagado                      INT,
  FOREIGN KEY (IdExtra)             REFERENCES Extra(IdExtra),
  FOREIGN KEY (IdVehiculo)          REFERENCES Vehiculo(IdVehiculo)
)

CREATE TABLE CaracteristicaXVehiculo(
  IdCaracteristicaXVehiculo        INT PRIMARY KEY IDENTITY,
  IdCaracteristica                 INT,
  IdVehiculo                       INT
  FOREIGN KEY (IdCaracteristica)   REFERENCES Caracteristica(IdCaracteristica),
  FOREIGN KEY (IdVehiculo)         REFERENCES Vehiculo(IdVehiculo)
)

CREATE TABLE Sucursal(
  IdSucursal                      INT PRIMARY KEY IDENTITY,
  Nombre                          VARCHAR(50),
  Descripcion                     VARCHAR(50),
  IdUbicacion                     INT
  FOREIGN KEY (IdUbicacion) REFERENCES Ubicacion(IdUbicacion)
)

CREATE TABLE PuestoEmpleado(
  IdPuestoEmpleado                INT PRIMARY KEY IDENTITY,
  Puesto                          VARCHAR(50)
)

CREATE TABLE Empleado(
  IdEmpleado                       INT PRIMARY KEY IDENTITY,
  Nombre                           VARCHAR(50),
  Apellido                         VARCHAR(50),
  Telefono                         INT,
  Correo                           VARCHAR(50),
  IdSupervisor                     INT,
  IdPuestoEmpleado                 INT,
  IdSucursal                       INT,
  FOREIGN KEY (IdSupervisor)       REFERENCES Empleado(IdEmpleado),
  FOREIGN KEY (IdPuestoEmpleado)   REFERENCES PuestoEmpleado(IdPuestoEmpleado),
  FOREIGN KEY (IdSucursal)         REFERENCES Sucursal(IdSucursal)
)

CREATE TABLE Cliente(
  IdCliente INT PRIMARY KEY IDENTITY,
  Nombre VARCHAR(50),
  Apellido VARCHAR(50),
  Telefono VARCHAR(50),
  Correo VARCHAR(50),
  IdUbicacion INT,
  FOREIGN KEY (IdUbicacion) REFERENCES Ubicacion(IdUbicacion)
)

CREATE TABLE Descuento(
  IdDescuento                     INT PRIMARY KEY IDENTITY,
  Nombre                          VARCHAR(50),
  Descuento                       INT
)

CREATE TABLE Impuesto(
  IdImpuesto                      INT PRIMARY KEY IDENTITY,
  Nombre                          VARCHAR(50),
  Impuesto                        INT
)

CREATE TABLE TipoPago(
  IdTipoPago                INT PRIMARY KEY IDENTITY,
  Pago                      VARCHAR(50)
)

CREATE TABLE DetalleFactura(
  IdDetalleFactura          INT PRIMARY KEY IDENTITY,
  IdVendedor                INT,
  IdCliente                 INT,
  SubTotal                  INT,
  Descuento                 INT, 
  Impuestos                 INT,
  IdTipoPago                INT,
  Comentario                VARCHAR(50),
  FOREIGN KEY (IdTipoPago) REFERENCES TipoPago(IdTipoPago),
  FOREIGN KEY (IdVendedor) REFERENCES Empleado(IdEmpleado),
  FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente)
)

CREATE TABLE Factura(
  IdFactura                 INT PRIMARY KEY IDENTITY,
  NumeroFactura             VARCHAR(50),
  IdDetalleFactura          INT,
  PrecioTotal               INT,
  Fecha                     DATE
  FOREIGN KEY (IdDetalleFactura) REFERENCES DetalleFactura(IdDetalleFactura)
)     

CREATE TABLE DescuentoXDetalleFactura(
  IdDescuentoXDetalleFactura      INT PRIMARY KEY IDENTITY,
  IdDescuento                     INT,
  IdDetalleFactura                INT
  FOREIGN KEY (IdDescuento) REFERENCES Descuento(IdDescuento),
  FOREIGN KEY (IdDetalleFactura) REFERENCES DetalleFactura(IdDetalleFactura)
)

CREATE TABLE ImpuestoXDetalleFactura(
  IdImpuestoXDetalleFactura       INT PRIMARY KEY IDENTITY,
  IdDetalleFactura                INT,
  IdImpuesto                      INT
  FOREIGN KEY (IdDetalleFactura)  REFERENCES DetalleFactura(IdDetalleFactura),
  FOREIGN KEY (IdImpuesto)        REFERENCES Impuesto(IdImpuesto)
)

CREATE TABLE FacturaXVehiculo(
  IdFacturaXVehiculo        INT PRIMARY KEY IDENTITY,
  IdFactura                 INT,
  IdVehiculo                INT,
  FOREIGN KEY (IdFactura)   REFERENCES Factura(IdFactura),
  FOREIGN KEY (IdVehiculo)  REFERENCES Vehiculo(IdVehiculo)
)

CREATE TABLE Comision(
  IdComision  INT PRIMARY KEY IDENTITY,
  IdFactura   INT,
  IdEmpleado  INT,
  Comision    INT
  FOREIGN KEY (IdFactura) REFERENCES Factura(IdFactura),
  FOREIGN KEY (IdEmpleado) REFERENCES Empleado(IdEmpleado)
)

CREATE TABLE Entrega(
  IdEntrega                 INT PRIMARY KEY IDENTITY,
  IdFactura                 INT,
  IdUbicacionEntrega        INT,
  EstatusEntrega            VARCHAR(50),
  FechaEntrega              DATE,
  FOREIGN KEY (IdFactura) REFERENCES Factura(IdFactura),
  FOREIGN KEY (IdUbicacionEntrega) REFERENCES Ubicacion(IdUbicacion)
)

CREATE TABLE Fabrica(
  IdFabrica                 INT PRIMARY KEY IDENTITY,
  IdSucursal                INT,
  Descripcion               VARCHAR(50),
  FOREIGN KEY (IdSucursal) REFERENCES Sucursal(IdSucursal)
)

CREATE TABLE Pedido(
  IdPedido                  INT PRIMARY KEY IDENTITY,
  EstatusPedido             VARCHAR(50),
  FechaPedido               DATE,
  IdEmpleadoPedido          INT,
  IdFabrica                 INT
  FOREIGN KEY (IdEmpleadoPedido) REFERENCES Empleado(IdEmpleado),
  FOREIGN KEY (IdFabrica) REFERENCES Fabrica(IdFabrica)
)

CREATE TABLE PedidoXVehiculo(
  IdPedidoXVehiculo         INT PRIMARY KEY IDENTITY,
  IdPedido                  INT,
  IdVehiculo                INT,
  FechaCompletado           DATE
  FOREIGN KEY (IdPedido) REFERENCES Pedido(IdPedido),
  FOREIGN KEY (IdVehiculo) REFERENCES Vehiculo(IdVehiculo)
)
-- Este inventario es tanto para el almacen como para 
CREATE TABLE Inventario(
  IdInventario              INT PRIMARY KEY IDENTITY,
  NombreInventario          VARCHAR(50),
  Fecha                     DATE,
  IdSucursal                INT,
  FOREIGN KEY (IdSucursal) REFERENCES Sucursal(IdSucursal)
)

CREATE TABLE VehiculoFabrica(
  IdVehiculoFabrica         INT PRIMARY KEY IDENTITY,
  IdVehiculo                INT,
  CostoVehiculo             INT,
  IdInventario              INT,
  IdFabrica                 INT,
  FOREIGN KEY (IdFabrica) REFERENCES Fabrica(IdFabrica),
  FOREIGN KEY (IdVehiculo) REFERENCES Vehiculo(IdVehiculo),
  FOREIGN KEY (IdInventario) REFERENCES Inventario(IdInventario)
)

CREATE TABLE VehiculoFabricaXEmpleado(
  IdVehiculoFabricaXEmpleado INT PRIMARY KEY IDENTITY,
  IdVehiculoFabrica          INT,
  IdEmpleado                 INT,
  Labor                      VARCHAR(50),
  FechaInicio                DATE,
  FechaFinal                 DATE,
  Estatus                    VARCHAR(50)
  FOREIGN KEY (IdVehiculoFabrica) REFERENCES VehiculoFabrica(IdVehiculoFabrica),
  FOREIGN KEY (IdEmpleado) REFERENCES Empleado(IdEmpleado)
)









