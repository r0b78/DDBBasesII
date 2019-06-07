USE Proyecto_BasesII;
GO

CREATE PROCEDURE SeleccionarTipoPagos(@IdTipoPago INT)
AS
	SELECT Pago
	FROM TipoPago
	WHERE IdTipoPago = ISNULL(@IdTipoPago, IdTipoPago)
GO