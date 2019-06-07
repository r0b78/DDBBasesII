USE Proyecto_BasesII;
GO

CREATE PROCEDURE InsertarTipoPago(@Pago VARCHAR(50))
AS
	IF @Pago IS NULL
		RAISERROR(N'Informacion Incompleta', 15001, 1);
	ELSE
		BEGIN TRANSACTION
			INSERT INTO TipoPago(Pago)
			VALUES	(@Pago);
		COMMIT TRANSACTION
		RETURN @@IDENTITY;
GO