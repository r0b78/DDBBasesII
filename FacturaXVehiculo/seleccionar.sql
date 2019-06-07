USE Proyecto_BasesII;
GO

CREATE PROCEDURE SeleccionarFacturaXVehiculo(@IdFactura INT, @IdVehiculo INT)
AS
	SELECT	IdFactura, IdVehiculo
	FROM	FacturaXVehiculo
	WHERE	IdFactura = ISNULL(@IdFactura, IdFactura) AND
			IdVehiculo = ISNULL(@IdVehiculo, IdVehiculo)
GO