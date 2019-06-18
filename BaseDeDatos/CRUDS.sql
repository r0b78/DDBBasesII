USE Proyecto_BasesII;
GO

create or alter procedure insertarPais
                  @Nombre varchar(50),
				  @Locacion geometry
AS 
BEGIN
     declare @PaisRepetido varchar(50)
	 SELECT @PaisRepetido = Nombre
	 FROM Pais
	 WHERE Nombre = @Nombre
	 
	 IF @PaisRepetido IS NULL
		BEGIN
		BEGIN TRANSACTION
		insert into Pais(Nombre,Locacion)
		values (@Nombre,@Locacion)
		COMMIT
		SELECT Nombre,Locacion,IdPais
		FROM Pais
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'El pais ya existe en la base'
		SELECT @error as Error
		END
END
GO

create or alter procedure seleccionarPais
                  @Nombre varchar(50)
AS 
BEGIN

	 SELECT Nombre,IdPais,Locacion
	 FROM Pais
	 WHERE Nombre = isnull(@Nombre,Pais.Nombre)
END
GO

create or alter procedure modificarPais
                  @Nombre varchar(50),
				  @NuevoNombre varchar(50),
				  @Locacion geometry
AS 
BEGIN
     declare @PaisRepetido int
	 SELECT @PaisRepetido = IdPais
	 FROM Pais
	 WHERE Nombre = @Nombre
	 
	 IF @PaisRepetido IS NULL
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'El pais no existe en la base'
		SELECT @error as Error
		END
	ELSE
		BEGIN
		

		BEGIN TRANSACTION
		UPDATE Pais
		SET Nombre = isnull(@NuevoNombre,Nombre),Locacion = isnull(@Locacion,Locacion)
		WHERE  IdPais = @PaisRepetido
		COMMIT
		SELECT Nombre,Locacion,IdPais
		FROM Pais
		END
END
GO

create or alter procedure insertarProvincia
                  @Nombre varchar(50),
				  @Locacion geometry,
				  @idPais   int
AS 
BEGIN
     declare @ProvinciaRepetida varchar(50)
	 declare @PaisConfirmado    int

	 SELECT @ProvinciaRepetida = Nombre
	 FROM Provincia
	 WHERE Nombre = @Nombre

	 SELECT @PaisConfirmado = IdPais
	 FROM   Pais
	 WHERE  IdPais = @idPais
	 
	 IF @ProvinciaRepetida IS NULL AND @PaisConfirmado IS NOT NULL
		BEGIN
		BEGIN TRANSACTION
		insert into Provincia(Nombre,IdPais,LocacionProvincia)
		values (@Nombre,@PaisConfirmado,@Locacion)
		COMMIT
		SELECT Nombre,LocacionProvincia,IdProvincia,IdPais
		FROM Provincia
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'La provincia ya existe en la base'
		SELECT @error as Error
		END
END
GO

create or alter procedure seleccionarProvincia
                  @Nombre varchar(50),
				  @Pais   varchar(50)
AS 
BEGIN

	 SELECT Provincia.Nombre,Provincia.IdProvincia,Provincia.LocacionProvincia,Provincia.IdPais,Pais.Nombre
	 FROM Pais inner join Provincia on Pais.IdPais = Provincia.IdPais
	 WHERE Provincia.Nombre = isnull(@Nombre,Provincia.Nombre) AND Pais.Nombre = isnull(@Pais,Pais.Nombre)
END
GO


create or alter procedure modificarProvincia
                  @Nombre varchar(50),
				  @NuevoNombre varchar(50),
				  @Locacion geometry,
				  @idPais     int
AS 
BEGIN
     declare @ProvinciaRepetida int
	 declare @PaisConfirmado    int

	 SELECT @ProvinciaRepetida = IdProvincia
	 FROM Provincia
	 WHERE Nombre = @Nombre

	 SELECT @PaisConfirmado = IdPais
	 FROM   Pais
	 WHERE  IdPais = @idPais
	 
	 IF @ProvinciaRepetida IS NULL 
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'El pais o la provincia no existe en la base'
		SELECT @error as Error
		END
	ELSE
		BEGIN
		

		BEGIN TRANSACTION
		UPDATE Provincia
		SET Nombre = isnull(@NuevoNombre,Nombre),LocacionProvincia = isnull(@Locacion,LocacionProvincia),IdPais = isnull(@PaisConfirmado,IdPais)
		WHERE  IdProvincia = @ProvinciaRepetida
		COMMIT
		SELECT Nombre,LocacionProvincia,IdPais,IdProvincia
		FROM Provincia
		END
END
GO

create or alter procedure insertarUbicacion
                  @Descripcion varchar(50),
				  @Locacion geometry,
				  @NombreProvincia   varchar(50)
AS 
BEGIN
     declare @UbicacionRepetida varchar(50)
	 declare @ProvinciaConfirmado    int

	 SELECT @UbicacionRepetida = Descripcion
	 FROM Ubicacion
	 WHERE Descripcion = @Descripcion

	 SELECT @ProvinciaConfirmado = IdProvincia
	 FROM   Provincia
	 WHERE  Nombre = @NombreProvincia
	 
	 IF @UbicacionRepetida IS NULL AND @ProvinciaConfirmado IS NOT NULL
		BEGIN
		BEGIN TRANSACTION
		insert into Ubicacion(Descripcion,IdProvincia,LocacionExacta)
		values (@Descripcion,@ProvinciaConfirmado,@Locacion)
		COMMIT
		SELECT @@IDENTITY AS IdUbicacion
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'La ubicacion ya existe en la base'
		SELECT @error as Error
		END
END
GO

create or alter procedure seleccionarUbicacion
                  @Descripcion varchar(50),
				  @Provincia   varchar(50)
AS 
BEGIN

	 SELECT Ubicacion.Descripcion,Ubicacion.IdProvincia,Ubicacion.LocacionExacta,Ubicacion.IdUbicacion,Provincia.Nombre
	 FROM Provincia inner join Ubicacion on Provincia.IdProvincia = Ubicacion.IdUbicacion
	 WHERE Ubicacion.Descripcion = isnull(@Descripcion,Ubicacion.Descripcion) AND Provincia.Nombre = isnull(@Provincia,Provincia.Nombre)
END
GO

create or alter procedure modificarUbicacion
                  @Descripcion varchar(50),
				  @NuevaDescripcion varchar(50),
				  @Locacion geometry,
				  @idProvincia     int
AS 
BEGIN
     declare @UbicacionRepetida int
	 declare @ProvinciaConfirmada   int

	 SELECT @UbicacionRepetida = IdUbicacion
	 FROM Ubicacion
	 WHERE Descripcion = @Descripcion

	 SELECT @ProvinciaConfirmada = IdProvincia
	 FROM   Provincia
	 WHERE  IdProvincia = @idProvincia
	 
	 IF @UbicacionRepetida IS NULL 
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'La ubicacion o la provincia no existe en la base'
		SELECT @error as Error
		END
	ELSE
		BEGIN

		BEGIN TRANSACTION
		UPDATE Ubicacion
		SET Descripcion = isnull(@NuevaDescripcion,Descripcion),LocacionExacta = isnull(@Locacion,LocacionExacta),IdProvincia = isnull(@ProvinciaConfirmada,IdProvincia)
		WHERE  IdUbicacion = @UbicacionRepetida
		COMMIT
		SELECT Descripcion,LocacionExacta,IdUbicacion,IdProvincia
		FROM Ubicacion
		END
END
GO

create or alter procedure insertarCaracteristica
                  @Caracteristica varchar(50),
				  @Dato varchar(50)
AS 
BEGIN
     declare @DatoRepetido varchar(50)

	 SELECT @DatoRepetido = Dato
	 FROM Caracteristica
	 WHERE Dato = @Dato
	 
	 IF @DatoRepetido IS NULL
		BEGIN
		BEGIN TRANSACTION
		insert into Caracteristica(Caracteristica,Dato)
		values (@Caracteristica,@Dato)
		COMMIT
		SELECT Caracteristica,Dato,IdCaracteristica
		FROM Caracteristica
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'La caracteristica ya existe'
		SELECT @error as Error
		END
END
GO

create or alter procedure seleccionarCaracteristica
                  @Caracteristica varchar(50),
				  @Dato varchar(50)
AS 
BEGIN

     SELECT IdCaracteristica,Caracteristica,Dato
	 FROM Caracteristica
	 WHERE Caracteristica.Caracteristica = isnull(@Caracteristica,Caracteristica.Caracteristica) AND Caracteristica.Dato = isnull(@Dato,Caracteristica.Dato)
END
GO

create or alter procedure modificarCaracteristica
                  @Dato varchar(50),
				  @NuevoDato varchar(50),
				  @Caracteristica varchar(50)
AS 
BEGIN
     declare @DatoConfirmado int

	 SELECT @DatoConfirmado = IdCaracteristica
	 FROM Caracteristica
	 WHERE Dato = @Dato

	 
	 IF @DatoConfirmado IS NULL
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'La caracteristica no existe'
		SELECT @error as Error
		END
	ELSE
		BEGIN
		BEGIN TRANSACTION
		UPDATE Caracteristica
		SET Dato = isnull(@NuevoDato,Dato),Caracteristica = isnull(@Caracteristica,Caracteristica)
		WHERE  IdCaracteristica = @DatoConfirmado
		COMMIT
		SELECT Caracteristica,Dato,IdCaracteristica
		FROM Caracteristica
		END
END
GO

create or alter procedure insertarExtra
                  @Nombre varchar(50),
				  @Descripcion varchar(50),
				  @Precio   int
AS 
BEGIN
     declare @ExtraRepetido varchar(50)

	 SELECT @ExtraRepetido = Nombre
	 FROM Extra
	 WHERE Nombre = @Nombre
	 
	 IF @ExtraRepetido IS NULL
		BEGIN
		BEGIN TRANSACTION
		insert into Extra(Nombre,Descripcion,Precio)
		values (@Nombre,@Descripcion,@Precio)
		COMMIT
		SELECT Nombre,Descripcion,Precio,IdExtra
		FROM Extra
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'El extra ya existe'
		SELECT @error as Error
		END
END
GO

create or alter procedure seleccionarExtra
                  @Nombre varchar(50),
				  @Descripcion varchar(50),
				  @Precio   int
AS 
BEGIN
     SELECT Nombre,Descripcion,Precio,IdExtra
	 FROM Extra
	 WHERE Nombre = isnull(@Nombre,Nombre) AND Descripcion = isnull(@Descripcion,Descripcion) AND Precio = isnull(@Precio,Precio)
END
GO

create or alter procedure modificarExtra
                  @Nombre varchar(50),
				  @NuevoNombre varchar(50),
				  @Descripcion varchar(50),
				  @Precio   int
AS 
BEGIN
     declare @ExtraConfirmado int

	 SELECT @ExtraConfirmado = IdExtra
	 FROM Extra
	 WHERE Nombre = @Nombre
	 
	 IF @ExtraConfirmado IS NULL
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'El extra no existe'
		SELECT @error as Error
		END
	ELSE
		BEGIN
		BEGIN TRANSACTION
		UPDATE Extra
		SET Nombre = isnull(@NuevoNombre,Nombre),Descripcion = isnull(@Descripcion,Descripcion), Precio = isnull(@Precio,Precio)
		WHERE  IdExtra = @ExtraConfirmado
		COMMIT
		SELECT Nombre,Descripcion,Precio,IdExtra
		FROM Extra
		END
END
GO

create or alter procedure insertarTipoVehiculo
                  @Nombre varchar(50)
AS 
BEGIN
     declare @TipoRepetido varchar(50)

	 SELECT @TipoRepetido = Nombre
	 FROM TipoVehiculo
	 WHERE Nombre = @Nombre
	 
	 IF @TipoRepetido IS NULL
		BEGIN
		BEGIN TRANSACTION
		insert into TipoVehiculo(Nombre)
		values (@Nombre)
		COMMIT
		SELECT Nombre,IdTipoVehiculo
		FROM TipoVehiculo
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'El tipo ya existe'
		SELECT @error as Error
		END
END
GO

create or alter procedure seleccionarTipoVehiculo
                  @Nombre varchar(50)
AS 
BEGIN
     SELECT Nombre,IdTipoVehiculo
	 FROM TipoVehiculo
	 WHERE Nombre = isnull(@Nombre,Nombre)
END
GO

create or alter procedure modificarTipoVehiculo
                  @Nombre varchar(50),
				  @NuevoNombre varchar(50)
AS 
BEGIN
     declare @TipoConfirmado int

	 SELECT @TipoConfirmado = IdTipoVehiculo
	 FROM TipoVehiculo
	 WHERE Nombre = @Nombre
	 
	 IF @TipoConfirmado IS NULL
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'El tipo no existe'
		SELECT @error as Error
		END
	ELSE
		BEGIN
		BEGIN TRANSACTION
		UPDATE TipoVehiculo
		SET Nombre = isnull(@NuevoNombre,Nombre)
		WHERE  IdTipoVehiculo = @TipoConfirmado
		COMMIT
		SELECT Nombre,IdTipoVehiculo
		FROM TipoVehiculo
		END
END
GO

create or alter procedure insertarCombustible
                  @Nombre varchar(50)
AS 
BEGIN
     declare @CombustibleRepetido varchar(50)

	 SELECT @CombustibleRepetido = Nombre
	 FROM Combustible
	 WHERE Nombre = @Nombre
	 
	 IF @CombustibleRepetido IS NULL
		BEGIN
		BEGIN TRANSACTION
		insert into Combustible(Nombre)
		values (@Nombre)
		COMMIT
		SELECT Nombre,IdCombustible
		FROM Combustible
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'El combustible ya existe'
		SELECT @error as Error
		END
END
GO

create or alter procedure seleccionarCombustible
                  @Nombre varchar(50)
AS 
BEGIN
     SELECT Nombre,IdCombustible
	 FROM Combustible
	 WHERE Nombre = isnull(@Nombre,Nombre)
END
GO

create or alter procedure modificarCombustible
                  @Nombre varchar(50),
				  @NuevoNombre varchar(50)
AS 
BEGIN
     declare @CombustibleConfirmado int

	 SELECT @CombustibleConfirmado = IdCombustible
	 FROM Combustible
	 WHERE Nombre = @Nombre
	 
	 IF @CombustibleConfirmado IS NULL
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'El combustible no existe'
		SELECT @error as Error
		END
	ELSE
		BEGIN
		BEGIN TRANSACTION
		UPDATE Combustible
		SET Nombre = isnull(@NuevoNombre,Nombre)
		WHERE  IdCombustible = @CombustibleConfirmado
		COMMIT
		SELECT Nombre,IdCombustible
		FROM Combustible
		END
END
GO

create or alter procedure insertarVehiculo
                  @Tipo varchar(50),
				  @Combustible varchar(50),
				  @Marca   varchar(50),
				  @Modelo  varchar(50),
				  @Precio   int,
				  @usado	bit,
				  @puertas  int
AS 
BEGIN
	 declare @TipoConfirmado    int
	 declare @CombustibleConfirmado    int

	 SELECT @TipoConfirmado = IdTipoVehiculo
	 FROM TipoVehiculo
	 WHERE Nombre = @Tipo

	 SELECT @CombustibleConfirmado = IdCombustible
	 FROM   Combustible
	 WHERE  Nombre = @Combustible
	 
	 IF @TipoConfirmado IS NOT NULL AND @CombustibleConfirmado IS NOT NULL
		BEGIN
		BEGIN TRANSACTION
		insert into Vehiculo(IdTipoVehiculo,IdCombustible,Marca,Modelo,Precio, Usado,Puertas)
		values (@TipoConfirmado,@CombustibleConfirmado,@Marca,@Modelo,@Precio, @usado,@puertas)
		COMMIT
		SELECT IdVehiculo,IdTipoVehiculo,IdCombustible,Marca,Modelo,Precio
		FROM Vehiculo
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'El combustible o tipo indicado no existen'
		SELECT @error as Error
		END
END
GO

create or alter  procedure seleccionarVehiculo
                  @Tipo varchar(50),
				  @Combustible varchar(50),
				  @Marca   varchar(50),
				  @Modelo  varchar(50),
				  @PrecioLow   int,
				  @PrecioHigh  int,
				  @usado	   bit,
				  @puertas     int
AS 
BEGIN

	 SELECT Vehiculo.IdVehiculo,TipoVehiculo.Nombre as Tipo,Combustible.Nombre as Combustible,Vehiculo.Marca,Vehiculo.Modelo,Vehiculo.Precio,Vehiculo.Puertas,Vehiculo.Usado
	 FROM Vehiculo inner join TipoVehiculo on Vehiculo.IdTipoVehiculo = TipoVehiculo.IdTipoVehiculo
		  inner join Combustible on Vehiculo.IdCombustible = Combustible.IdCombustible
	 WHERE Vehiculo.Marca = isnull(@Marca,Vehiculo.Marca) AND Vehiculo.Modelo = isnull(@Modelo,Vehiculo.Modelo) AND Vehiculo.Precio between isnull(@PrecioLow,Vehiculo.Precio) and isnull(@PrecioHigh,Vehiculo.Precio)
		   AND TipoVehiculo.Nombre = isnull(@Tipo,TipoVehiculo.Nombre) AND Combustible.Nombre = isnull(@Combustible,Combustible.Nombre) and
		   Vehiculo.Usado = ISNULL(@usado, Vehiculo.Usado) AND Vehiculo.Puertas = isnull(@puertas,Vehiculo.Puertas) AND Vehiculo.IdVehiculo NOT IN (SELECT FacturaXVehiculo.IdVehiculo FROM FacturaXVehiculo )
END
GO


create or alter  procedure seleccionarVehiculoComprado
                  @Tipo varchar(50),
				  @Combustible varchar(50),
				  @Marca   varchar(50),
				  @Modelo  varchar(50),
				  @PrecioLow   int,
				  @PrecioHigh  int
AS 
BEGIN

	 SELECT Vehiculo.IdVehiculo,TipoVehiculo.Nombre as Tipo,Combustible.Nombre as Combustible,Vehiculo.Marca,Vehiculo.Modelo,Vehiculo.Precio
	 FROM Vehiculo inner join TipoVehiculo on Vehiculo.IdTipoVehiculo = TipoVehiculo.IdTipoVehiculo
		  inner join Combustible on Vehiculo.IdCombustible = Combustible.IdCombustible
		  inner join FacturaXVehiculo on FacturaXVehiculo.IdVehiculo = Vehiculo.IdVehiculo
	 WHERE Vehiculo.Marca = isnull(@Marca,Vehiculo.Marca) AND Vehiculo.Modelo = isnull(@Modelo,Vehiculo.Modelo) AND Vehiculo.Precio between isnull(@PrecioLow,Vehiculo.Precio) and isnull(@PrecioHigh,Vehiculo.Precio)
		   AND TipoVehiculo.Nombre = isnull(@Tipo,TipoVehiculo.Nombre) AND Combustible.Nombre = isnull(@Combustible,Combustible.Nombre)
END
GO

create or alter procedure modificarVehiculo
			      @idVehiculo int,
                  @Tipo varchar(50),
				  @Combustible varchar(50),
				  @Marca   varchar(50),
				  @Modelo  varchar(50),
				  @Precio  int,
				  @Usado bit,
				  @Puertas int
AS 
BEGIN
     declare @VehiculoConfirmado int
	 declare @TipoConfirmado    int
	 declare @CombustibleConfirmado    int

	 SELECT @TipoConfirmado = IdTipoVehiculo
	 FROM TipoVehiculo
	 WHERE Nombre = @Tipo

	 SELECT @CombustibleConfirmado = IdCombustible
	 FROM   Combustible
	 WHERE  Nombre =  @Combustible

	 SELECT @VehiculoConfirmado = IdVehiculo
	 FROM Vehiculo
	 WHERE IdVehiculo = @idVehiculo
	 
	 IF @VehiculoConfirmado IS NULL 
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'El vehiculo tipo o combustible no existe'
		SELECT @error as Error
		END
	ELSE
		BEGIN
		BEGIN TRANSACTION
		UPDATE Vehiculo
		SET IdTipoVehiculo = isnull(@TipoConfirmado,IdTipoVehiculo),IdCombustible = isnull(@CombustibleConfirmado,IdCombustible),Marca = isnull(@Marca,Marca),Modelo = isnull(@Modelo,Modelo),
		    Precio = isnull(@Precio,Precio),Usado = ISNULL(@Usado,Usado),Puertas = ISNULL(@Puertas,Puertas)
		WHERE  IdVehiculo = @VehiculoConfirmado
		COMMIT
		SELECT IdVehiculo,IdTipoVehiculo,IdCombustible,Marca,Modelo,Precio
		FROM Vehiculo
		END
END
GO

create or alter procedure insertarFotoVehiculo
                  @foto nvarchar(128),
				  @Nombre varchar(50),
				  @fecha   date,
				  @idVehiculo int
AS 
BEGIN
	 declare @VehiculoConfirmado    int

	 SELECT @VehiculoConfirmado = IdVehiculo
	 FROM   Vehiculo
	 WHERE  IdVehiculo = @idVehiculo
	 
	 IF @VehiculoConfirmado IS NOT NULL 
		BEGIN
		BEGIN TRANSACTION
		INSERT INTO FotoVehiculo (Fecha,Foto,NombreFoto,IdVehiculo)
		VALUES (GETDATE(),@foto,@Nombre,@idVehiculo)
		COMMIT
		SELECT IdFotoVehiculo,Foto,NombreFoto,Fecha,IdVehiculo
		FROM FotoVehiculo
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'El vehiculo indicado no existe'
		SELECT @error as Error
		END
END
GO

create or alter procedure seleccionarFotoVehiculo
				  @Nombre varchar(50),
				  @fechaInicio   date,
				  @fechaFin date,
				  @idVehiculo int
AS 
BEGIN

	 SELECT IdFotoVehiculo,Foto,NombreFoto,Fecha,FotoVehiculo.IdVehiculo,Vehiculo.Modelo,Vehiculo.Marca
	 FROM FotoVehiculo inner join Vehiculo on FotoVehiculo.IdVehiculo = Vehiculo.IdVehiculo
	 WHERE  FotoVehiculo.NombreFoto = isnull(@Nombre,FotoVehiculo.NombreFoto) AND 
	        FotoVehiculo.Fecha between isnull(@fechaInicio,FotoVehiculo.Fecha) AND isnull(@fechaFin,FotoVehiculo.Fecha) AND 
			FotoVehiculo.IdVehiculo = isnull(@idVehiculo,FotoVehiculo.IdVehiculo) 

END
GO

create or alter procedure modificarFotoVehiculo
				  @IdFotoVehiculo int,
			      @foto varchar(50),
				  @Nombre varchar(50),
				  @fecha   date,
				  @idVehiculo int
AS 
BEGIN
     declare @VehiculoConfirmado    int
	 declare @fotoConfirmada int
	 declare @sql            varchar(max)

	 SELECT @fotoConfirmada = IdFotoVehiculo
	 FROM   FotoVehiculo
	 WHERE  IdFotoVehiculo = @IdFotoVehiculo

	 SELECT @VehiculoConfirmado = IdVehiculo
	 FROM   Vehiculo
	 WHERE  IdVehiculo = @idVehiculo

	 set @sql = 'UPDATE FotoVehiculo SET Foto = (SELECT BulkColumn FROM OPENROWSET(BULK '''+@foto+''', SINGLE_BLOB) as X) WHERE IdFotoVehiculo =' + Cast(@fotoConfirmada as varchar(50))
	 
	 IF @fotoConfirmada is null
	    BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'El vehiculo indicado no existe'
		SELECT @error as Error
		END

	 ELSE IF @foto is not null
		BEGIN
		BEGIN TRANSACTION
		exec (@sql)
		UPDATE FotoVehiculo
		SET NombreFoto = isnull(@Nombre,NombreFoto),Fecha = isnull(@fecha,Fecha),IdVehiculo = isnull(@VehiculoConfirmado,IdVehiculo)
		WHERE  IdFotoVehiculo = @fotoConfirmada
		COMMIT
		SELECT IdFotoVehiculo,Foto,NombreFoto,Fecha,IdVehiculo
		FROM FotoVehiculo
		END
	ELSE IF @foto is null
		BEGIN
		BEGIN TRANSACTION
		UPDATE FotoVehiculo
		SET NombreFoto = isnull(@Nombre,NombreFoto),Fecha = isnull(@fecha,Fecha),IdVehiculo = isnull(@VehiculoConfirmado,IdVehiculo)
		WHERE  IdFotoVehiculo = @fotoConfirmada
		COMMIT
		SELECT IdFotoVehiculo,Foto,NombreFoto,Fecha,IdVehiculo
		FROM FotoVehiculo
		END
END
GO

create or alter procedure insertarExtraXVehiculo
				  @idExtra int,
				  @idVehiculo int
AS 
BEGIN
	 declare @VehiculoConfirmado    int
	 declare @ExtraConfirmado       int
	 declare @Precio                int

	 SELECT @VehiculoConfirmado = IdVehiculo
	 FROM   Vehiculo
	 WHERE  IdVehiculo = @idVehiculo

	 SELECT @ExtraConfirmado = IdExtra,@Precio = Precio
	 FROM   Extra
	 WHERE  IdExtra = @idExtra
	 
	 IF @VehiculoConfirmado IS NOT NULL AND @ExtraConfirmado IS NOT NULL
		BEGIN
		BEGIN TRANSACTION
		insert into ExtraXVehiculo(IdExtra,IdVehiculo,PrecioPagado)
		Values (@ExtraConfirmado,@VehiculoConfirmado,@Precio)
		COMMIT
		SELECT IdExtra,IdVehiculo,PrecioPagado
		FROM ExtraXVehiculo
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'El vehiculo o extra indicado no existen'
		SELECT @error as Error
		END
END
GO

create or alter procedure seleccionarExtraXVehiculo
				  @idExtra int,
				  @idVehiculo int,
				  @precioLow int,
				  @precioHigh int
AS 
BEGIN

	 SELECT Vehiculo.Marca,Vehiculo.Modelo,Extra.Nombre,ExtraXVehiculo.IdExtraXVehiculo,ExtraXVehiculo.PrecioPagado
	 FROM   ExtraXVehiculo inner join Vehiculo on ExtraXVehiculo.IdVehiculo = Vehiculo.IdVehiculo
	        inner join Extra on ExtraXVehiculo.IdExtra = Extra.IdExtra
	 WHERE  ExtraXVehiculo.IdExtra  = isnull(@idExtra,ExtraXVehiculo.idExtra) AND ExtraXVehiculo.IdVehiculo  = isnull(@IdVehiculo,ExtraXVehiculo.IdVehiculo) AND 
	        ExtraXVehiculo.PrecioPagado between isnull(@precioLow,ExtraXVehiculo.PrecioPagado) and isnull(@precioHigh,ExtraXVehiculo.PrecioPagado)
	 
END
GO

create or alter procedure modificarExtraXVehiculo
				  @idExtraXVehiculo int,
				  @idExtra int,
				  @idVehiculo int,
				  @precio int
AS 
BEGIN
	 declare @VehiculoConfirmado    int
	 declare @ExtraConfirmado       int
	 declare @ExtraXVehiculoConfirmado int

	 SELECT @VehiculoConfirmado = IdVehiculo
	 FROM   Vehiculo
	 WHERE  IdVehiculo = @idVehiculo

	 SELECT @ExtraConfirmado = IdExtra
	 FROM   Extra
	 WHERE  IdExtra = @idExtra

	 SELECT @ExtraXVehiculoConfirmado = IdExtraXVehiculo
	 FROM   ExtraXVehiculo
	 WHERE  IdExtraXVehiculo = @idExtraXVehiculo
	 
	 IF @ExtraXVehiculoConfirmado IS NOT NULL
		BEGIN
		BEGIN TRANSACTION
		UPDATE ExtraXVehiculo
		SET PrecioPagado = isnull(@precio,PrecioPagado),IdExtra = isnull(@ExtraConfirmado,IdExtra),IdVehiculo = isnull(@VehiculoConfirmado,IdVehiculo)
		WHERE IdExtraXVehiculo = @ExtraXVehiculoConfirmado
		COMMIT
		SELECT IdExtra,IdVehiculo,PrecioPagado
		FROM ExtraXVehiculo
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'El extraXVehiculo no existe'
		SELECT @error as Error
		END
END
GO

create or alter procedure insertarVehiculoXSucursal
				  @idVehiculo int,
				  @idSucursal int
AS 
BEGIN
	 declare @VehiculoConfirmado    int
	 declare @SucursalConfirmada       int

	 SELECT @VehiculoConfirmado = IdVehiculo
	 FROM   Vehiculo
	 WHERE  IdVehiculo = @idVehiculo

	 SELECT @SucursalConfirmada = IdSucursal
	 FROM   Sucursal
	 WHERE  IdSucursal = @idSucursal
	 
	 IF @VehiculoConfirmado IS NOT NULL AND @SucursalConfirmada IS NOT NULL
		BEGIN
		BEGIN TRANSACTION
		insert into VehiculoXSucursal(IdSucursal,IdVehiculo)
		Values (@SucursalConfirmada,@VehiculoConfirmado)
		COMMIT
		SELECT IdSucursal,IdVehiculo
		FROM VehiculoXSucursal
		END
	ELSE
		BEGIN
		DECLARE @error varchar(100)
		SET	 @error = 'El vehiculo o sucursal indicado no existen'
		SELECT @error as Error
		END
END
GO

create or alter procedure seleccionarVehiculoXSucursal
				  @idVehiculo int,
				  @idSucursal int
AS 
BEGIN

	 SELECT Vehiculo.Marca,Vehiculo.Modelo,Sucursal.Nombre,VehiculoXSucursal.IdVehiculoXSucursal
	 FROM   VehiculoXSucursal inner join Vehiculo on VehiculoXSucursal.IdVehiculo = Vehiculo.IdVehiculo
	        inner join Sucursal on VehiculoXSucursal.IdSucursal = Sucursal.IdSucursal
	 WHERE  VehiculoXSucursal.IdSucursal  = isnull(@idSucursal,VehiculoXSucursal.IdSucursal) AND VehiculoXSucursal.IdVehiculo  = isnull(@IdVehiculo,VehiculoXSucursal.IdVehiculo)
END
GO

create or alter procedure modificarVehiculoXSucursal
				  @idVehiculoXSucursal int,
				  @idSucursal int,
				  @idVehiculo int
AS 
BEGIN
	 declare @VehiculoConfirmado    int
	 declare @SucursalConfirmada       int
	 declare @VehiculoXSucursalConfirmado int

	 SELECT @VehiculoConfirmado = IdVehiculo
	 FROM   Vehiculo
	 WHERE  IdVehiculo = @idVehiculo

	 SELECT @SucursalConfirmada = IdSucursal
	 FROM   Sucursal
	 WHERE  IdSucursal = @idSucursal

	 SELECT @VehiculoXSucursalConfirmado = IdVehiculoXSucursal
	 FROM   VehiculoXSucursal
	 WHERE  IdVehiculoXSucursal = @idVehiculoXSucursal
	 
	 IF @VehiculoXSucursalConfirmado IS NOT NULL
		BEGIN
		BEGIN TRANSACTION
		UPDATE VehiculoXSucursal
		SET IdSucursal = isnull(@SucursalConfirmada,IdSucursal),IdVehiculo = isnull(@VehiculoConfirmado,IdVehiculo)
		WHERE IdVehiculoXSucursal = @VehiculoXSucursalConfirmado
		COMMIT
		SELECT IdVehiculoXSucursal,IdVehiculo
		FROM VehiculoXSucursal
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'El VehiculoXSucursal no existe'
		SELECT @error as Error
		END
END
GO

create or alter procedure insertarCaracteristicaXVehiculo
				  @idCaracteristica int,
				  @idVehiculo int
AS 
BEGIN
	 declare @VehiculoConfirmado    int
	 declare @CaracteristicaConfirmado       int

	 SELECT @VehiculoConfirmado = IdVehiculo
	 FROM   Vehiculo
	 WHERE  IdVehiculo = @idVehiculo

	 SELECT @CaracteristicaConfirmado = IdCaracteristica
	 FROM   Caracteristica
	 WHERE  IdCaracteristica = @idCaracteristica
	 
	 IF @VehiculoConfirmado IS NOT NULL AND @CaracteristicaConfirmado IS NOT NULL
		BEGIN
		BEGIN TRANSACTION
		insert into CaracteristicaXVehiculo(IdCaracteristica,IdVehiculo)
		Values (@CaracteristicaConfirmado,@VehiculoConfirmado)
		COMMIT
		SELECT IdCaracteristica,IdVehiculo
		FROM CaracteristicaXVehiculo
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'El vehiculo o caracteristica indicado no existen'
		SELECT @error as Error
		END
END
GO

create or alter procedure seleccionarCaracteristicaXVehiculo
				  @idCaracteristica int,
				  @idVehiculo int
AS 
BEGIN

	 SELECT Vehiculo.Marca,Vehiculo.Modelo,Caracteristica.Dato,CaracteristicaXVehiculo.IdCaracteristicaXVehiculo
	 FROM   CaracteristicaXVehiculo inner join Vehiculo on CaracteristicaXVehiculo.IdVehiculo = Vehiculo.IdVehiculo
	        inner join Caracteristica on CaracteristicaXVehiculo.IdCaracteristica = Caracteristica.IdCaracteristica
	 WHERE  CaracteristicaXVehiculo.IdCaracteristica  = isnull(@idCaracteristica,CaracteristicaXVehiculo.IdCaracteristica) AND 
	        CaracteristicaXVehiculo.IdVehiculo  = isnull(@IdVehiculo,CaracteristicaXVehiculo.IdVehiculo) 
	 
END
GO

create or alter procedure modificarCaracteristicaXVehiculo
				  @idCaracteristicaXVehiculo int,
				  @idCaracteristica int,
				  @idVehiculo int
AS 
BEGIN
	 declare @VehiculoConfirmado    int
	 declare @CaracteristicaConfirmado       int
	 declare @CaracteristicaXVehiculoConfirmado int

	 SELECT @VehiculoConfirmado = IdVehiculo
	 FROM   Vehiculo
	 WHERE  IdVehiculo = @idVehiculo

	 SELECT @CaracteristicaConfirmado = IdCaracteristica
	 FROM   Caracteristica
	 WHERE  IdCaracteristica = @idCaracteristica

	 SELECT @CaracteristicaXVehiculoConfirmado = IdCaracteristicaXVehiculo
	 FROM   CaracteristicaXVehiculo
	 WHERE  IdCaracteristicaXVehiculo = @idCaracteristicaXVehiculo
	 
	 IF @CaracteristicaXVehiculoConfirmado IS NOT NULL
		BEGIN
		BEGIN TRANSACTION
		UPDATE CaracteristicaXVehiculo
		SET IdCaracteristica = isnull(@CaracteristicaConfirmado,IdCaracteristica),IdVehiculo = isnull(@VehiculoConfirmado,IdVehiculo)
		WHERE IdCaracteristicaXVehiculo = @CaracteristicaXVehiculoConfirmado
		COMMIT
		SELECT IdCaracteristica,IdVehiculo
		FROM CaracteristicaXVehiculo
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'El CaracteristicaXVehiculo no existe'
		SELECT @error as Error
		END
END
GO

create or alter procedure insertarSucursal
                  @Nombre varchar(50),
				  @Descripcion varchar(50),
				  @IdUbicacion   int
AS 
BEGIN
     declare @SucursalRepetida varchar(50)
	 declare @UbicacionConfirmada  int
	 declare @UbicacionRepetida  int

	 SELECT @SucursalRepetida = Nombre
	 FROM Sucursal
	 WHERE Nombre = @Nombre

	 SELECT @UbicacionRepetida = IdUbicacion
	 FROM Sucursal
	 WHere IdUbicacion = @IdUbicacion

	 SELECT @UbicacionConfirmada = IdUbicacion
	 FROM   Ubicacion
	 WHERE  IdUbicacion = @IdUbicacion
	 
	 IF @SucursalRepetida IS NULL AND @UbicacionConfirmada IS NOT NULL AND @UbicacionRepetida is null
		BEGIN
		BEGIN TRANSACTION
		insert into Sucursal(Nombre,Descripcion,IdUbicacion)
		values (@Nombre,@Descripcion,@UbicacionConfirmada)
		COMMIT
		SELECT Nombre,Descripcion,IdUbicacion
		FROM Sucursal
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'La sucursal ya existe en la base o esa ubicacion esa ocupada'
		SELECT @error as Error
		END
END
GO

create or alter procedure seleccionarSucursal
                  @Nombre varchar(50),
				  @Descripcion varchar(50),
				  @NombrePais    varchar(50),
				  @NombreProvincia varchar(50)
AS 
BEGIN

	 SELECT Sucursal.IdSucursal,Sucursal.Nombre as NombreSucursal,Sucursal.Descripcion,Ubicacion.Descripcion as DescripcionUbicacion,Provincia.Nombre as NombreProvincia,Pais.Nombre as NombrePais
	 FROM  Sucursal INNER JOIN Ubicacion on Sucursal.IdUbicacion = Ubicacion.IdUbicacion,Pais,Provincia
	 WHERE Ubicacion.IdProvincia = Provincia.IdProvincia AND Provincia.IdPais = Pais.IdPais AND
		   Sucursal.Nombre = isnull(@Nombre,Sucursal.Nombre) AND Sucursal.Descripcion = isnull(@Descripcion,Sucursal.Descripcion) AND 
	       Provincia.Nombre = ISNULL(@NombreProvincia,Provincia.Nombre) AND
		   Pais.Nombre = ISNULL(@NombrePais,Pais.Nombre)

END
GO

create or alter procedure modificarSucursal
                  @Nombre varchar(50),
				  @NuevoNombre varchar(50),
				  @Descripcion varchar(50),
				  @IdUbicacion   int
AS 
BEGIN
     declare @SucursalRepetida varchar(50)
	 declare @UbicacionConfirmada  int
	 declare @UbicacionRepetida  int

	 SELECT @SucursalRepetida = Nombre
	 FROM Sucursal
	 WHERE Nombre = @Nombre

	 SELECT @UbicacionRepetida = IdUbicacion
	 FROM Sucursal
	 WHere IdUbicacion = @IdUbicacion

	 SELECT @UbicacionConfirmada = IdUbicacion
	 FROM   Ubicacion
	 WHERE  IdUbicacion = @IdUbicacion
	 
	 IF @SucursalRepetida IS NOT NULL AND @UbicacionConfirmada IS NOT NULL AND @UbicacionRepetida is null
		BEGIN
		BEGIN TRANSACTION
		UPDATE Sucursal
		SET Nombre = isnull(@Nombre,Nombre),Descripcion = isnull(@Descripcion,Descripcion),IdUbicacion = isnull(@IdUbicacion,IdUbicacion)
		COMMIT
		SELECT Nombre,Descripcion,IdUbicacion
		FROM Sucursal
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'La sucursal no existe en la base o esa ubicacion esa ocupada'
		SELECT @error as Error
		END
END
GO

create or alter procedure insertarPuestoEmpleado
                  @Puesto varchar(50)

AS 
BEGIN
	 declare @PuestoRepetido  varchar(50)

	 SELECT @PuestoRepetido = Puesto
	 FROM PuestoEmpleado
	 WHERE Puesto = @Puesto
	 
	 IF @PuestoRepetido IS NULL 
		BEGIN
		BEGIN TRANSACTION
		insert into PuestoEmpleado(Puesto)
		values (@Puesto)
		COMMIT
		SELECT Puesto,IdPuestoEmpleado
		FROM PuestoEmpleado
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'El puesto ya existe'
		SELECT @error as Error
		END
END
GO

create or alter procedure seleccionarPuestoEmpleado
                  @Puesto varchar(50)

AS 
BEGIN
	 SELECT  Puesto,IdPuestoEmpleado
	 FROM PuestoEmpleado
	 WHERE Puesto = isnull(@Puesto,Puesto)
END
GO

create or alter procedure modificarPuestoEmpleado
                  @Puesto varchar(50),
				  @NuevoPuesto varchar(50)

AS 
BEGIN
	 declare @PuestoRepetido  int

	 SELECT @PuestoRepetido = IdPuestoEmpleado
	 FROM PuestoEmpleado
	 WHERE Puesto = @Puesto
	 
	 IF @PuestoRepetido IS NOT NULL 
		BEGIN
		BEGIN TRANSACTION
		UPDATE PuestoEmpleado
		SET Puesto = isnull(@NuevoPuesto,Puesto)
		WHERE IdPuestoEmpleado = @PuestoRepetido
		COMMIT
		SELECT Puesto,IdPuestoEmpleado
		FROM PuestoEmpleado
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'El puesto no existe'
		SELECT @error as Error
		END
END
GO

create or alter procedure insertarEmpleadoSucursal
                  @Nombre   varchar(50),
				  @Apellido varchar(50),
				  @Telefono varchar(50),
				  @Correo   varchar(50),
				  @Supervisor varchar(50),
				  @Puesto   varchar(50),
				  @Sucursal int,
				  @Cedula   varchar(50),
				  @Pass     varchar(50)

AS 
BEGIN
     declare @CedulaRepetida varchar(50)
	 declare @SucursalConfirmada     int
	 declare @SupervisadorConfirmado int
	 declare @PuestoConfirmado       int

	 SELECT @CedulaRepetida = Cedula
	 FROM Empleado
	 WHERE Cedula = @Cedula

	 SELECT @SucursalConfirmada = IdSucursal
	 FROM   Sucursal
	 WHERE  IdSucursal = @Sucursal

	 SELECT @SupervisadorConfirmado = IdEmpleado
	 FROM   Empleado
	 WHERE  Cedula = @Supervisor

	 SELECT @PuestoConfirmado = IdPuestoEmpleado
	 FROM   PuestoEmpleado
	 WHERE  Puesto = @Puesto
	 
	 IF @CedulaRepetida IS NULL AND @SucursalConfirmada IS NOT NULL AND @PuestoConfirmado IS NOT NULL
		BEGIN
		BEGIN TRANSACTION
		INSERT INTO Usuario(Usuario, Pass, Privilegio)
        VALUES	(@Cedula, @Pass, 'Empleado')
		insert into Empleado(Nombre,Apellido,Telefono,Correo,IdSupervisor,IdPuestoEmpleado,Cedula,IdUsuario)
		values (@Nombre,@Apellido,@Telefono,@Correo,@SupervisadorConfirmado,@PuestoConfirmado,@Cedula,@@IDENTITY)
		insert into EmpleadoXSucursal(IdEmpleado,IdSucursal)
		values(@@IDENTITY,@SucursalConfirmada)
		COMMIT
		SELECT IdEmpleado,Nombre,Apellido,Telefono,Correo,IdSupervisor,IdPuestoEmpleado,Cedula
		FROM Empleado
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'La cedula indicada ya esta registrada o la sucursal o puesto no existen'
		SELECT @error as Error
		END
END
GO

create or alter procedure insertarEmpleadoFabrica
                  @Nombre   varchar(50),
				  @Apellido varchar(50),
				  @Telefono varchar(50),
				  @Correo   varchar(50),
				  @Supervisor varchar(50),
				  @Puesto   varchar(50),
				  @Fabrica int,
				  @Cedula   varchar(50),
				  @Pass     varchar(50)

AS 
BEGIN
     declare @CedulaRepetida varchar(50)
	 declare @FabricaConfirmada     int
	 declare @SupervisadorConfirmado int
	 declare @PuestoConfirmado       int

	 SELECT @CedulaRepetida = Cedula
	 FROM Empleado
	 WHERE Cedula = @Cedula

	 SELECT @FabricaConfirmada = IdFabrica
	 FROM   Fabrica
	 WHERE  IdFabrica = @Fabrica

	 SELECT @SupervisadorConfirmado = IdEmpleado
	 FROM   Empleado
	 WHERE  Cedula = @Supervisor

	 SELECT @PuestoConfirmado = IdPuestoEmpleado
	 FROM   PuestoEmpleado
	 WHERE  Puesto = @Puesto
	 
	 IF @CedulaRepetida IS NULL AND @FabricaConfirmada IS NOT NULL AND @PuestoConfirmado IS NOT NULL
		BEGIN
		BEGIN TRANSACTION
		INSERT INTO Usuario(Usuario, Pass, Privilegio)
        VALUES	(@Cedula, @Pass, 'Fabrica')
		insert into Empleado(Nombre,Apellido,Telefono,Correo,IdSupervisor,IdPuestoEmpleado,Cedula,IdUsuario)
		values (@Nombre,@Apellido,@Telefono,@Correo,@SupervisadorConfirmado,@PuestoConfirmado,@Cedula,@@IDENTITY)
		insert into EmpleadoXFabrica(IdEmpleado,IdFabrica)
		values(@@IDENTITY,@FabricaConfirmada)
		COMMIT
		SELECT IdEmpleado,Nombre,Apellido,Telefono,Correo,IdSupervisor,IdPuestoEmpleado,Cedula
		FROM Empleado
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'La cedula indicada ya esta registrada o la sucursal o puesto no existen'
		SELECT @error as Error
		END
END
GO

create or alter procedure seleccionarEmpleado
                  @Nombre   varchar(50),
				  @Apellido varchar(50),
				  @Telefono varchar(50),
				  @Correo   varchar(50),
				  @Supervisor varchar(50),
				  @Puesto   varchar(50),
				  @Sucursal int,
				  @Cedula   varchar(50)

AS 
BEGIN

	 SELECT  Empleado.IdEmpleado,Empleado.Nombre,Empleado.Apellido,Empleado.Telefono,Empleado.Correo,Empleado.IdSupervisor,PuestoEmpleado.Puesto,Sucursal.Nombre,Empleado.Cedula

	 FROM Empleado INNER JOIN PuestoEmpleado on Empleado.IdPuestoEmpleado = PuestoEmpleado.IdPuestoEmpleado
	      inner join EmpleadoXSucursal on Empleado.IdEmpleado = EmpleadoXSucursal.IdEmpleado
		  inner join Sucursal on EmpleadoXSucursal.IdSucursal = Sucursal.IdSucursal

	 WHERE
	       Empleado.Nombre = isnull(@Nombre,Empleado.Nombre) AND Empleado.Apellido = isnull(@Apellido,Empleado.Apellido) AND Empleado.Telefono = isnull(@Telefono,Empleado.Telefono)
	       AND Empleado.Correo = isnull(@Correo,Empleado.Correo) AND PuestoEmpleado.Puesto = isnull(@Puesto,PuestoEmpleado.Puesto)
		   AND Sucursal.IdSucursal = isnull(@Sucursal,Sucursal.IdSucursal) AND Empleado.Cedula = isnull(@Cedula,Empleado.Cedula)
 
END
GO


create or alter procedure modificarEmpleado
                  @Nombre   varchar(50),
				  @Apellido varchar(50),
				  @Telefono varchar(50),
				  @Correo   varchar(50),
				  @Supervisor varchar(50),
				  @Puesto   varchar(50),
				  @Cedula   varchar(50)

AS 
BEGIN
     declare @CedulaRepetida varchar(50)
	 declare @SupervisadorConfirmado int
	 declare @PuestoConfirmado       int

	 SELECT @CedulaRepetida = Cedula
	 FROM Empleado
	 WHERE Cedula = @Cedula


	 SELECT @SupervisadorConfirmado = IdEmpleado
	 FROM   Empleado
	 WHERE  Cedula = @Supervisor

	 SELECT @PuestoConfirmado = IdPuestoEmpleado
	 FROM   PuestoEmpleado
	 WHERE  Puesto = @Puesto
	 
	 IF @CedulaRepetida IS NOT NULL 
		BEGIN
		BEGIN TRANSACTION
		UPDATE Empleado
		SET Nombre = isnull(@Nombre,Nombre),Apellido = isnull(@Apellido,Apellido),Telefono = isnull(@Telefono,Telefono),Correo = isnull(@Correo,Correo),
		    IdSupervisor = isnull(@SupervisadorConfirmado,IdSupervisor),IdPuestoEmpleado = isnull(@PuestoConfirmado,IdPuestoEmpleado)
		Where Cedula = @CedulaRepetida
		COMMIT
		SELECT IdEmpleado,Nombre,Apellido,Telefono,Correo,IdSupervisor,IdPuestoEmpleado,Cedula
		FROM Empleado
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'La cedula no existe'
		SELECT @error as Error
		END
END
GO

CREATE OR ALTER PROCEDURE ActualizarCliente(@IdCliente INT, @Nombre VARCHAR(50), @Apellido VARCHAR(50), @Telefono VARCHAR(50), @Correo VARCHAR(50))
AS
	IF @IdCliente IS NULL
		BEGIN
			RAISERROR(N'El ID es nulo', 1, 1);
		END
	IF @Telefono IS NOT NULL
		BEGIN
			DECLARE @ComprobarTelefono INT;
			SET @ComprobarTelefono = (SELECT IdCliente FROM Cliente WHERE IdCliente != @IdCliente AND Telefono = @Telefono)
			IF @ComprobarTelefono IS NOT NULL
				BEGIN
					RAISERROR(N'Telefono utilizado', 1, 1);
				END
		END
	IF @Correo IS NOT NULL
		BEGIN
			DECLARE @ComprobarCorreo INT;
			SET @ComprobarCorreo = (SELECT IdCliente FROM Cliente WHERE IdCliente != @IdCliente AND Correo = @Correo)
			IF @ComprobarCorreo IS NOT NULL
				BEGIN
					RAISERROR(N'Correo utilizado', 1, 1);
				END
		END
	BEGIN TRANSACTION
		UPDATE Cliente
		SET Nombre = @Nombre, Apellido = @Apellido, Telefono = @Telefono, Correo = @Correo
		WHERE IdCliente = @IdCliente
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO 

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE SeleccionarClientes(@Nombre VARCHAR(50), @Apellido VARCHAR(50), @Telefono VARCHAR(50), @Correo VARCHAR(50), @Provincia VARCHAR(50), @Pais VARCHAR(50))
AS
	SELECT Cliente.Nombre, Apellido, Telefono, Correo,Ubicacion.Descripcion
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

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE InsertarCliente(@fechaNacimiento date,@pass varchar(50),@cedula varchar(50), @Nombre VARCHAR(50), @Apellido VARCHAR(50), @Telefono VARCHAR(50), @Correo VARCHAR(50), @Locacion geometry,@Descripcion varchar(50),@Provincia varchar(50))
AS
	IF @Nombre IS NULL OR @Apellido IS NULL OR @Telefono IS NULL OR @Correo IS NULL OR (select datediff(year,@fechaNacimiento,getDate()))<18 
		BEGIN
			RAISERROR(N'Informacion Incompleta', 1, 1);
		END
	DECLARE @ComprobarCorreo	INT,
			@ComprobarTelefono	INT,
			@ComprobarProvincia INT;
	SELECT	@ComprobarCorreo = (SELECT IdCliente FROM Cliente WHERE Correo = @Correo),
			@ComprobarTelefono = (SELECT IdCliente FROM Cliente WHERE Telefono = @Telefono),
			@ComprobarProvincia = (SELECT IdProvincia FROM Provincia WHERE Nombre = @Provincia);
	IF @ComprobarCorreo IS NOT NULL
		BEGIN
			RAISERROR(N'Correo ya utilizado', 1, 1);
		END
	ELSE IF @ComprobarTelefono IS NOT NULL
		BEGIN
			RAISERROR(N'Numero de telefono duplicado', 1, 1);
		END
	ELSE IF @ComprobarProvincia IS NULL
		BEGIN
			RAISERROR(N'No existe la provincia', 1, 1);
		END
	ELSE
		BEGIN
			BEGIN TRANSACTION
			    declare @UbicacionId int
			    INSERT INTO Ubicacion(LocacionExacta,Descripcion,IdProvincia)
				VALUES (@Locacion,@Descripcion,@ComprobarProvincia)
				SET @UbicacionId = @@IDENTITY
			    INSERT INTO Usuario(Usuario,Pass,Privilegio)
				VALUES(@cedula,@pass,'Cliente')
				INSERT INTO Cliente(Nombre, Apellido, Telefono, Correo, IdUbicacion, IdUsuario,Cedula)
				VALUES	(@Nombre, @Apellido, @Telefono, @Correo, @UbicacionId, @@IDENTITY,@cedula)
			COMMIT TRANSACTION
			RETURN @@IDENTITY;
		END
GO


USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE ActualizarComision(@IdComision INT, @IdFactura INT, @IdEmpleado INT, @Comision INT)
AS
	IF @IdComision IS NULL
		RAISERROR(N'El ID es nulo', 1, 1);
	IF @IdFactura IS NOT NULL
		DECLARE @ComprobarFactura INT;
		SET	@ComprobarFactura = (SELECT IdFactura FROM Factura WHERE IdFactura = @IdFactura);
		IF @ComprobarFactura IS NULL
			RAISERROR(N'No existe la factura', 1, 1);
	IF @IdEmpleado IS NOT NULL
		DECLARE @ComprobarEmpleado INT;
		SET	@ComprobarEmpleado = (SELECT IdEmpleado FROM Empleado WHERE IdEmpleado = @IdEmpleado);
		IF @ComprobarEmpleado IS NULL
			RAISERROR(N'No existe el Empleado', 1, 1);
	BEGIN TRANSACTION
		UPDATE Comision
		SET IdFactura = ISNULL(@IdFactura, IdFactura), IdEmpleado = ISNULL(@IdEmpleado, IdEmpleado), Comision = ISNULL(@Comision, Comision)
		WHERE IdComision = @IdComision
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE InsertarComision(@IdFactura INT, @IdEmpleado INT, @Comision INT)
AS
	IF @IdFactura IS NULL OR @IdEmpleado IS NULL OR @Comision IS NULL
		RAISERROR(N'Informacion incompleta', 1, 1);
	DECLARE @ComprobarFactura INT,
			@ComprobarEmpleado INT;
	SELECT	@ComprobarFactura = (SELECT IdFactura FROM Factura WHERE IdFactura = @IdFactura),
			@ComprobarEmpleado = (SELECT IdEmpleado FROM Empleado WHERE IdEmpleado = @IdEmpleado);
	IF @ComprobarFactura IS NULL
		RAISERROR(N'No existe la factura', 1, 1);
	ELSE IF @ComprobarEmpleado IS NULL
		RAISERROR(N'No existe el empleado', 1, 1);
	ELSE IF @Comision <= 0
		RAISERROR(N'Monto no valido', 1, 1);
	ELSE
		BEGIN
			BEGIN TRANSACTION
				INSERT INTO Comision(IdFactura, IdEmpleado, Comision)
				VALUES	(@IdFactura, @IdEmpleado, @Comision)
			COMMIT TRANSACTION
			RETURN @@IDENTITY;
		END
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE SeleccionarComisiones(@IdComision INT, @ComisionInicial INT, @ComisionFinal INT, @FechaInicial DATE, @FechaFinal DATE)
AS
	SELECT Comision, Empleado.Nombre, Factura.Fecha
	FROM Comision
	INNER JOIN Empleado
	ON Comision.IdEmpleado = Empleado.IdEmpleado
	INNER JOIN Factura
	ON Comision.IdFactura = Factura.IdFactura
	WHERE	IdComision = ISNULL(@IdComision, IdComision) AND
			Comision.Comision BETWEEN ISNULL(@ComisionInicial, Comision.Comision) AND ISNULL(@ComisionFinal, Comision.Comision) AND
			Factura.Fecha BETWEEN ISNULL(@FechaInicial, Fecha) AND ISNULL(@FechaFinal, Fecha)
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE ActualizarDescuento(@IdDescuento INT, @Nombre VARCHAR(50), @Descuento INT)
AS
	IF @IdDescuento IS NULL
		BEGIN
			RAISERROR(N'El ID es nulo', 1, 1);
		END
	BEGIN TRANSACTION
		UPDATE Descuento
		SET Nombre = ISNULL(@Nombre, Nombre), Descuento = ISNULL(@Descuento, Descuento)
		WHERE IdDescuento = @IdDescuento
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO 

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE InsertarDescuento(@Nombre VARCHAR(50), @Descuento INT)
AS
	IF @Nombre IS NULL OR @Descuento IS NULL
		RAISERROR(N'Informacion Incompleta', 1, 1);
	ELSE
		BEGIN
			BEGIN TRANSACTION
				INSERT INTO Descuento(Nombre, Descuento)
				VALUES	(@Nombre, @Descuento)
			COMMIT TRANSACTION
			RETURN @@IDENTITY;
		END
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE SeleccionarDescuentos(@IdFactura INT)
AS
	SELECT Nombre, Descuento.Descuento
	FROM Descuento
	INNER JOIN DescuentoXDetalleFactura
	ON Descuento.IdDescuento = DescuentoXDetalleFactura.IdDescuento
	INNER JOIN DetalleFactura
	ON DetalleFactura.IdDetalleFactura = DescuentoXDetalleFactura.IdDetalleFactura
	INNER JOIN Factura
	ON Factura.IdDetalleFactura = DetalleFactura.IdDetalleFactura
	WHERE IdFactura = @IdFactura
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE SeleccionarDescuentoXDetalleFactura(@IdDescuento INT, @IdDetalleFactura INT)
AS
	SELECT	DescuentoXDetalleFactura.IdDescuento, DescuentoXDetalleFactura.IdDetalleFactura,DetalleFactura.Comentario, DetalleFactura.SubTotal,Descuento.Descuento as Descuento
	FROM	DescuentoXDetalleFactura inner join Descuento on DescuentoXDetalleFactura.IdDescuento = Descuento.IdDescuento
	        inner join DetalleFactura on DescuentoXDetalleFactura.IdDetalleFactura = DetalleFactura.IdDetalleFactura
	WHERE	DescuentoXDetalleFactura.IdDescuento = ISNULL(@IdDescuento, DescuentoXDetalleFactura.IdDescuento) AND
			DescuentoXDetalleFactura.IdDetalleFactura = ISNULL(@IdDetalleFactura, DescuentoXDetalleFactura.IdDetalleFactura)
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE InsertarDescuentoXDetalleFactura(@IdDescuento INT, @IdDetalleFactura INT)
AS
	IF @IdDescuento IS NULL OR @IdDetalleFactura IS NULL
		RAISERROR(N'Informacion incompleta', 1, 1);
	DECLARE @ComprobarDescuento INT,
			@ComprobarDetalle INT;
	SELECT	@ComprobarDescuento = (SELECT IdDescuento FROM Descuento WHERE IdDescuento = @IdDescuento),
			@ComprobarDetalle = (SELECT IdDetalleFactura FROM DetalleFactura WHERE IdDetalleFactura = @IdDetalleFactura)
	IF @ComprobarDescuento IS NULL
		RAISERROR(N'El descuento no existe', 1, 1)
	ELSE IF @ComprobarDetalle IS NULL
		RAISERROR(N'El detalle no existe', 1, 1)
	ELSE
		BEGIN
			BEGIN TRANSACTION
				INSERT INTO DescuentoXDetalleFactura(IdDescuento, IdDetalleFactura)
				VALUES	(@IdDescuento, @IdDetalleFactura)
			COMMIT TRANSACTION
			RETURN @@IDENTITY;
		END
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE ActualizarDescuentoXDetalleFactura(@IdDescuentoXDetalleFactura INT, @IdDescuento INT, @IdDetalleFactura INT)
AS
	IF @IdDescuentoXDetalleFactura IS NULL
		RAISERROR(N'El ID es nulo', 1, 1);
	IF @IdDescuento IS NOT NULL
		DECLARE @ComprobarDescuento INT;
		SELECT	@ComprobarDescuento = (SELECT IdDescuento FROM Descuento WHERE IdDescuento = @IdDescuento);
		IF @ComprobarDescuento IS NULL
			RAISERROR(N'El descuento no existe', 1, 1)
	IF @IdDetalleFactura IS NOT NULL
		DECLARE @ComprobarDetalleFactura INT;
		SELECT	@ComprobarDetalleFactura = (SELECT IdDetalleFactura FROM DetalleFactura WHERE IdDetalleFactura = @IdDetalleFactura);
		IF @ComprobarDetalleFactura IS NULL
			RAISERROR(N'El DetalleFactura no existe', 1, 1)
	BEGIN TRANSACTION
		UPDATE DescuentoXDetalleFactura
		SET IdDescuento = ISNULL(@IdDescuento, IdDescuento), IdDetalleFactura = ISNULL(@IdDetalleFactura, IdDetalleFactura)
		WHERE IdDescuentoXDetalleFactura = @IdDescuentoXDetalleFactura
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE ObtenerDetalleFactura(@IdFactura INT)
AS
	SELECT SubTotal, Comentario, Cliente.Nombre AS NombreCliente, Empleado.Nombre AS EmpleadoNombre,TipoPago.Pago as TipoPago,Sucursal.Nombre as Sucursal
	FROM DetalleFactura
	INNER JOIN Cliente
	ON Cliente.IdCliente = DetalleFactura.IdCliente
	INNER JOIN Empleado
	ON Empleado.IdEmpleado = DetalleFactura.IdVendedor
	INNER JOIN Factura
	ON Factura.IdDetalleFactura = DetalleFactura.IdDetalleFactura
	INNER JOIN TipoPago
	ON DetalleFactura.IdTipoPago = TipoPago.IdTipoPago
	INNER JOIN Sucursal
	ON DetalleFactura.IdSucursal = Sucursal.IdSucursal
	WHERE IdFactura = @IdFactura
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE InsertarDetalleFactura(@IdVendedor INT, @IdCliente INT, @SubTotal INT, @IdTipoPago INT, @Comentario VARCHAR(50), @TipoModalidad INT)
AS
	IF @IdVendedor IS NULL OR @IdCliente IS NULL OR @SubTotal IS NULL OR @IdTipoPago IS NULL OR @Comentario IS NULL
		RAISERROR(N'Informacion Incompleta', 1, 1);
	DECLARE @ComprobarVendedor INT,
			@ComprobarCliente INT,
			@ComprobarTipoPago INT;
	SELECT	@ComprobarVendedor = (SELECT IdEmpleado FROM Empleado WHERE IdEmpleado = @IdVendedor),
			@ComprobarCliente = (SELECT IdCliente FROM Cliente WHERE IdCliente = @IdCliente),
			@ComprobarTipoPago = (SELECT IdTipoPago FROM TipoPago WHERE IdTipoPago = @IdTipoPago);
	IF @ComprobarVendedor IS NULL
		RAISERROR(N'No existe el vendedor', 1, 1);
	ELSE IF @ComprobarCliente IS NULL
		RAISERROR(N'No existe el cliente', 1, 1);
	ELSE IF @ComprobarTipoPago IS NULL
		RAISERROR(N'No existe el metodo de pago', 1, 1);
	ELSE
		BEGIN
			BEGIN TRANSACTION
				INSERT INTO DetalleFactura(IdVendedor, IdCliente, SubTotal, IdTipoPago, Comentario, IdTipoModalidad)
				VALUES	(@IdVendedor, @IdCliente, @SubTotal, @IdTipoPago, @Comentario, @TipoModalidad)
			COMMIT TRANSACTION
			RETURN @@IDENTITY;
		END
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE ActualizarDetalleFactura(@IdDetalleFactura INT, @IdVendedor INT, @IdCliente INT, @SubTotal INT, @IdTipoPago INT, @Comentario VARCHAR(50))
AS
	IF @IdDetalleFactura IS NULL
		RAISERROR(N'El ID es nulo', 1, 1);
	IF @IdVendedor IS NOT NULL
		DECLARE @ComprobarVendedor INT;
		SET	@ComprobarVendedor = (SELECT IdEmpleado FROM Empleado WHERE IdEmpleado = @IdVendedor);
		IF @ComprobarVendedor IS NULL
			RAISERROR(N'No existe el vendedor', 1, 1);
	IF @IdCliente IS NOT NULL
		DECLARE @ComprobarCliente INT;
		SET	@ComprobarCliente = (SELECT IdCliente FROM Cliente WHERE IdCliente = @IdCliente);
		IF @ComprobarCliente IS NULL
			RAISERROR(N'No existe el Cliente', 1, 1);
	IF @IdTipoPago IS NOT NULL
		DECLARE @ComprobarTipoPago INT;
		SET	@ComprobarTipoPago = (SELECT IdTipoPago FROM TipoPago WHERE IdTipoPago = @IdTipoPago);
		IF @ComprobarTipoPago IS NULL
			RAISERROR(N'No existe el Tipo de Pago', 1, 1);
	BEGIN TRANSACTION
		UPDATE DetalleFactura
		SET IdVendedor = ISNULL(@IdVendedor, IdVendedor), IdCliente = ISNULL(@IdCliente, IdCliente), SubTotal = ISNULL(@SubTotal, SubTotal), IdTipoPago = ISNULL(@IdTipoPago, IdTipoPago),
			Comentario = ISNULL(@Comentario, Comentario)
		WHERE IdDetalleFactura = @IdDetalleFactura
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE SeleccionarEntregas(@IdEntrega INT, @EstatusEntrega VARCHAR(50), @FechaInicial DATE, @FechaFinal DATE, @NumeroFactura VARCHAR(50))
AS
	SELECT		NumeroFactura, EstatusEntrega, Fecha, IdEntrega,Factura.PrecioTotal as Monto,Ubicacion.Descripcion
	FROM		Entrega
	INNER JOIN	Factura
	ON			Factura.IdFactura = Entrega.IdFactura
	INNER JOIN  Ubicacion
	ON          Entrega.IdUbicacionEntrega = Ubicacion.IdUbicacion
	WHERE		IdEntrega = ISNULL(@IdEntrega, IdEntrega) AND
				EstatusEntrega = ISNULL(@EstatusEntrega, EstatusEntrega) AND
				Entrega.FechaEntrega BETWEEN ISNULL(@FechaInicial, Entrega.FechaEntrega) AND ISNULL(@FechaFinal, Entrega.FechaEntrega) AND
				NumeroFactura = ISNULL(@NumeroFactura, NumeroFactura) 
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE InsertarEntrega(@IdFactura INT, @IdUbicacionEntrega INT, @EstatusEntrega VARCHAR(50), @FechaEntrega DATE)
AS
	IF @IdFactura IS NULL OR @IdUbicacionEntrega IS NULL OR @EstatusEntrega IS NULL OR @FechaEntrega IS NULL
		RAISERROR(N'Informacion Incompleta', 1, 1);
	DECLARE @ComprobarFactura INT,
			@ComprobarUbicacion INT;
	SELECT	@ComprobarFactura = (SELECT IdFactura FROM Factura WHERE IdFactura = @IdFactura),
			@ComprobarUbicacion = (SELECT IdUbicacion FROM Ubicacion WHERE IdUbicacion = @IdUbicacionEntrega);
	IF @ComprobarFactura IS NULL
		RAISERROR(N'No existe la factura', 1, 1)
	ELSE IF @ComprobarUbicacion IS NULL
		RAISERROR(N'No existe la ubicacion', 1, 1)
	ELSE
		BEGIN
			BEGIN TRANSACTION
				INSERT INTO Entrega(IdFactura, IdUbicacionEntrega, EstatusEntrega, FechaEntrega)
				VALUES	(@IdFactura, @IdUbicacionEntrega, @EstatusEntrega, @FechaEntrega)
			COMMIT TRANSACTION
			RETURN @@IDENTITY;
		END
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE ActualizarEntrega(@IdEntrega INT, @IdFactura INT, @IdUbicacionEntrega INT, @EstatusEntrega VARCHAR(50), @FechaEntrega DATE)
AS
	IF @IdEntrega IS NULL
		RAISERROR(N'El ID es nulo', 1, 1);
	IF @IdFactura IS NOT NULL
		DECLARE @ComprobarFactura INT;
		SELECT	@ComprobarFactura = (SELECT IdFactura FROM Factura WHERE IdFactura = @IdFactura);
		IF @ComprobarFactura IS NULL
			RAISERROR(N'No existe la factura', 1, 1)
	IF @IdUbicacionEntrega IS NOT NULL
		DECLARE @ComprobarUbicacionEntrega INT;
		SELECT	@ComprobarUbicacionEntrega = (SELECT IdUbicacion FROM Ubicacion WHERE IdUbicacion = @IdUbicacionEntrega);
		IF @ComprobarUbicacionEntrega IS NULL
			RAISERROR(N'No existe la ubicacion', 1, 1)
	BEGIN TRANSACTION
		UPDATE Entrega
		SET	IdFactura = ISNULL(@IdFactura, IdFactura), IdUbicacionEntrega = ISNULL(@IdUbicacionEntrega, IdUbicacionEntrega), EstatusEntrega = ISNULL(@EstatusEntrega, EstatusEntrega),
			FechaEntrega = ISNULL(@FechaEntrega, FechaEntrega)
		WHERE IdEntrega = @IdEntrega
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE SeleccionarFacturas(@IdFactura INT, @NumeroFactura VARCHAR(50), @PrecioInicial INT, @PrecioFinal INT, @FechaInicial DATE, @FechaFinal DATE, @tipoPago VARCHAR(50),@Pais varchar(50),@TipoVehiculo varchar(50),@IdSucursal int)
AS
	SELECT	NumeroFactura, PrecioTotal, Fecha, Factura.IdDetalleFactura,DetalleFactura.Comentario, DetalleFactura.Descuento, TipoPago.Pago
	FROM	Factura inner join DetalleFactura on Factura.IdDetalleFactura = DetalleFactura.IdDetalleFactura
					inner join TipoPago on DetalleFactura.IdTipoPago = TipoPago.IdTipoPago,Cliente,Ubicacion,Provincia,Pais,Vehiculo,FacturaXVehiculo,Sucursal,TipoVehiculo
	WHERE	DetalleFactura.IdCliente = Cliente.IdCliente AND Cliente.IdUbicacion = Ubicacion.IdUbicacion AND Ubicacion.IdProvincia = Provincia.IdProvincia AND
	        Provincia.IdPais = Pais.IdPais AND FacturaXVehiculo.IdVehiculo = Vehiculo.IdVehiculo AND FacturaXVehiculo.IdFactura = Factura.IdFactura AND Vehiculo.IdTipoVehiculo = TipoVehiculo.IdTipoVehiculo AND
			DetalleFactura.IdSucursal = Sucursal.IdSucursal AND 
			Factura.IdFactura = ISNULL(@IdFactura, Factura.IdFactura) AND
			NumeroFactura = ISNULL(@NumeroFactura, NumeroFactura) AND
			PrecioTotal BETWEEN ISNULL(@PrecioInicial, PrecioTotal) AND ISNULL(@PrecioFinal, PrecioTotal) AND
			Fecha BETWEEN ISNULL(@FechaInicial, Fecha) AND ISNULL(@FechaFinal, Fecha) AND
			TipoPago.Pago = ISNULL(@tipoPago, TipoPago.Pago) AND Pais.Nombre = ISNULL(@Pais,Pais.Nombre) AND TipoVehiculo.Nombre = ISNULL(@TipoVehiculo,TipoVehiculo.Nombre) AND
			Sucursal.IdSucursal = ISNULL(@IdSucursal,Sucursal.IdSucursal)
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE InsertarFactura(@NumeroFactura VARCHAR(50), @IdDetalleFactura INT, @PrecioTotal INT, @Fecha DATE)
AS
	IF @NumeroFactura IS NULL OR @IdDetalleFactura IS NULL OR @PrecioTotal IS NULL OR @Fecha IS NULL
		RAISERROR(N'Informacion Incompleta', 1, 1);
	DECLARE @ComprobarDetalle INT
	SET @ComprobarDetalle = (SELECT IdDetalleFactura FROM DetalleFactura WHERE IdDetalleFactura = @IdDetalleFactura)
	IF @ComprobarDetalle IS NULL
		RAISERROR(N'No existe el detalle de factura', 1, 1);
	ELSE
		BEGIN
			BEGIN TRANSACTION
				INSERT INTO Factura(NumeroFactura, IdDetalleFactura, PrecioTotal, Fecha)
				VALUES (@NumeroFactura, @IdDetalleFactura, @PrecioTotal, @Fecha)
			COMMIT TRANSACTION
			RETURN @@IDENTITY;
		END
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE ActualizarFactura(@IdFactura INT, @NumeroFactura VARCHAR(50), @IdDetalleFactura INT, @PrecioTotal INT, @Fecha DATE)
AS
	IF @IdFactura IS NULL
		RAISERROR(N'El ID es nulo', 1, 1);
	IF @IdDetalleFactura IS NOT NULL
		DECLARE @ComprobarDetalle INT
		SET @ComprobarDetalle = (SELECT IdDetalleFactura FROM DetalleFactura WHERE IdDetalleFactura = @IdDetalleFactura)
		IF @ComprobarDetalle IS NULL
			RAISERROR(N'No existe el detalle de factura', 1, 1);
	ELSE
		BEGIN
			BEGIN TRANSACTION
				UPDATE Factura
				SET NumeroFactura = ISNULL(@NumeroFactura, NumeroFactura), IdDetalleFactura = ISNULL(@IdDetalleFactura, IdDetalleFactura), PrecioTotal = ISNULL(@PrecioTotal, PrecioTotal),
					Fecha = ISNULL(@Fecha, Fecha)
				WHERE IdFactura = @IdFactura
			COMMIT TRANSACTION
		END
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE SeleccionarFacturaXVehiculo(@IdFactura INT, @IdVehiculo INT)
AS
	SELECT	FacturaXVehiculo.IdFactura, FacturaXVehiculo.IdVehiculo,Vehiculo.Marca,Vehiculo.Modelo,Factura.PrecioTotal
	FROM	FacturaXVehiculo Inner join Vehiculo on FacturaXVehiculo.IdVehiculo = Vehiculo.IdVehiculo
	        inner join Factura on FacturaXVehiculo.IdFactura = Factura.IdFactura
	WHERE	FacturaXVehiculo.IdFactura = ISNULL(@IdFactura, FacturaXVehiculo.IdFactura) AND
			FacturaXVehiculo.IdVehiculo = ISNULL(@IdVehiculo, FacturaXVehiculo.IdVehiculo)
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE InsertarFacturaXVehiculo(@IdFactura  INT, @IdVehiculo INT)
AS
	IF @IdFactura  IS NULL OR @IdVehiculo IS NULL
		RAISERROR(N'Informacion incompleta', 1, 1);
	DECLARE @ComprobarFactura  INT,
			@ComprobarDetalle INT;
	SELECT	@ComprobarFactura  = (SELECT IdFactura  FROM Factura  WHERE IdFactura  = @IdFactura),
			@ComprobarDetalle = (SELECT IdVehiculo FROM Vehiculo WHERE IdVehiculo = @IdVehiculo)
	IF @ComprobarFactura  IS NULL
		RAISERROR(N'La Factura  no existe', 1, 1)
	ELSE IF @ComprobarDetalle IS NULL
		RAISERROR(N'El vehiculo no existe', 1, 1)
	ELSE
		BEGIN
			BEGIN TRANSACTION
				INSERT INTO FacturaXVehiculo(IdFactura , IdVehiculo)
				VALUES	(@IdFactura , @IdVehiculo)
			COMMIT TRANSACTION
			RETURN @@IDENTITY;
		END
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE ActualizarFacturaXVehiculo(@IdFacturaXVehiculo INT, @IdFactura INT, @IdVehiculo INT)
AS
	IF @IdFacturaXVehiculo IS NULL
		RAISERROR(N'El ID es nulo', 1, 1);
	IF @IdFactura IS NOT NULL
		DECLARE @ComprobarFactura INT;
		SELECT	@ComprobarFactura = (SELECT IdFactura FROM Factura WHERE IdFactura = @IdFactura);
		IF @ComprobarFactura IS NULL
			RAISERROR(N'La Factura no existe', 1, 1)
	IF @IdVehiculo IS NOT NULL
		DECLARE @ComprobarVehiculo INT;
		SELECT	@ComprobarVehiculo = (SELECT IdVehiculo FROM Vehiculo WHERE IdVehiculo = @IdVehiculo);
		IF @ComprobarVehiculo IS NULL
			RAISERROR(N'El Vehiculo no existe', 1, 1)
	BEGIN TRANSACTION
		UPDATE FacturaXVehiculo
		SET IdFactura = ISNULL(@IdFactura, IdFactura), IdVehiculo = ISNULL(@IdVehiculo, IdVehiculo)
		WHERE IdFacturaXVehiculo = @IdFacturaXVehiculo
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE SeleccionarImpuestos(@IdFactura INT)
AS
	SELECT Nombre, Impuesto
	FROM Impuesto
	INNER JOIN ImpuestoXDetalleFactura
	ON ImpuestoXDetalleFactura.IdImpuesto = Impuesto.IdImpuesto
	INNER JOIN DetalleFactura
	ON DetalleFactura.IdDetalleFactura = ImpuestoXDetalleFactura.IdDetalleFactura
	INNER JOIN Factura
	ON Factura.IdDetalleFactura = DetalleFactura.IdDetalleFactura
	WHERE IdFactura = @IdFactura
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE InsertarImpuesto(@Nombre VARCHAR(50), @Impuesto INT)
AS
	IF @Nombre IS NULL OR @Impuesto IS NULL
		RAISERROR(N'Informacion Incompleta', 1, 1);
	ELSE
		BEGIN
			BEGIN TRANSACTION
				INSERT INTO Impuesto(Nombre, Impuesto)
				VALUES	(@Nombre, @Impuesto)
			COMMIT TRANSACTION
			RETURN @@IDENTITY;
		END
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE ActualizarImpuesto(@IdImpuesto INT, @Nombre VARCHAR(50), @Impuesto INT)
AS
	IF @IdImpuesto IS NULL
		BEGIN
			RAISERROR(N'El ID es nulo', 1, 1);
		END
	BEGIN TRANSACTION
		UPDATE Impuesto
		SET Nombre = ISNULL(@Nombre, Nombre), Impuesto = ISNULL(@Impuesto, Impuesto)
		WHERE IdImpuesto = @IdImpuesto
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO 

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE SeleccionarImpuestoXDetalleFactura(@IdImpuesto INT, @IdDetalleFactura INT)
AS
	SELECT	ImpuestoXDetalleFactura.IdImpuesto, ImpuestoXDetalleFactura.IdDetalleFactura,Impuesto.Impuesto,DetalleFactura.SubTotal
	FROM	ImpuestoXDetalleFactura inner join Impuesto on ImpuestoXDetalleFactura.IdImpuesto = Impuesto.IdImpuesto
	        inner join DetalleFactura on ImpuestoXDetalleFactura.IdDetalleFactura = DetalleFactura.IdDetalleFactura
	WHERE	ImpuestoXDetalleFactura.IdImpuesto = ISNULL(@IdImpuesto, ImpuestoXDetalleFactura.IdImpuesto) AND
			ImpuestoXDetalleFactura.IdDetalleFactura = ISNULL(@IdDetalleFactura, ImpuestoXDetalleFactura.IdDetalleFactura)
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE InsertarImpuestoXDetalleFactura(@IdImpuesto INT, @IdDetalleFactura INT)
AS
	IF @IdImpuesto IS NULL OR @IdDetalleFactura IS NULL
		RAISERROR(N'Informacion incompleta', 1, 1);
	DECLARE @ComprobarImpuesto INT,
			@ComprobarDetalle INT;
	SELECT	@ComprobarImpuesto = (SELECT IdImpuesto FROM Impuesto WHERE IdImpuesto = @IdImpuesto),
			@ComprobarDetalle = (SELECT IdDetalleFactura FROM DetalleFactura WHERE IdDetalleFactura = @IdDetalleFactura)
	IF @ComprobarImpuesto IS NULL
		RAISERROR(N'El Impuesto no existe', 1, 1)
	ELSE IF @ComprobarDetalle IS NULL
		RAISERROR(N'El detalle no existe', 1, 1)
	ELSE
		BEGIN
			BEGIN TRANSACTION
				INSERT INTO ImpuestoXDetalleFactura(IdImpuesto, IdDetalleFactura)
				VALUES	(@IdImpuesto, @IdDetalleFactura)
			COMMIT TRANSACTION
			RETURN @@IDENTITY;
		END
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE ActualizarImpuestoXDetalleFactura(@IdImpuestoXDetalleFactura INT, @IdImpuesto INT, @IdDetalleFactura INT)
AS
	IF @IdImpuestoXDetalleFactura IS NULL
		RAISERROR(N'El ID es nulo', 1, 1);
	IF @IdImpuesto IS NOT NULL
		DECLARE @ComprobarImpuesto INT;
		SELECT	@ComprobarImpuesto = (SELECT IdImpuesto FROM Impuesto WHERE IdImpuesto = @IdImpuesto);
		IF @ComprobarImpuesto IS NULL
			RAISERROR(N'El Impuesto no existe', 1, 1)
	IF @IdDetalleFactura IS NOT NULL
		DECLARE @ComprobarDetalleFactura INT;
		SELECT	@ComprobarDetalleFactura = (SELECT IdDetalleFactura FROM DetalleFactura WHERE IdDetalleFactura = @IdDetalleFactura);
		IF @ComprobarDetalleFactura IS NULL
			RAISERROR(N'El DetalleFactura no existe', 1, 1)
	BEGIN TRANSACTION
		UPDATE ImpuestoXDetalleFactura
		SET IdImpuesto = ISNULL(@IdImpuesto, IdImpuesto), IdDetalleFactura = ISNULL(@IdDetalleFactura, IdDetalleFactura)
		WHERE IdImpuestoXDetalleFactura = @IdImpuestoXDetalleFactura
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE SeleccionarTipoPagos(@IdTipoPago INT)
AS
	SELECT Pago
	FROM TipoPago
	WHERE IdTipoPago = ISNULL(@IdTipoPago, IdTipoPago)
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE InsertarTipoPago(@Pago VARCHAR(50))
AS
	IF @Pago IS NULL
		RAISERROR(N'Informacion Incompleta', 1, 1);
	ELSE
		BEGIN
			BEGIN TRANSACTION
				INSERT INTO TipoPago(Pago)
				VALUES	(@Pago)
			COMMIT TRANSACTION
			RETURN @@IDENTITY;
		END
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE ActualizarTipoPago(@IdTipoPago INT, @Pago VARCHAR(50))
AS
	IF @IdTipoPago IS NULL
		BEGIN
			RAISERROR(N'El ID es nulo', 1, 1);
		END
	BEGIN TRANSACTION
		UPDATE TipoPago
		SET Pago = ISNULL(@Pago, Pago)
		WHERE IdTipoPago = @IdTipoPago
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO 

/**************************FABRICA*********************************/

CREATE OR ALTER PROCEDURE InsertarFabrica
				  @Descripcion varchar(50),
				  @IdUbicacion   int
AS
BEGIN

	Begin Transaction;
	--validar si existe
	insert into Fabrica(IdUbicacion,Descripcion)
	values(@IdUbicacion,@Descripcion)
	--end
	commit 
END
go

CREATE OR ALTER PROCEDURE ModificarFabrica
	@IdFabrica int, @Descripcion Varchar(50),@IdUbicacion int
AS
BEGIN
	BEGIN TRANSACTION
		update Fabrica 
		SET Descripcion = isnull(@Descripcion,Descripcion),IdUbicacion = isnull(@IdUbicacion,IdUbicacion)
		WHERE IdFabrica = @IdFabrica
	COMMIT
END
go

CREATE OR ALTER PROCEDURE SeleccionarFabrica
                  @IdFabrica int, @Descripcion Varchar(50),@NombreProvincia varchar(50),@NombrePais varchar(50),@IdUbicacion int 
AS 
BEGIN
     SELECT Fabrica.IdFabrica,Fabrica.Descripcion,Ubicacion.Descripcion,Provincia.Nombre,Pais.Nombre
	 FROM Fabrica inner join Ubicacion on Fabrica.IdUbicacion = Ubicacion.IdUbicacion,Provincia,Pais
	 WHERE	Ubicacion.IdProvincia = Provincia.IdProvincia AND Provincia.IdPais = Pais.IdPais AND
	        IdFabrica=isnull(@IdFabrica,IdFabrica) AND Fabrica.Descripcion = isnull(@Descripcion,Fabrica.Descripcion)  AND
		    Fabrica.IdUbicacion = isnull(@IdUbicacion,Fabrica.IdUbicacion) AND Provincia.Nombre = ISNULL(@NombreProvincia,Provincia.Nombre) AND
		    Pais.Nombre = ISNULL(@NombrePais,Pais.Nombre)
END
go

/***************************PEDIDO*********************************/

CREATE OR ALTER PROCEDURE InsertarPedido
	 @EstatusPedido Varchar(50), @FechaPedido Date, @IdEmpleadoPedido int, @IdFabrica int
AS
BEGIN
	Begin Transaction;
	--validar si existe
	insert into Pedido(EstatusPedido,FechaPedido,IdEmpleadoPedido,IdFabrica)
	values(@EstatusPedido,@FechaPedido,@IdEmpleadoPedido,@IdFabrica)
	--end
	commit 
END
go

CREATE OR ALTER PROCEDURE ModificarPedido
	@IdPedido int, @EstatusPedido Varchar(50), @FechaPedido Date, @IdEmpleadoPedido int, @IdFabrica int
AS
BEGIN
	BEGIN TRANSACTION
		update Pedido 
		SET EstatusPedido = isnull(@EstatusPedido,EstatusPedido),
			FechaPedido = isnull(@FechaPedido,FechaPedido),
			IdEmpleadoPedido=ISNULL(@IdEmpleadoPedido,IdEmpleadoPedido),
			IdFabrica=ISNULL(@IdFabrica,IdFabrica)
		WHERE IdPedido = @IdPedido
	COMMIT
END
go

CREATE OR ALTER PROCEDURE SeleccionarPedido
	@IdPedido int, @EstatusPedido Varchar(50), @FechaPedido Date, @IdEmpleadoPedido int, @IdFabrica int
AS 
BEGIN
     SELECT Pedido.IdPedido,Pedido.EstatusPedido,Pedido.FechaPedido,Pedido.IdEmpleadoPedido,Pedido.IdFabrica,Empleado.Nombre as NombreEmpleado,Empleado.Apellido as EmpleadoApellido,Empleado.Cedula as EmpleadoCedula,
	        Fabrica.Descripcion as Fabrica
	 FROM Pedido inner join Fabrica on Pedido.IdFabrica = Fabrica.IdFabrica 
	      inner join Empleado on Pedido.IdEmpleadoPedido = Empleado.IdEmpleado
	 WHERE	Pedido.IdPedido=isnull(@IdPedido,Pedido.IdPedido) AND
			Pedido.EstatusPedido = isnull(@EstatusPedido,Pedido.EstatusPedido) AND
			Pedido.FechaPedido = isnull(@FechaPedido,Pedido.FechaPedido) AND
			Pedido.IdEmpleadoPedido=ISNULL(@IdEmpleadoPedido,Pedido.IdEmpleadoPedido) AND
			Pedido.IdFabrica=ISNULL(@IdFabrica,Pedido.IdFabrica)     
END
go

/**********************PedidoXVehiculo*****************************/

CREATE OR ALTER PROCEDURE InsertarPedidoXVehiculo
	@IdPedido int, @IdVehiculo int, @FechaCompletado date
AS
BEGIN
	Begin Transaction;
	--validar si existe
	insert into PedidoXVehiculo(IdPedido,IdVehiculo,FechaCompletado)
	values(@IdPedido,@IdVehiculo,@FechaCompletado)
	--end
	commit 
END
go

CREATE OR ALTER PROCEDURE ModificarPedidoXVehiculo
	@IdPedidoXVehiculo int, @IdPedido int, @IdVehiculo int, @FechaCompletado date
AS
BEGIN
	BEGIN TRANSACTION
		update PedidoXVehiculo 
		SET IdPedido = isnull(@IdPedido,IdPedido),
			IdVehiculo = isnull(@IdVehiculo,IdVehiculo),
			FechaCompletado=ISNULL(@FechaCompletado,FechaCompletado)
		WHERE IdPedidoXVehiculo = @IdPedidoXVehiculo
	COMMIT
END
go

CREATE OR ALTER PROCEDURE SeleccionarPedidoXVehiculo
	@IdPedidoXVehiculo int, @IdPedido int, @IdVehiculo int, @FechaCompletado date
AS 
BEGIN
     SELECT PedidoXVehiculo.IdPedidoXVehiculo,PedidoXVehiculo.IdPedido,PedidoXVehiculo.IdVehiculo,PedidoXVehiculo.FechaCompletado,Vehiculo.Marca as Marca,Vehiculo.Modelo as Modelo,Pedido.EstatusPedido as Estatus
	 FROM PedidoXVehiculo inner join Vehiculo on PedidoXVehiculo.IdVehiculo = Vehiculo.IdVehiculo
	      inner join Pedido on PedidoXVehiculo.IdPedido = Pedido.IdPedido
	 WHERE	PedidoXVehiculo.IdPedidoXVehiculo=ISNULL(@IdPedidoXVehiculo,PedidoXVehiculo.IdPedidoXVehiculo) AND
			PedidoXVehiculo.IdPedido = isnull(@IdPedido,PedidoXVehiculo.IdPedido) AND
			PedidoXVehiculo.IdVehiculo = isnull(@IdVehiculo,PedidoXVehiculo.IdVehiculo) AND
			PedidoXVehiculo.FechaCompletado=ISNULL(@FechaCompletado,PedidoXVehiculo.FechaCompletado)    
END
go

/************************INVENTARIO*********************************/

CREATE OR ALTER PROCEDURE InsertarInventario
	@NombreInventario varchar(50), @Fecha date, @IdSucursal int
AS
BEGIN
	Begin Transaction;
	--validar si existe
	insert into Inventario(NombreInventario,Fecha,IdSucursal)
	values(@NombreInventario,@Fecha,@IdSucursal)
	--end
	commit 
END
go

CREATE OR ALTER PROCEDURE ModificarInventario
	@IdInventario int, @NombreInventario varchar(50), @Fecha date, @IdSucursal int
AS
BEGIN
	BEGIN TRANSACTION
		update Inventario 
		SET NombreInventario=ISNULL(@NombreInventario,NombreInventario),
			Fecha=ISNULL(@Fecha,Fecha),
			IdSucursal = isnull(@IdSucursal,IdSucursal)
		WHERE IdInventario = @IdInventario
	COMMIT
END
go

CREATE OR ALTER PROCEDURE SeleccionarInventario
	@IdInventario int, @NombreInventario varchar(50), @Fecha date, @IdSucursal int
AS 
BEGIN
     SELECT IdInventario,NombreInventario,Fecha,Inventario.IdSucursal,Sucursal.Nombre
	 FROM Inventario inner join Sucursal on Inventario.IdSucursal = Sucursal.IdSucursal
	 WHERE	IdInventario=ISNULL(@IdInventario,IdInventario) and
			NombreInventario=ISNULL(@NombreInventario,NombreInventario) and
			Fecha=ISNULL(@Fecha,Fecha) and
			Inventario.IdSucursal = isnull(@IdSucursal,Inventario.IdSucursal)      
END
go

/**************************VehiculoFabrica*******************************/

CREATE OR ALTER PROCEDURE InsertarVehiculoFabrica
	@IdVehiculo int, @CostoVehiculo int, @IdInventario int, @IdFabrica int
AS
BEGIN
	Begin Transaction;
	--validar si existe
	insert into VehiculoFabrica(IdVehiculo,CostoVehiculo,IdInventario,IdFabrica)
	values(@IdVehiculo,@CostoVehiculo,@IdInventario,@IdFabrica)
	--end
	commit 
END
go

CREATE OR ALTER PROCEDURE ModificarVehiculoFabrica
	@IdVehiculoFabrica int, @IdVehiculo int, @CostoVehiculo int, @IdInventario int, @IdFabrica int
AS
BEGIN
	BEGIN TRANSACTION
		update VehiculoFabrica 
		SET IdVehiculo=ISNULL(@IdVehiculo,IdVehiculo),
			CostoVehiculo=ISNULL(@CostoVehiculo,CostoVehiculo),
			IdInventario=Isnull(@IdInventario,IdInventario),
			IdFabrica = isnull(@IdFabrica,IdFabrica)
		WHERE IdVehiculoFabrica = @IdVehiculoFabrica
	COMMIT
END
go

CREATE OR ALTER PROCEDURE SeleccionarVehiculoFabrica
	@IdVehiculoFabrica int, @IdVehiculo int, @CostoVehiculo int, @IdInventario int, @IdFabrica int
AS 
BEGIN
     SELECT VehiculoFabrica.IdVehiculoFabrica,VehiculoFabrica.IdVehiculo,VehiculoFabrica.CostoVehiculo,VehiculoFabrica.IdInventario,VehiculoFabrica.IdFabrica,Fabrica.Descripcion as Fabrica,
	        Vehiculo.Modelo as Modelo,Vehiculo.Marca as Marca
	 FROM VehiculoFabrica inner join Fabrica on VehiculoFabrica.IdFabrica = Fabrica.IdFabrica
	      inner join Vehiculo on VehiculoFabrica.IdVehiculo = Vehiculo.IdVehiculo
		  inner join Inventario on VehiculoFabrica.IdInventario = Inventario.IdInventario
	 WHERE	VehiculoFabrica.IdVehiculoFabrica=ISNULL(@IdVehiculoFabrica,VehiculoFabrica.IdVehiculoFabrica) and
			VehiculoFabrica.IdVehiculo=ISNULL(@IdVehiculo,VehiculoFabrica.IdVehiculo) and
			VehiculoFabrica.CostoVehiculo=ISNULL(@CostoVehiculo,VehiculoFabrica.CostoVehiculo) and
			VehiculoFabrica.IdInventario=Isnull(@IdInventario,VehiculoFabrica.IdInventario) and
			VehiculoFabrica.IdFabrica = isnull(@IdFabrica,VehiculoFabrica.IdFabrica)      
END
go

/******************************VehiculoFabricaXEmpleado********************************************/

CREATE OR ALTER PROCEDURE InsertarVehiculoFabricaXEmpleado
	@IdVehiculoFabrica int, @IdEmpleado int, @Labor Varchar(50), @FechaInicio Date, @FechaFinal Date,@Estatus Varchar(50)
AS
BEGIN
	Begin Transaction;
	--validar si existe
	insert into VehiculoFabricaXEmpleado(IdVehiculoFabrica,IdEmpleado,Labor,FechaInicio,FechaFinal,Estatus)
	values(@IdVehiculoFabrica,@IdEmpleado,@Labor,@FechaInicio,@FechaFinal,@Estatus)
	--end
	commit 
END
go

CREATE OR ALTER PROCEDURE ModificarVehiculoFabricaXEmpleado
	@IdVehiculoFabricaXEmpleado int,@IdVehiculoFabrica int, @IdEmpleado int, @Labor Varchar(50), @FechaInicio Date, @FechaFinal Date,@Estatus Varchar(50)
AS
BEGIN
	BEGIN TRANSACTION
		update VehiculoFabricaXEmpleado 
		SET IdVehiculoFabrica=ISNULL(@IdVehiculoFabrica,IdVehiculoFabrica),
			IdEmpleado=ISNULL(@IdEmpleado,IdEmpleado),
			Labor=Isnull(@Labor,Labor),
			FechaInicio=ISNULL(@FechaInicio,FechaInicio),
			FechaFinal=ISNULL(@FechaFinal,FechaFinal),
			Estatus=ISNULL(@Estatus,Estatus)
		WHERE IdVehiculoFabricaXEmpleado = @IdVehiculoFabricaXEmpleado
	COMMIT
END
go

CREATE OR ALTER PROCEDURE SeleccionarVehiculoFabricaXEmpleado
	@IdVehiculoFabricaXEmpleado int,@IdVehiculoFabrica int, @IdEmpleado int, @Labor Varchar(50), @FechaInicio Date, @FechaFinal Date,@Estatus Varchar(50)
AS 
BEGIN
     SELECT IdVehiculoFabricaXEmpleado,IdVehiculoFabrica,VehiculoFabricaXEmpleado.IdEmpleado,Labor,FechaInicio,FechaFinal,Estatus,Empleado.Nombre as Nombre, Empleado.Apellido as Apellido,
	        Empleado.Cedula as Cedula
	 FROM VehiculoFabricaXEmpleado inner join Empleado on VehiculoFabricaXEmpleado.IdEmpleado = Empleado.IdEmpleado
	 WHERE	IdVehiculoFabricaXEmpleado=ISNULL(@IdVehiculoFabricaXEmpleado,IdVehiculoFabricaXEmpleado) and
			IdVehiculoFabrica=ISNULL(@IdVehiculoFabrica,IdVehiculoFabrica)and
			VehiculoFabricaXEmpleado.IdEmpleado=ISNULL(@IdEmpleado,VehiculoFabricaXEmpleado.IdEmpleado)and
			Labor=Isnull(@Labor,Labor)and
			FechaInicio=ISNULL(@FechaInicio,FechaInicio)and
			FechaFinal=ISNULL(@FechaFinal,FechaFinal)and
			Estatus=ISNULL(@Estatus,Estatus)    
END
go

CREATE OR ALTER PROCEDURE SeleccionarEmpleadosFabrica 
							  @Nombre   varchar(50),
							  @Apellido varchar(50),
							  @Telefono varchar(50),
							  @Correo   varchar(50),
							  @Supervisor varchar(50),
							  @Puesto   varchar(50),
							  @Fabrica int,
							  @Cedula   varchar(50)
AS
	SELECT Empleado.Nombre, Apellido, Telefono, Correo, Fabrica.Descripcion 
	FROM Empleado,EmpleadoXFabrica,Fabrica
	WHERE	Empleado.IdEmpleado = EmpleadoXFabrica.IdEmpleado AND EmpleadoXFabrica.IdFabrica = Fabrica.IdFabrica AND
			Empleado.Nombre = ISNULL(@Nombre, Empleado.Nombre) AND
			Apellido = ISNULL(@Apellido, Apellido) AND
			Telefono = ISNULL(@Telefono, Telefono) AND
			Correo = ISNULL(@Correo, Correo) AND
			IdPuestoEmpleado = ISNULL(@Puesto, IdPuestoEmpleado) AND
			Fabrica.IdFabrica = ISNULL(@Fabrica, Fabrica.IdFabrica) AND
			Empleado.Cedula = ISNULL(@Cedula, Empleado.Cedula)
GO

CREATE OR ALTER PROCEDURE SeleccionarEmpleadosSucursal
							  @Nombre   varchar(50),
							  @Apellido varchar(50),
							  @Telefono varchar(50),
							  @Correo   varchar(50),
							  @Supervisor varchar(50),
							  @Puesto   varchar(50),
							  @Sucursal int,
							  @Cedula   varchar(50)
AS
    declare @idPuestoEmpleado int
	SELECT @idPuestoEmpleado = IdPuestoEmpleado FROM PuestoEmpleado WHERE Puesto = @Puesto 

	SELECT Empleado.IdEmpleado,Empleado.Nombre, Apellido, Telefono, Correo,IdPuestoEmpleado, Sucursal.Descripcion,Sucursal.IdSucursal
	FROM Empleado,EmpleadoXSucursal,Sucursal
	WHERE	Empleado.IdEmpleado = EmpleadoXSucursal.IdEmpleado AND EmpleadoXSucursal.IdSucursal = Sucursal.IdSucursal AND
			Empleado.Nombre = ISNULL(@Nombre, Empleado.Nombre) AND
			Apellido = ISNULL(@Apellido, Apellido) AND
			Telefono = ISNULL(@Telefono, Telefono) AND
			Correo = ISNULL(@Correo, Correo) AND
			IdPuestoEmpleado = ISNULL(@idPuestoEmpleado, IdPuestoEmpleado) AND
			Sucursal.IdSucursal = ISNULL(@Sucursal, Sucursal.IdSucursal) AND
			Empleado.Cedula = ISNULL(@Cedula, Empleado.Cedula)
GO



create or alter procedure loginUsuario
                  @username			varchar(50),
				  @password			varchar(50)	
AS

	DECLARE @IdUsuario VARCHAR(100)
	DECLARE @Privilegio VARCHAR(100)
	
	SELECT	@IdUsuario = Usuario.Usuario, @Privilegio = Usuario.Privilegio
	FROM	Usuario 
	WHERE Usuario.Usuario = @username AND Usuario.Pass = @password
	
	IF @IdUsuario IS NULL 
		BEGIN
			Select 'no existe el usuario' as error
		END

	IF @Privilegio = 'Cliente'
	BEGIN 
		SELECT TOP 1 Cliente.IdCliente as IdUsuario, 'Cliente' as Privilegio
		FROM Cliente
		INNER JOIN Usuario
		ON Usuario.IdUsuario = Cliente.IdUsuario 
	END

	IF @Privilegio = 'Empleado'
	BEGIN 
		SELECT TOP 1 Empleado.IdEmpleado as IdUsuario, 'Empleado' as Privilegio
		FROM Empleado
		INNER JOIN Usuario
		ON Usuario.IdUsuario = Empleado.IdUsuario 
	END

	IF @Privilegio = 'Administrador'
	BEGIN 
		SELECT TOP 1 Empleado.IdEmpleado as IdUsuario, 'Administrador' as Privilegio
		FROM Empleado
		INNER JOIN Usuario
		ON Usuario.IdUsuario = Empleado.IdUsuario 
	END
GO

USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE FacturarCredito(@prima int,@idEmpleado int,@idVehiculo INT, @idCliente INT, @comentario VARCHAR(50), @impuesto INT, @descuento INT, @tipoPago VARCHAR(50), @tipoModalidad VARCHAR(50), @subTotal INT, @idSucursal INT)
AS	
	IF @idVehiculo IS NULL OR @idCliente IS NULL OR @comentario IS NULL OR @impuesto IS NULL OR @descuento IS NULL OR @tipoPago IS NULL OR @tipoModalidad IS NULL
		BEGIN
			RAISERROR(N'Informacion incompleta', 1, 1);
			RETURN;
		END
	DECLARE @idTipoPago INT,
			@idTipoModalidad INT,
			@idEmpleadoConfirmado  int,
			@idVehiculoConfirmado int,
			@idClienteConfirmado   int;
	SELECT	@idTipoPago = (SELECT idTipoPago FROM TipoPago WHERE Pago = @tipoPago),
			@idTipoModalidad = (SELECT IdTipoModalidad FROM TipoModalidad WHERE Nombre = @tipoModalidad),
			@idEmpleadoConfirmado = (SELECT IdEmpleado From Empleado Where IdEmpleado = @idEmpleado),
			@idVehiculoConfirmado = (SELECT IdVehiculo From Vehiculo Where IdVehiculo = @idVehiculo),
			@idClienteConfirmado = (SELECT IdCliente From Cliente Where IdCliente = @idCliente)

	IF @idTipoPago IS NULL OR @idTipoModalidad IS NULL OR @idEmpleadoConfirmado IS NULL OR @idVehiculoConfirmado IS NULL OR @idClienteConfirmado IS NULL OR @prima > @subTotal
		BEGIN
			RAISERROR(N'Informacion incorrecta', 1, 1);
			RETURN;
		END
	DECLARE @idDetalleFactura	INT,
			@idFactura			INT,
			@montoTotal			INT;
	SET		@montoTotal = @subTotal - (@subTotal * @descuento / 100);
	BEGIN TRANSACTION
		INSERT INTO DetalleFactura(IdVendedor,IdCliente, IdSucursal, SubTotal, Descuento, Impuestos, IdTipoPago, IdTipoModalidad, Comentario)
		VALUES	(@idEmpleadoConfirmado,@idCliente, @idSucursal, @subTotal, @descuento, @impuesto, @idTipoPago, @idTipoModalidad, @comentario)
		SET @idDetalleFactura = @@IDENTITY;
		INSERT INTO Factura(NumeroFactura, IdDetalleFactura, PrecioTotal, Fecha,MontoPagado)
		VALUES	(@idDetalleFactura, @idDetalleFactura, @montoTotal, GETDATE(),@prima)
		SET @idFactura = @@IDENTITY;
		IF @tipoPago = 'Tarjeta'
		BEGIN
		INSERT INTO MontoHacienda(Monto,IdFactura)
		VALUES(@montoTotal*0.2,@idFactura)
		END
		INSERT INTO FacturaXVehiculo(IdFactura, IdVehiculo)
		VALUES	(@idFactura, @idVehiculo)
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO

CREATE PROCEDURE realizarPago(@idFactura int,@Cantidad int)
as
   declare @FacturaConfirmada int
   declare @error             varchar(50)
   SELECT @FacturaConfirmada = IdFactura
   FROM   Factura
   WHERE IdFactura = @idFactura

   if @FacturaConfirmada is null
      BEGIN
	  SET @error = 'La factura no existe'
	  SELECT @error as Error
	  END
   else
      BEGIN
	  INSERT INTO Pago(Cantidad,Fecha,IdFactura)
	  VALUES (@Cantidad,GETDATE(),@FacturaConfirmada)
	  UPDATE Factura
	  SET MontoPagado = MontoPagado+@Cantidad
	  WHERE IdFactura = @FacturaConfirmada
	  end
go



CREATE OR ALTER PROCEDURE FacturarContado(@idEmpleado int,@idVehiculo INT, @idCliente INT, @comentario VARCHAR(50), @impuesto INT, @descuento INT, @tipoPago VARCHAR(50), @tipoModalidad VARCHAR(50), @subTotal INT, @idSucursal INT)
AS	
	IF @idVehiculo IS NULL OR @idCliente IS NULL OR @comentario IS NULL OR @impuesto IS NULL OR @descuento IS NULL OR @tipoPago IS NULL OR @tipoModalidad IS NULL
		BEGIN
			RAISERROR(N'Informacion incompleta', 1, 1);
			RETURN;
		END
	DECLARE @idTipoPago INT,
			@idTipoModalidad INT,
			@idEmpleadoConfirmado  int,
			@idVehiculoConfirmado int,
			@idClienteConfirmado   int;
	SELECT	@idTipoPago = (SELECT idTipoPago FROM TipoPago WHERE Pago = @tipoPago),
			@idTipoModalidad = (SELECT IdTipoModalidad FROM TipoModalidad WHERE Nombre = @tipoModalidad),
			@idEmpleadoConfirmado = (SELECT IdEmpleado From Empleado Where IdEmpleado = @idEmpleado),
			@idVehiculoConfirmado = (SELECT IdVehiculo From Vehiculo Where IdVehiculo = @idVehiculo),
			@idClienteConfirmado = (SELECT IdCliente From Cliente Where IdCliente = @idCliente)

	IF @idTipoPago IS NULL OR @idTipoModalidad IS NULL OR @idEmpleadoConfirmado IS NULL OR @idVehiculoConfirmado IS NULL OR @idClienteConfirmado IS NULL
		BEGIN
			RAISERROR(N'Informacion incorrecta', 1, 1);
			RETURN;
		END
	DECLARE @idDetalleFactura	INT,
			@idFactura			INT,
			@montoTotal			INT;
	SET		@montoTotal = @subTotal - (@subTotal * @descuento / 100);
	BEGIN TRANSACTION
		INSERT INTO DetalleFactura(IdVendedor,IdCliente, IdSucursal, SubTotal, Descuento, Impuestos, IdTipoPago, IdTipoModalidad, Comentario)
		VALUES	(@idEmpleadoConfirmado,@idCliente, @idSucursal, @subTotal, @descuento, @impuesto, @idTipoPago, @idTipoModalidad, @comentario)
		SET @idDetalleFactura = @@IDENTITY;
		INSERT INTO Factura(NumeroFactura, IdDetalleFactura, PrecioTotal, Fecha,MontoPagado)
		VALUES	(@idDetalleFactura, @idDetalleFactura, @montoTotal, GETDATE(),@montoTotal)
		SET @idFactura = @@IDENTITY;
		IF @tipoPago = 'Tarjeta'
		BEGIN
		INSERT INTO MontoHacienda(Monto,IdFactura)
		VALUES(@montoTotal*0.2,@idFactura)
		END
		INSERT INTO FacturaXVehiculo(IdFactura, IdVehiculo)
		VALUES	(@idFactura, @idVehiculo)
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO


USE Proyecto_BasesII;
GO

CREATE OR ALTER PROCEDURE AprobarPedido(@idPedido INT)
AS
	IF @idPedido IS NULL
		BEGIN
			RAISERROR(N'El id es necesario', 1, 1);
			RETURN;
		END
	DECLARE @comprobarPedido INT;
	SET		@comprobarPedido = (SELECT idPedido FROM Pedido WHERE IdPedido = @idPedido)
	IF @comprobarPedido IS NULL
		BEGIN
			RAISERROR(N'No existe el pedido', 1, 1);
			RETURN;
		END
	BEGIN TRANSACTION
		UPDATE Pedido
		SET EstatusPedido = 'Aprobado'
		WHERE IdPedido = @idPedido
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO


create or alter procedure insertarConsignacion
				  @idCliente varchar(50),
				  @idVehiculo int,
				  @Ganancia   int
AS 
BEGIN
	 declare @VehiculoConfirmado    int
	 declare @ClienteConfirmado       int

	 SELECT @VehiculoConfirmado = IdVehiculo
	 FROM   Vehiculo
	 WHERE  IdVehiculo = @idVehiculo

	 SELECT @ClienteConfirmado = Cedula
	 FROM   Cliente
	 WHERE  Cedula = @idCliente
	 
	 IF @VehiculoConfirmado IS NOT NULL AND @ClienteConfirmado IS NOT NULL
		BEGIN
		BEGIN TRANSACTION
		insert into Consignacion(IdCliente,IdVehiculo,GananciaCliente)
		Values (@ClienteConfirmado,@VehiculoConfirmado,@Ganancia)
		COMMIT
		SELECT IdConsignacion,IdCliente,IdVehiculo,GananciaCliente
		FROM Consignacion
		END
	ELSE
		BEGIN
		DECLARE @error varchar(100)
		SET	 @error = 'El cliente o vehiculo indicado no existen'
		SELECT @error as Error
		END
END
GO

create or alter procedure seleccionarConsignacion
                  @IdConsignacion int,
				  @idCliente varchar(50),
				  @idVehiculo int,
				  @GananciaLow   int,
				  @GananaciaHigh int
AS 
BEGIN

	 SELECT Vehiculo.Marca,Vehiculo.Modelo,Cliente.Nombre,Consignacion.IdConsignacion,Consignacion.GananciaCliente
	 FROM   Consignacion inner join Cliente on Consignacion.IdCliente = Cliente.Cedula
	        inner join Vehiculo on Consignacion.IdVehiculo = Vehiculo.IdVehiculo
	 WHERE  Consignacion.IdCliente  = isnull(@idCliente,Consignacion.IdCliente) AND Consignacion.IdVehiculo  = isnull(@IdVehiculo,Consignacion.IdVehiculo) AND 
	        Consignacion.GananciaCliente between isnull(@GananciaLow,Consignacion.GananciaCliente) and isnull(@GananaciaHigh,Consignacion.GananciaCliente) AND
			Consignacion.IdConsignacion = isnull(@IdConsignacion,Consignacion.IdConsignacion)
	 
END
GO

create or alter procedure modificarConsignacion
				  @idConsignacion   int,
				  @idCliente varchar(50),
				  @idVehiculo int,
				  @Ganancia   int
AS 
BEGIN
	 declare @VehiculoConfirmado    int
	 declare @ClienteConfirmado       int
	 declare @ConsignacionConfirmada int

	 SELECT @VehiculoConfirmado = IdVehiculo
	 FROM   Vehiculo
	 WHERE  IdVehiculo = @idVehiculo

	 SELECT @ClienteConfirmado = Cedula
	 FROM   Cliente
	 WHERE  Cedula = @idCliente

	 SELECT @ConsignacionConfirmada = IdConsignacion
	 FROM   Consignacion
	 WHERE  IdConsignacion = @idConsignacion
	 
	 IF @ConsignacionConfirmada IS NOT NULL
		BEGIN
		BEGIN TRANSACTION
		UPDATE Consignacion
		SET GananciaCliente = isnull(@Ganancia,GananciaCliente),IdCliente = isnull(@ClienteConfirmado,IdCliente),IdVehiculo = isnull(@VehiculoConfirmado,IdVehiculo)
		WHERE IdConsignacion = @ConsignacionConfirmada
		COMMIT
		SELECT IdConsignacion,IdCliente,IdVehiculo,GananciaCliente
		FROM Consignacion
		END
	ELSE
		BEGIN
		DECLARE @error varchar(50)
		SET	 @error = 'La consignacion no existe'
		SELECT @error as Error
		END
END
GO

CREATE OR ALTER procedure insertarDespacho
                  @Telefono   varchar(50),
				  @Extension varchar(50),
				  @Correo varchar(50),
				  @IdFabrica   int
AS 
BEGIN

	 declare @FabricaConfirmada    int
	 declare @ExtensionRepetida int

	 SELECT @FabricaConfirmada = IdFabrica
	 FROM   Fabrica
	 WHERE  IdFabrica = @IdFabrica

	 SELECT @ExtensionRepetida = IdDespacho
	 FROM   Despacho
	 WHERE  Extension = @Extension

	 IF @FabricaConfirmada IS NOT NULL AND @ExtensionRepetida IS NULL
		BEGIN
		BEGIN TRANSACTION
		INSERT into Despacho(Telefono,Extension,Correo,IdFabrica) 
		VALUES(@Telefono,@Extension,@Correo,@FabricaConfirmada)
		COMMIT
		SELECT Telefono,Extension,Correo,IdFabrica
		FROM Despacho
		END
	ELSE
		BEGIN
		DECLARE @error varchar(200)
		SET	 @error = 'La extension ya existe o la fabrica no existe'
		SELECT @error as Error
		END

END
GO

CREATE OR ALTER procedure seleccionarDespacho
                  @Telefono   varchar(50),
				  @Extension varchar(50),
				  @Correo varchar(50),
				  @IdFabrica   int
AS 
BEGIN


	 SELECT Telefono,Extension,Correo,Despacho.IdFabrica,Fabrica.Descripcion as DescripcionFabrica
	 FROM   Despacho inner join Fabrica on Despacho.Idfabrica = Fabrica.IdFabrica
	 WHERE  Telefono = isnull(@Telefono,Telefono) AND Extension = isnull(@Extension,Extension) AND Correo = isnull(@Correo,Correo)
	        AND Fabrica.IdFabrica = ISNULL(@IdFabrica,Fabrica.IdFabrica)

END
GO

CREATE OR ALTER procedure modificarDespacho
			      @IdDespacho int,
                  @Telefono   varchar(50),
				  @Extension varchar(50),
				  @Correo varchar(50),
				  @IdFabrica   int
AS 
BEGIN

	 declare @FabricaConfirmada    int
	 declare @ExtensionRepetida int

	 SELECT @FabricaConfirmada = IdFabrica
	 FROM   Fabrica
	 WHERE  IdFabrica = @IdFabrica

	 SELECT @ExtensionRepetida = IdDespacho
	 FROM   Despacho
	 WHERE  IdDespacho = @IdDespacho

	 IF @FabricaConfirmada IS NOT NULL AND @ExtensionRepetida IS NOT NULL
		BEGIN
		BEGIN TRANSACTION
		Update Despacho
		SET Telefono = isnull(@Telefono,Telefono),Extension = isnull(@Extension,Extension),Correo = isnull(@Correo,Correo),IdFabrica = isnull(@IdFabrica,IdFabrica)
		WHERE IdDespacho = @IdDespacho
		COMMIT
		SELECT Telefono,Extension,Correo,IdFabrica
		FROM Despacho
		END
	ELSE
		BEGIN
		DECLARE @error varchar(200)
		SET	 @error = 'La fabrica no existe o el despacho no existe'
		SELECT @error as Error
		END

END
GO


create or alter  procedure seleccionarTopVehiculos
                  @Tipo varchar(50),
				  @Combustible varchar(50),
				  @Marca   varchar(50),
				  @Modelo  varchar(50),
				  @PrecioLow   int,
				  @PrecioHigh  int,
				  @IdSucursal int
AS 
BEGIN

	 SELECT TOP (10) Sucursal.IdSucursal,Sucursal.Nombre,Vehiculo.IdVehiculo,TipoVehiculo.Nombre as Tipo,Combustible.Nombre as Combustible,Vehiculo.Marca,Vehiculo.Modelo,Vehiculo.Precio,Count(Vehiculo.Modelo) AS Vendidos
	 FROM Vehiculo inner join TipoVehiculo on Vehiculo.IdTipoVehiculo = TipoVehiculo.IdTipoVehiculo
		  inner join Combustible on Vehiculo.IdCombustible = Combustible.IdCombustible
		  inner join FacturaXVehiculo on FacturaXVehiculo.IdVehiculo = Vehiculo.IdVehiculo inner join VehiculoXSucursal on Vehiculo.IdVehiculo = VehiculoXSucursal.IdVehiculo,Sucursal
	 WHERE VehiculoXSucursal.IdSucursal = Sucursal.IdSucursal AND
	       Vehiculo.Marca = isnull(@Marca,Vehiculo.Marca) AND Vehiculo.Modelo = isnull(@Modelo,Vehiculo.Modelo) AND Vehiculo.Precio between isnull(@PrecioLow,Vehiculo.Precio) and isnull(@PrecioHigh,Vehiculo.Precio)
		   AND TipoVehiculo.Nombre = isnull(@Tipo,TipoVehiculo.Nombre) AND Combustible.Nombre = isnull(@Combustible,Combustible.Nombre) AND VehiculoXSucursal.IdSucursal = ISNULL(@IdSucursal,VehiculoXSucursal.IdSucursal)
	 GROUP BY
	        Sucursal.IdSucursal,Sucursal.Nombre,Vehiculo.IdVehiculo,TipoVehiculo.Nombre,Combustible.Nombre,Vehiculo.Marca,Vehiculo.Modelo,Vehiculo.Precio
	 ORDER BY 
	       Vendidos DESC
END
GO


create or alter  procedure seleccionarVehiculoCercano
                  @Locacion geometry,
                  @Tipo varchar(50),
				  @Combustible varchar(50),
				  @Marca   varchar(50),
				  @Modelo  varchar(50),
				  @PrecioLow   int,
				  @PrecioHigh  int,
				  @usado	   bit,
				  @puertas     int
AS 
BEGIN

	 SELECT Top 10 Vehiculo.IdVehiculo,TipoVehiculo.Nombre as Tipo,Combustible.Nombre as Combustible,Vehiculo.Marca,Vehiculo.Modelo,Vehiculo.Precio,Vehiculo.Puertas,Vehiculo.Usado,@Locacion.STDistance(Ubicacion.LocacionExacta) as Distancia
	 FROM Vehiculo inner join TipoVehiculo on Vehiculo.IdTipoVehiculo = TipoVehiculo.IdTipoVehiculo
		  inner join Combustible on Vehiculo.IdCombustible = Combustible.IdCombustible inner join VehiculoXSucursal on Vehiculo.IdVehiculo = VehiculoXSucursal.IdVehiculo inner join Sucursal on VehiculoXSucursal.IdSucursal = Sucursal.IdSucursal inner join Ubicacion on Sucursal.IdUbicacion = Ubicacion.IdUbicacion
	 WHERE Vehiculo.Marca = isnull(@Marca,Vehiculo.Marca) AND Vehiculo.Modelo = isnull(@Modelo,Vehiculo.Modelo) AND Vehiculo.Precio between isnull(@PrecioLow,Vehiculo.Precio) and isnull(@PrecioHigh,Vehiculo.Precio)
		   AND TipoVehiculo.Nombre = isnull(@Tipo,TipoVehiculo.Nombre) AND Combustible.Nombre = isnull(@Combustible,Combustible.Nombre) and
		   Vehiculo.Usado = ISNULL(@usado, Vehiculo.Usado) AND Vehiculo.Puertas = isnull(@puertas,Vehiculo.Puertas) AND Vehiculo.IdVehiculo NOT IN (SELECT FacturaXVehiculo.IdVehiculo FROM FacturaXVehiculo )
	ORDER BY 
	      Distancia ASC
END
GO

