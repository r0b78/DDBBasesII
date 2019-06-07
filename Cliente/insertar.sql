USE Proyecto_BasesII;
GO

CREATE PROCEDURE InsertarCliente(@Nombre VARCHAR(50), @Apellido VARCHAR(50), @Telefono VARCHAR(50), @Correo VARCHAR(50), @IdUbicacion INT)
AS
	IF @Nombre IS NULL OR @Apellido IS NULL OR @Telefono IS NULL OR @Correo IS NULL OR @IdUbicacion IS NULL
		BEGIN
			RAISERROR(N'Informacion Incompleta', 15001, 1);
		END
	DECLARE @ComprobarCorreo	INT,
			@ComprobarTelefono	INT,
			@ComprobarUbicacion INT;
	SELECT	@ComprobarCorreo = (SELECT IdCliente FROM Cliente WHERE Correo = @Correo),
			@ComprobarTelefono = (SELECT IdCliente FROM Cliente WHERE Telefono = @Telefono),
			@ComprobarUbicacion = (SELECT IdUbicacion FROM Ubicacion WHERE IdUbicacion = @IdUbicacion)
	IF @ComprobarCorreo IS NOT NULL
		BEGIN
			RAISERROR(N'Correo ya utilizado', 15002, 1);
		END
	ELSE IF @ComprobarTelefono IS NOT NULL
		BEGIN
			RAISERROR(N'Numero de telefono duplicado', 15003, 1);
		END
	ELSE IF @ComprobarUbicacion IS NULL
		BEGIN
			RAISERROR(N'No existe la ubicacion', 15004, 1);
		END
	ELSE
		BEGIN TRANSACTION
			INSERT INTO Cliente(Nombre, Apellido, Telefono, Correo, IdUbicacion)
			VALUES	(@Nombre, @Apellido, @Telefono, @Correo, @IdUbicacion);
		COMMIT TRANSACTION
		RETURN @@IDENTITY;
GO