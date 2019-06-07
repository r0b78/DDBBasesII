USE Proyecto_BasesII;
GO

CREATE PROCEDURE SeleccionarImpuestoXDetalleFactura(@IdImpuesto INT, @IdDetalleFactura INT)
AS
	SELECT	IdImpuesto, IdDetalleFactura
	FROM	ImpuestoXDetalleFactura
	WHERE	IdImpuesto = ISNULL(@IdImpuesto, IdImpuesto) AND
			IdDetalleFactura = ISNULL(@IdDetalleFactura, IdDetalleFactura)
GO