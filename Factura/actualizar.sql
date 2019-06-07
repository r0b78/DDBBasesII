USE Proyecto_BasesII;
GO

CREATE PROCEDURE ActualizarFactura(@IdFactura INT, @NumeroFactura VARCHAR(50), @IdDetalleFactura INT, @PrecioTotal INT, @Fecha DATE)
AS
	IF @IdFactura IS NULL
		RAISERROR(N'El ID es nulo', 15001, 1);
	IF @IdDetalleFactura IS NOT NULL
		DECLARE @ComprobarDetalle INT
		SET @ComprobarDetalle = (SELECT IdDetalleFactura FROM DetalleFactura WHERE IdDetalleFactura = @IdDetalleFactura)
		IF @ComprobarDetalle IS NULL
			RAISERROR(N'No existe el detalle de factura', 15016, 1);
	ELSE
		UPDATE Factura
		SET NumeroFactura = ISNULL(@NumeroFactura, NumeroFactura), IdDetalleFactura = ISNULL(@IdDetalleFactura, IdDetalleFactura), PrecioTotal = ISNULL(@PrecioTotal, PrecioTotal),
			Fecha = ISNULL(@Fecha, Fecha)
		WHERE IdFactura = @IdFactura
GO