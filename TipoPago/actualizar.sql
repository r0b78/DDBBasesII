USE Proyecto_BasesII;
GO

CREATE PROCEDURE ActualizarTipoPago(@IdTipoPago INT, @Pago VARCHAR(50))
AS
	IF @IdTipoPago IS NULL
		BEGIN
			RAISERROR(N'El ID es nulo', 15005, 1);
		END
	BEGIN TRANSACTION
		UPDATE TipoPago
		SET Pago = ISNULL(@Pago, Pago)
		WHERE IdTipoPago = @IdTipoPago;
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO 