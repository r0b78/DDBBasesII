USE Proyecto_BasesII;
GO

CREATE PROCEDURE ActualizarDescuento(@IdDescuento INT, @Nombre VARCHAR(50), @Descuento INT)
AS
	IF @IdDescuento IS NULL
		BEGIN
			RAISERROR(N'El ID es nulo', 15005, 1);
		END
	BEGIN TRANSACTION
		UPDATE Descuento
		SET Nombre = ISNULL(@Nombre, Nombre), Descuento = ISNULL(@Descuento, Descuento)
		WHERE IdDescuento = @IdDescuento;
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO 