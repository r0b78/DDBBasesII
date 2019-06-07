USE Proyecto_BasesII;
GO

CREATE PROCEDURE SeleccionarImpuestos(@IdFactura INT)
AS
	SELECT Nombre, Impuesto
	FROM Impuesto
	INNER JOIN ImpuestoXDetalleFactura
	ON ImpuestoXDetalleFactura.IdImpuesto = Impuesto.IdImpuesto
	INNER JOIN DetalleFactura
	ON DetalleFactura.IdDetalleFactura = ImpuestoXDetalleFactura.IdDetalleFactura
	INNER JOIN Factura
	ON Factura.IdDetalleFactura = DetalleFactura.IdDetalleFactura
	WHERE IdFactura = @IdFactura
GO