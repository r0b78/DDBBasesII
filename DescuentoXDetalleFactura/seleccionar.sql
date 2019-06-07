USE Proyecto_BasesII;
GO

CREATE PROCEDURE SeleccionarDescuentoXDetalleFactura(@IdDescuento INT, @IdDetalleFactura INT)
AS
	SELECT	IdDescuento, IdDetalleFactura
	FROM	DescuentoXDetalleFactura
	WHERE	IdDescuento = ISNULL(@IdDescuento, IdDescuento) AND
			IdDetalleFactura = ISNULL(@IdDetalleFactura, IdDetalleFactura)
GO