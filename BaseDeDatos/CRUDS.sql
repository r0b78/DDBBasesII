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
				  @idProvincia   int
AS 
BEGIN
     declare @UbicacionRepetida varchar(50)
	 declare @ProvinciaConfirmado    int

	 SELECT @UbicacionRepetida = Descripcion
	 FROM Ubicacion
	 WHERE Descripcion = @Descripcion

	 SELECT @ProvinciaConfirmado = IdProvincia
	 FROM   Provincia
	 WHERE  IdProvincia = @idProvincia
	 
	 IF @UbicacionRepetida IS NULL AND @ProvinciaConfirmado IS NOT NULL
		BEGIN
		BEGIN TRANSACTION
		insert into Ubicacion(Descripcion,IdProvincia,LocacionExacta)
		values (@Descripcion,@ProvinciaConfirmado,@Locacion)
		COMMIT
		SELECT Descripcion,LocacionExacta,IdUbicacion,IdProvincia
		FROM Ubicacion
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
				  @Precio   int
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
		insert into Vehiculo(IdTipoVehiculo,IdCombustible,Marca,Modelo,Precio)
		values (@TipoConfirmado,@CombustibleConfirmado,@Marca,@Modelo,@Precio)
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
				  @PrecioHigh  int
AS 
BEGIN

	 SELECT Vehiculo.IdVehiculo,TipoVehiculo.Nombre as Tipo,Combustible.Nombre as Combustible,Vehiculo.Marca,Vehiculo.Modelo,Vehiculo.Precio
	 FROM Vehiculo inner join TipoVehiculo on Vehiculo.IdTipoVehiculo = TipoVehiculo.IdTipoVehiculo
		  inner join Combustible on Vehiculo.IdCombustible = Combustible.IdCombustible
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
				  @Precio  int
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
		    Precio = isnull(@Precio,Precio)
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
	 declare @sql                   varchar(max)
	 set @sql = 'Insert into FotoVehiculo(Foto) SELECT BulkColumn FROM OPENROWSET(BULK '''+@foto+''', SINGLE_BLOB) as X'

	 SELECT @VehiculoConfirmado = IdVehiculo
	 FROM   Vehiculo
	 WHERE  IdVehiculo = @idVehiculo
	 
	 IF @VehiculoConfirmado IS NOT NULL 
		BEGIN
		BEGIN TRANSACTION
		exec(@sql)
		COMMIT
		BEGIN TRANSACTION
		UPDATE FotoVehiculo 
		SET NombreFoto = @Nombre,Fecha = @fecha,IdVehiculo = @idVehiculo
		Where IdFotoVehiculo = IDENT_CURRENT('FotoVehiculo')
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
				  @idVehiculo int,
				  @precio int
AS 
BEGIN
	 declare @VehiculoConfirmado    int
	 declare @ExtraConfirmado       int

	 SELECT @VehiculoConfirmado = IdVehiculo
	 FROM   Vehiculo
	 WHERE  IdVehiculo = @idVehiculo

	 SELECT @ExtraConfirmado = IdExtra
	 FROM   Extra
	 WHERE  IdExtra = @idExtra
	 
	 IF @VehiculoConfirmado IS NOT NULL AND @ExtraConfirmado IS NOT NULL
		BEGIN
		BEGIN TRANSACTION
		insert into ExtraXVehiculo(IdExtra,IdVehiculo,PrecioPagado)
		Values (@ExtraConfirmado,@VehiculoConfirmado,@precio)
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
				  @IdUbicacion   int
AS 
BEGIN

	 SELECT Sucursal.IdSucursal,Sucursal.Nombre,Sucursal.Descripcion,Ubicacion.Descripcion
	 FROM  Sucursal INNER JOIN Ubicacion on Sucursal.IdUbicacion = Ubicacion.IdUbicacion
	 WHERE Sucursal.Nombre = isnull(@Nombre,Sucursal.Nombre) AND Sucursal.Descripcion = isnull(@Descripcion,Sucursal.Descripcion) AND 
	       Sucursal.IdUbicacion = isnull(@IdUbicacion,Sucursal.IdUbicacion)

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

create or alter procedure insertarEmpleado
                  @Nombre   varchar(50),
				  @Apellido varchar(50),
				  @Telefono varchar(50),
				  @Correo   varchar(50),
				  @Supervisor varchar(50),
				  @Puesto   varchar(50),
				  @Sucursal int,
				  @Cedula   varchar(50),
				  @idUsuario int

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
		insert into Empleado(Nombre,Apellido,Telefono,Correo,IdSupervisor,IdPuestoEmpleado,IdSucursal,Cedula,IdUsuario)
		values (@Nombre,@Apellido,@Telefono,@Correo,@SupervisadorConfirmado,@PuestoConfirmado,@SucursalConfirmada,@Cedula,@idUsuario)
		COMMIT
		SELECT IdEmpleado,Nombre,Apellido,Telefono,Correo,IdSupervisor,IdPuestoEmpleado,IdSucursal,Cedula
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
	      inner join Sucursal on Empleado.IdSucursal = Sucursal.IdSucursal
		  inner join Empleado e2 on Empleado.IdSupervisor = e2.IdEmpleado

	 WHERE Empleado.Nombre = isnull(@Nombre,Empleado.Nombre) AND Empleado.Apellido = isnull(@Apellido,Empleado.Apellido) AND Empleado.Telefono = isnull(@Telefono,Empleado.Telefono)
	       AND Empleado.Correo = isnull(@Correo,Empleado.Correo) AND e2.Cedula = isnull(@Supervisor,e2.Cedula) AND PuestoEmpleado.Puesto = isnull(@Puesto,PuestoEmpleado.Puesto)
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
				  @Sucursal int,
				  @Cedula   varchar(50)

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
	 
	 IF @CedulaRepetida IS NOT NULL 
		BEGIN
		BEGIN TRANSACTION
		UPDATE Empleado
		SET Nombre = isnull(@Nombre,Nombre),Apellido = isnull(@Apellido,Apellido),Telefono = isnull(@Telefono,Telefono),Correo = isnull(@Correo,Correo),
		    IdSupervisor = isnull(@SupervisadorConfirmado,IdSupervisor),IdPuestoEmpleado = isnull(@PuestoConfirmado,IdPuestoEmpleado),IdSucursal = isnull(@SucursalConfirmada,IdSucursal)
		Where Cedula = @CedulaRepetida
		COMMIT
		SELECT IdEmpleado,Nombre,Apellido,Telefono,Correo,IdSupervisor,IdPuestoEmpleado,IdSucursal,Cedula
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

CREATE OR ALTER PROCEDURE ActualizarCliente(@IdCliente INT, @Nombre VARCHAR(50), @Apellido VARCHAR(50), @Telefono VARCHAR(50), @Correo VARCHAR(50), @IdUbicacion INT)
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
	IF @IdUbicacion IS NOT NULL
		BEGIN
			DECLARE @ComprobarUbicacion INT;
			SET @ComprobarUbicacion = (SELECT IdUbicacion FROM Ubicacion WHERE IdUbicacion = @IdUbicacion)
			IF @ComprobarUbicacion IS NULL
				BEGIN
					RAISERROR(N'La ubicacion no existe', 1, 1);
				END
		END
	BEGIN TRANSACTION
		UPDATE Cliente
		SET Nombre = @Nombre, Apellido = @Apellido, Telefono = @Telefono, Correo = @Correo, IdUbicacion = @IdUbicacion
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

CREATE OR ALTER PROCEDURE InsertarCliente(@IdUsuario INT, @Nombre VARCHAR(50), @Apellido VARCHAR(50), @Telefono VARCHAR(50), @Correo VARCHAR(50), @IdUbicacion INT)
AS
	IF @Nombre IS NULL OR @Apellido IS NULL OR @Telefono IS NULL OR @Correo IS NULL OR @IdUbicacion IS NULL
		BEGIN
			RAISERROR(N'Informacion Incompleta', 1, 1);
		END
	DECLARE @ComprobarCorreo	INT,
			@ComprobarTelefono	INT,
			@ComprobarUbicacion INT;
	SELECT	@ComprobarCorreo = (SELECT IdCliente FROM Cliente WHERE Correo = @Correo),
			@ComprobarTelefono = (SELECT IdCliente FROM Cliente WHERE Telefono = @Telefono),
			@ComprobarUbicacion = (SELECT IdUbicacion FROM Ubicacion WHERE IdUbicacion = @IdUbicacion);
	IF @ComprobarCorreo IS NOT NULL
		BEGIN
			RAISERROR(N'Correo ya utilizado', 1, 1);
		END
	ELSE IF @ComprobarTelefono IS NOT NULL
		BEGIN
			RAISERROR(N'Numero de telefono duplicado', 1, 1);
		END
	ELSE IF @ComprobarUbicacion IS NULL
		BEGIN
			RAISERROR(N'No existe la ubicacion', 1, 1);
		END
	ELSE
		BEGIN
			BEGIN TRANSACTION
				INSERT INTO Cliente(Nombre, Apellido, Telefono, Correo, IdUbicacion, IdUsuario)
				VALUES	(@Nombre, @Apellido, @Telefono, @Correo, @IdUbicacion, @IdUsuario)
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
	INNER JOIN  Ubcacion
	ON          Entrega.IdUbicacion = Ubicacion.IdUbicacion
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

CREATE OR ALTER PROCEDURE SeleccionarFacturas(@IdFactura INT, @NumeroFactura VARCHAR(50), @IdDetalleFactura INT, @PrecioInicial INT, @PrecioFinal INT, @FechaInicial DATE, @FechaFinal DATE)
AS
	SELECT	NumeroFactura, PrecioTotal, Fecha, Factura.IdDetalleFactura,DetalleFactura.Comentario
	FROM	Factura inner join DetalleFactura on Factura.IdDetalleFactura = DetalleFactura.IdDetalleFactura
	WHERE	IdFactura = ISNULL(@IdFactura, IdFactura) AND
			NumeroFactura = ISNULL(@NumeroFactura, NumeroFactura) AND
			Factura.IdDetalleFactura = ISNULL(@IdDetalleFactura, Factura.IdDetalleFactura) AND
			PrecioTotal BETWEEN ISNULL(@PrecioInicial, PrecioTotal) AND ISNULL(@PrecioFinal, PrecioTotal) AND
			Fecha BETWEEN ISNULL(@FechaInicial, Fecha) AND ISNULL(@FechaFinal, Fecha)
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
	 @IdSucursal int, @Descripcion Varchar(50)
AS
BEGIN

	Begin Transaction;
	--validar si existe
	insert into Fabrica(IdSucursal,Descripcion)
	values(@IdSucursal,@Descripcion)
	--end
	commit 
END
go

CREATE OR ALTER PROCEDURE ModificarFabrica
	@IdFabrica int, @IdSucursal int, @Descripcion Varchar(50)
AS
BEGIN
	BEGIN TRANSACTION
		update Fabrica 
		SET IdSucursal = isnull(@IdSucursal,IdSucursal),
			Descripcion = isnull(@Descripcion,Descripcion)
		WHERE IdFabrica = @IdFabrica
	COMMIT
END
go

CREATE OR ALTER PROCEDURE SeleccionarFabrica
                  @IdFabrica int, @IdSucursal int, @Descripcion Varchar(50)
AS 
BEGIN
     SELECT IdFabrica,Fabrica.IdSucursal,Fabrica.Descripcion as Fabrica,Sucursal.Nombre as Sucursal
	 FROM Fabrica inner join Sucursal on Fabrica.IdSucursal = Sucursal.IdSucursal
	 WHERE	IdFabrica=isnull(@IdFabrica,IdFabrica) AND
			Fabrica.IdSucursal = isnull(@IdSucursal,Fabrica.IdSucursal) AND
			Fabrica.Descripcion = isnull(@Descripcion,Fabrica.Descripcion)      
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
