USE Proyecto_BasesII;
GO

CREATE PROCEDURE ActualizarCliente(@IdCliente INT, @Nombre VARCHAR(50), @Apellido VARCHAR(50), @Telefono VARCHAR(50), @Correo VARCHAR(50), @IdUbicacion INT)
AS
	IF @IdCliente IS NULL
		BEGIN
			RAISERROR(N'El ID es nulo', 15005, 1);
		END
	IF @Telefono IS NOT NULL
		BEGIN
			DECLARE @ComprobarTelefono INT;
			SET @ComprobarTelefono = (SELECT IdCliente FROM Cliente WHERE IdCliente != @IdCliente AND Telefono = @Telefono)
			IF @ComprobarTelefono IS NOT NULL
				BEGIN
					RAISERROR(N'Telefono utilizado', 15006, 1);
				END
		END
	IF @Correo IS NOT NULL
		BEGIN
			DECLARE @ComprobarCorreo INT;
			SET @ComprobarCorreo = (SELECT IdCliente FROM Cliente WHERE IdCliente != @IdCliente AND Correo = @Correo)
			IF @ComprobarCorreo IS NOT NULL
				BEGIN
					RAISERROR(N'Correo utilizado', 15007, 1);
				END
		END
	IF @IdUbicacion IS NOT NULL
		BEGIN
			DECLARE @ComprobarUbicacion INT;
			SET @ComprobarUbicacion = (SELECT IdUbicacion FROM Ubicacion WHERE IdUbicacion = @IdUbicacion)
			IF @ComprobarUbicacion IS NULL
				BEGIN
					RAISERROR(N'La ubicacion no existe', 15008, 1);
				END
		END
	BEGIN TRANSACTION
		UPDATE Cliente
		SET Nombre = @Nombre, Apellido = @Apellido, Telefono = @Telefono, Correo = @Correo, IdUbicacion = @IdUbicacion
		WHERE IdCliente = @IdCliente;
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO 