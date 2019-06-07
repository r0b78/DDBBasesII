USE Proyecto_BasesII;
GO

CREATE PROCEDURE SeleccionarDescuentos(@IdFactura INT)
AS
	SELECT Nombre, Descuento.Descuento
	FROM Descuento
	INNER JOIN DescuentoXDetalleFactura
	ON Descuento.IdDescuento = DescuentoXDetalleFactura.IdDescuento
	INNER JOIN DetalleFactura
	ON DetalleFactura.IdDetalleFactura = DescuentoXDetalleFactura.IdDetalleFactura
	INNER JOIN Factura
	ON Factura.IdDetalleFactura = DetalleFactura.IdDetalleFactura
	WHERE IdFactura = @IdFactura
GO