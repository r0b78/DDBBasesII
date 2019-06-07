USE Proyecto_BasesII;
GO

CREATE PROCEDURE ActualizarFacturaXVehiculo(@IdFacturaXVehiculo INT, @IdFactura INT, @IdVehiculo INT)
AS
	IF @IdFacturaXVehiculo IS NULL
		RAISERROR(N'El ID es nulo', 15003, 1);
	IF @IdFactura IS NOT NULL
		DECLARE @ComprobarFactura INT;
		SELECT	@ComprobarFactura = (SELECT IdFactura FROM Factura WHERE IdFactura = @IdFactura);
		IF @ComprobarFactura IS NULL
			RAISERROR(N'La Factura no existe', 15002, 1)
	IF @IdVehiculo IS NOT NULL
		DECLARE @ComprobarVehiculo INT;
		SELECT	@ComprobarVehiculo = (SELECT IdVehiculo FROM Vehiculo WHERE IdVehiculo = @IdVehiculo);
		IF @ComprobarVehiculo IS NULL
			RAISERROR(N'El Vehiculo no existe', 15002, 1)
	BEGIN TRANSACTION
		UPDATE FacturaXVehiculo
		SET IdFactura = ISNULL(@IdFactura, IdFactura), IdVehiculo = ISNULL(@IdVehiculo, IdVehiculo)
		WHERE IdFacturaXVehiculo = @IdFacturaXVehiculo
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO