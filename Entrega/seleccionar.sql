USE Proyecto_BasesII;
GO

CREATE PROCEDURE SeleccionarEntregas(@IdEntrega INT, @EstatusEntrega VARCHAR(50), @FechaInicial DATE, @FechaFinal DATE, @NumeroFactura VARCHAR(50))
AS
	SELECT		NumeroFactura, EstatusEntrega, Fecha, IdEntrega
	FROM		Entrega
	INNER JOIN	Factura
	ON			Factura.IdFactura = Entrega.IdFactura
	WHERE		IdEntrega = ISNULL(@IdEntrega, IdEntrega) AND
				EstatusEntrega = ISNULL(@EstatusEntrega, EstatusEntrega) AND
				Entrega.FechaEntrega BETWEEN ISNULL(@FechaInicial, Entrega.FechaEntrega) AND ISNULL(@FechaFinal, Entrega.FechaEntrega) AND
				NumeroFactura = ISNULL(@NumeroFactura, NumeroFactura) 
GO