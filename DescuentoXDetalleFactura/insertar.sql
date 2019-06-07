USE Proyecto_BasesII;
GO

CREATE PROCEDURE InsertarDescuentoXDetalleFactura(@IdDescuento INT, @IdDetalleFactura INT)
AS
	IF @IdDescuento IS NULL OR @IdDetalleFactura IS NULL
		RAISERROR(N'Informacion incompleta', 15001, 1);
	DECLARE @ComprobarDescuento INT,
			@ComprobarDetalle INT;
	SELECT	@ComprobarDescuento = (SELECT IdDescuento FROM Descuento WHERE IdDescuento = @IdDescuento),
			@ComprobarDetalle = (SELECT IdDetalleFactura FROM DetalleFactura WHERE IdDetalleFactura = @IdDetalleFactura)
	IF @ComprobarDescuento IS NULL
		RAISERROR(N'El descuento no existe', 15002, 1)
	ELSE IF @ComprobarDetalle IS NULL
		RAISERROR(N'El detalle no existe', 15002, 1)
	ELSE
		BEGIN TRANSACTION
			INSERT INTO DescuentoXDetalleFactura(IdDescuento, IdDetalleFactura)
			VALUES	(@IdDescuento, @IdDetalleFactura)
		COMMIT TRANSACTION
		RETURN @@IDENTITY;
GO