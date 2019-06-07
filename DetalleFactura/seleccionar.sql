USE Proyecto_BasesII;
GO

CREATE PROCEDURE ObtenerDetalleFactura(@IdFactura INT)
AS
	SELECT SubTotal, Comentario, Cliente.Nombre AS NombreCliente, Empleado.Nombre AS EmpleadoNombre
	FROM DetalleFactura
	INNER JOIN Cliente
	ON Cliente.IdCliente = DetalleFactura.IdCliente
	INNER JOIN Empleado
	ON Empleado.IdEmpleado = DetalleFactura.IdVendedor
	INNER JOIN Factura
	ON Factura.IdDetalleFactura = DetalleFactura.IdDetalleFactura
	WHERE IdFactura = @IdFactura
GO