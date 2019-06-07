USE Proyecto_BasesII;
GO

CREATE PROCEDURE ActualizarDescuentoXDetalleFactura(@IdDescuentoXDetalleFactura INT, @IdDescuento INT, @IdDetalleFactura INT)
AS
	IF @IdDescuentoXDetalleFactura IS NULL
		RAISERROR(N'El ID es nulo', 15003, 1);
	IF @IdDescuento IS NOT NULL
		DECLARE @ComprobarDescuento INT;
		SELECT	@ComprobarDescuento = (SELECT IdDescuento FROM Descuento WHERE IdDescuento = @IdDescuento);
		IF @ComprobarDescuento IS NULL
			RAISERROR(N'El descuento no existe', 15002, 1)
	IF @IdDetalleFactura IS NOT NULL
		DECLARE @ComprobarDetalleFactura INT;
		SELECT	@ComprobarDetalleFactura = (SELECT IdDetalleFactura FROM DetalleFactura WHERE IdDetalleFactura = @IdDetalleFactura);
		IF @ComprobarDetalleFactura IS NULL
			RAISERROR(N'El DetalleFactura no existe', 15002, 1)
	BEGIN TRANSACTION
		UPDATE DescuentoXDetalleFactura
		SET IdDescuento = ISNULL(@IdDescuento, IdDescuento), IdDetalleFactura = ISNULL(@IdDetalleFactura, IdDetalleFactura)
		WHERE IdDescuentoXDetalleFactura = @IdDescuentoXDetalleFactura
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO