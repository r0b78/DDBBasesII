USE Proyecto_BasesII;
GO

EXEC seleccionarVehiculoCercano 'POINT(0 0)', null, null, null, null, null, null, null, null

EXEC SeleccionarClientes null, null, null, null, null, null

EXEC FacturarContado 1, 1, 1, 'Comentario', 5, 10, 'Tarjeta', 'Contado', 150, 1

EXEC seleccionarTopVehiculos null, null, null, null, null, null, null

EXEC SeleccionarFacturas null, null, null, null, null, null, null, null, null, null