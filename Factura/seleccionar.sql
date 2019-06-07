USE Proyecto_BasesII;
GO

CREATE PROCEDURE SeleccionarFacturas(@IdFactura INT, @NumeroFactura VARCHAR(50), @IdDetalleFactura INT, @PrecioInicial INT, @PrecioFinal INT, @FechaInicial DATE, @FechaFinal DATE)
AS
	SELECT	NumeroFactura, PrecioTotal, Fecha, IdDetalleFactura
	FROM	Factura
	WHERE	IdFactura = ISNULL(@IdFactura, IdFactura) AND
			NumeroFactura = ISNULL(@NumeroFactura, NumeroFactura) AND
			IdDetalleFactura = ISNULL(@IdDetalleFactura, IdDetalleFactura) AND
			PrecioTotal BETWEEN ISNULL(@PrecioInicial, PrecioTotal) AND ISNULL(@PrecioFinal, PrecioTotal) AND
			Fecha BETWEEN ISNULL(@FechaInicial, Fecha) AND ISNULL(@FechaFinal, Fecha)
GO