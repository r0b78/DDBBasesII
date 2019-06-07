USE Proyecto_BasesII;
GO

CREATE PROCEDURE InsertarFactura(@NumeroFactura VARCHAR(50), @IdDetalleFactura INT, @PrecioTotal INT, @Fecha DATE)
AS
	IF @NumeroFactura IS NULL OR @IdDetalleFactura IS NULL OR @PrecioTotal IS NULL OR @Fecha IS NULL
		RAISERROR(N'Informacion Incompleta', 15015, 1);
	DECLARE @ComprobarDetalle INT
	SET @ComprobarDetalle = (SELECT IdDetalleFactura FROM DetalleFactura WHERE IdDetalleFactura = @IdDetalleFactura)
	IF @ComprobarDetalle IS NULL
		RAISERROR(N'No existe el detalle de factura', 15016, 1);
	ELSE
		BEGIN TRANSACTION
			INSERT INTO Factura(NumeroFactura, IdDetalleFactura, PrecioTotal, Fecha)
			VALUES (@NumeroFactura, @IdDetalleFactura, @PrecioTotal, @Fecha)
		COMMIT TRANSACTION
		RETURN @@IDENTITY;
GO