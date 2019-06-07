USE Proyecto_BasesII;
GO

CREATE PROCEDURE ActualizarEntrega(@IdEntrega INT, @IdFactura INT, @IdUbicacionEntrega INT, @EstatusEntrega VARCHAR(50), @FechaEntrega DATE)
AS
	IF @IdEntrega IS NULL
		RAISERROR(N'El ID es nulo', 15003, 1);
	IF @IdFactura IS NOT NULL
		DECLARE @ComprobarFactura INT;
		SELECT	@ComprobarFactura = (SELECT IdFactura FROM Factura WHERE IdFactura = @IdFactura);
		IF @ComprobarFactura IS NULL
			RAISERROR(N'No existe la factura', 15002, 1)
	IF @IdUbicacionEntrega IS NOT NULL
		DECLARE @ComprobarUbicacionEntrega INT;
		SELECT	@ComprobarUbicacionEntrega = (SELECT IdUbicacion FROM Ubicacion WHERE IdUbicacion = @IdUbicacionEntrega);
		IF @ComprobarUbicacionEntrega IS NULL
			RAISERROR(N'No existe la ubicacion', 15002, 1)
	BEGIN TRANSACTION
		UPDATE Entrega
		SET	IdFactura = ISNULL(@IdFactura, IdFactura), IdUbicacionEntrega = ISNULL(@IdUbicacionEntrega, IdUbicacionEntrega), EstatusEntrega = ISNULL(@EstatusEntrega, EstatusEntrega),
			FechaEntrega = ISNULL(@FechaEntrega, FechaEntrega)
		WHERE IdEntrega = @IdEntrega
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO