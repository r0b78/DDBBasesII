USE Proyecto_BasesII;
GO

CREATE PROCEDURE InsertarEntrega(@IdFactura INT, @IdUbicacionEntrega INT, @EstatusEntrega VARCHAR(50), @FechaEntrega DATE)
AS
	IF @IdFactura IS NULL OR @IdUbicacionEntrega IS NULL OR @EstatusEntrega IS NULL OR @FechaEntrega IS NULL
		RAISERROR(N'Informacion Incompleta', 15001, 1);
	DECLARE @ComprobarFactura INT,
			@ComprobarUbicacion INT;
	SELECT	@ComprobarFactura = (SELECT IdFactura FROM Factura WHERE IdFactura = @IdFactura),
			@ComprobarUbicacion = (SELECT IdUbicacion FROM Ubicacion WHERE IdUbicacion = @IdUbicacionEntrega);
	IF @ComprobarFactura IS NULL
		RAISERROR(N'No existe la factura', 15002, 1)
	ELSE IF @ComprobarUbicacion IS NULL
		RAISERROR(N'No existe la ubicacion', 15002, 1)
	ELSE
		BEGIN TRANSACTION
			INSERT INTO Entrega(IdFactura, IdUbicacionEntrega, EstatusEntrega, FechaEntrega)
			VALUES	(@IdFactura, @IdUbicacionEntrega, @EstatusEntrega, @FechaEntrega)
		COMMIT TRANSACTION
		RETURN @@IDENTITY;
GO