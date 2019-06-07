USE Proyecto_BasesII;
GO

CREATE PROCEDURE InsertarImpuesto(@Nombre VARCHAR(50), @Impuesto INT)
AS
	IF @Nombre IS NULL OR @Impuesto IS NULL
		RAISERROR(N'Informacion Incompleta', 15001, 1);
	ELSE
		BEGIN TRANSACTION
			INSERT INTO Impuesto(Nombre, Impuesto)
			VALUES	(@Nombre, @Impuesto);
		COMMIT TRANSACTION
		RETURN @@IDENTITY;
GO