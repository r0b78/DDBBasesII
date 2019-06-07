USE Proyecto_BasesII;
GO

CREATE PROCEDURE ActualizarImpuesto(@IdImpuesto INT, @Nombre VARCHAR(50), @Impuesto INT)
AS
	IF @IdImpuesto IS NULL
		BEGIN
			RAISERROR(N'El ID es nulo', 15005, 1);
		END
	BEGIN TRANSACTION
		UPDATE Impuesto
		SET Nombre = ISNULL(@Nombre, Nombre), Impuesto = ISNULL(@Impuesto, Impuesto)
		WHERE IdImpuesto = @IdImpuesto;
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO 