USE Proyecto_BasesII;
GO

CREATE PROCEDURE InsertarFacturaXVehiculo(@IdFactura  INT, @IdVehiculo INT)
AS
	IF @IdFactura  IS NULL OR @IdVehiculo IS NULL
		RAISERROR(N'Informacion incompleta', 15001, 1);
	DECLARE @ComprobarFactura  INT,
			@ComprobarDetalle INT;
	SELECT	@ComprobarFactura  = (SELECT IdFactura  FROM Factura  WHERE IdFactura  = @IdFactura),
			@ComprobarDetalle = (SELECT IdVehiculo FROM Vehiculo WHERE IdVehiculo = @IdVehiculo)
	IF @ComprobarFactura  IS NULL
		RAISERROR(N'La Factura  no existe', 15002, 1)
	ELSE IF @ComprobarDetalle IS NULL
		RAISERROR(N'El vehiculo no existe', 15002, 1)
	ELSE
		BEGIN TRANSACTION
			INSERT INTO FacturaXVehiculo(IdFactura , IdVehiculo)
			VALUES	(@IdFactura , @IdVehiculo)
		COMMIT TRANSACTION
		RETURN @@IDENTITY;
GO