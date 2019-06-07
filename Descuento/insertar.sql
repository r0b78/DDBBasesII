USE Proyecto_BasesII;
GO

CREATE PROCEDURE InsertarDescuento(@Nombre VARCHAR(50), @Descuento INT)
AS
	IF @Nombre IS NULL OR @Descuento IS NULL
		RAISERROR(N'Informacion Incompleta', 15001, 1);
	ELSE
		BEGIN TRANSACTION
			INSERT INTO Descuento(Nombre, Descuento)
			VALUES	(@Nombre, @Descuento);
		COMMIT TRANSACTION
		RETURN @@IDENTITY;
GO