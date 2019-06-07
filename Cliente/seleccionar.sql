USE Proyecto_BasesII;
GO

CREATE PROCEDURE SeleccionarClientes(@Nombre VARCHAR(50), @Apellido VARCHAR(50), @Telefono VARCHAR(50), @Correo VARCHAR(50), @Provincia VARCHAR(50), @Pais VARCHAR(50))
AS
	SELECT Cliente.Nombre, Apellido, Telefono, Correo
	FROM Cliente
	INNER JOIN Ubicacion
	ON Ubicacion.IdUbicacion = Cliente.IdUbicacion
	INNER JOIN Provincia
	ON Provincia.IdProvincia = Ubicacion.IdProvincia
	INNER JOIN Pais
	ON Provincia.IdPais = Pais.IdPais
	WHERE	Cliente.Nombre = ISNULL(@Nombre, Cliente.Nombre) AND
			Apellido = ISNULL(@Apellido, Apellido) AND
			Telefono = ISNULL(@Telefono, Telefono) AND
			Correo = ISNULL(@Correo, Correo) AND
			Provincia.Nombre = ISNULL(@Provincia, Provincia.Nombre) AND
			Pais.Nombre = ISNULL(@Pais, Pais.Nombre);
GO