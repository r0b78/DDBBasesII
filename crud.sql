
create procedure insertarPais
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

execute insertarPais 'Costa Rica','POINT(1 3)'

create procedure seleccionarPais
                  @Nombre varchar(50)
AS 
BEGIN

	 SELECT Nombre,IdPais,Locacion
	 FROM Pais
	 WHERE Nombre = isnull(@Nombre,Pais.Nombre)
END
GO

execute seleccionarPais null

create procedure modificarPais
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

execute modificarPais 'Jamaica','Jamaica2',null

alter procedure insertarProvincia
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

execute insertarProvincia 'San Jose2','POINT(1 4)',1

alter procedure seleccionarProvincia
                  @Nombre varchar(50),
				  @Pais   varchar(50)
AS 
BEGIN

	 SELECT Provincia.Nombre,Provincia.IdProvincia,Provincia.LocacionProvincia,Provincia.IdPais
	 FROM Pais inner join Provincia on Pais.IdPais = Provincia.IdPais
	 WHERE Provincia.Nombre = isnull(@Nombre,Provincia.Nombre) AND Pais.Nombre = isnull(@Pais,Pais.Nombre)
END
GO

execute seleccionarProvincia null,null 

create procedure modificarProvincia
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

execute modificarProvincia 'Cartagos','Cartagoz',null,null

create procedure insertarUbicacion
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

execute insertarUbicacion 'Casa 24E','POINT(1 5)',2

create procedure seleccionarUbicacion
                  @Descripcion varchar(50),
				  @Provincia   varchar(50)
AS 
BEGIN

	 SELECT Ubicacion.Descripcion,Ubicacion.IdProvincia,Ubicacion.LocacionExacta,Ubicacion.IdUbicacion
	 FROM Provincia inner join Ubicacion on Provincia.IdProvincia = Ubicacion.IdUbicacion
	 WHERE Ubicacion.Descripcion = isnull(@Descripcion,Ubicacion.Descripcion) AND Provincia.Nombre = isnull(@Provincia,Provincia.Nombre)
END
GO

execute seleccionarUbicacion null,null

alter procedure modificarUbicacion
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

execute modificarUbicacion 'Casa 24E','Casa 24G',null,null


alter procedure insertarCaracteristica
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

execute insertarCaracteristica 'Color','Azul'

create procedure seleccionarCaracteristica
                  @Caracteristica varchar(50),
				  @Dato varchar(50)
AS 
BEGIN

     SELECT IdCaracteristica,Caracteristica,Dato
	 FROM Caracteristica
	 WHERE Caracteristica.Caracteristica = isnull(@Caracteristica,Caracteristica.Caracteristica) AND Caracteristica.Dato = isnull(@Dato,Caracteristica.Dato)
END
GO

execute seleccionarCaracteristica 'Color','Azul'

create procedure modificarCaracteristica
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

execute modificarCaracteristica 'Azul','Verde',null


create procedure insertarExtra
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

execute insertarExtra 'Spoiler','Alto',1500

create procedure seleccionarExtra
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

execute seleccionarExtra null,null,1500

alter procedure modificarExtra
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

execute modificarExtra 'Spoiler','Spoilers','Bajo',2000

create procedure insertarTipoVehiculo
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

execute insertarTipoVehiculo 'Sports'

create procedure seleccionarTipoVehiculo
                  @Nombre varchar(50)
AS 
BEGIN
     SELECT Nombre,IdTipoVehiculo
	 FROM TipoVehiculo
	 WHERE Nombre = isnull(@Nombre,Nombre)
END
GO

execute seleccionarTipoVehiculo null

create procedure modificarTipoVehiculo
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

execute modificarTipoVehiculo 'Sport','Sportz'

create procedure insertarCombustible
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

execute insertarCombustible 'Super'

create procedure seleccionarCombustible
                  @Nombre varchar(50)
AS 
BEGIN
     SELECT Nombre,IdCombustible
	 FROM Combustible
	 WHERE Nombre = isnull(@Nombre,Nombre)
END
GO

execute seleccionarCombustible null

create procedure modificarCombustible
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

execute modificarCombustible 'Super','Diesel'


alter procedure insertarVehiculo
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

execute insertarVehiculo 'Sportz','Ecologico','Toyota','TE2450',15000

alter  procedure seleccionarVehiculo
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

execute seleccionarVehiculo null,null,null,null,null,null

alter procedure modificarVehiculo
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

execute modificarVehiculo 2,null,null,null,null,10000

alter procedure insertarFotoVehiculo
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

execute insertarFotoVehiculo 'C:\Users\Gabriel\Desktop\D0723ZzUcAAOCSw.jpg','Test3','06-30-1997',2

create procedure seleccionarFotoVehiculo
				  @Nombre varchar(50),
				  @fechaInicio   date,
				  @fechaFin date,
				  @idVehiculo int
AS 
BEGIN

	 SELECT IdFotoVehiculo,Foto,NombreFoto,Fecha,IdVehiculo
	 FROM FotoVehiculo
	 WHERE  NombreFoto = isnull(@Nombre,NombreFoto) AND Fecha between isnull(@fechaInicio,Fecha) AND isnull(@fechaFin,Fecha) AND IdVehiculo = isnull(@idVehiculo,IdVehiculo) 

END
GO

execute seleccionarFotoVehiculo null,null,null,2

alter procedure modificarFotoVehiculo
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

execute modificarFotoVehiculo 3,'C:\Users\Gabriel\Desktop\D0723ZzUcAAOCSw.jpg',null,null,null

alter procedure insertarExtraXVehiculo
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

execute insertarExtraXVehiculo 2,3,1000

alter procedure seleccionarExtraXVehiculo
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

execute seleccionarExtraXVehiculo null,null,null,null

alter procedure modificarExtraXVehiculo
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

execute modificarExtraXVehiculo 1,1,null,null

create procedure insertarCaracteristicaXVehiculo
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

execute insertarCaracteristicaXVehiculo 1,2

alter procedure seleccionarCaracteristicaXVehiculo
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

execute seleccionarCaracteristicaXVehiculo null,null

create procedure modificarCaracteristicaXVehiculo
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

execute modificarCaracteristicaXVehiculo 1,1,null


alter procedure insertarSucursal
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

execute insertarSucursal 'Sales390','Test',2

create procedure seleccionarSucursal
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

execute seleccionarSucursal null,null,null

create procedure modificarSucursal
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

execute modificarSucursal 'Sales360',null,'Test2',2

alter procedure insertarPuestoEmpleado
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

execute insertarPuestoEmpleado 'Gerente'


alter procedure seleccionarPuestoEmpleado
                  @Puesto varchar(50)

AS 
BEGIN
	 SELECT  Puesto,IdPuestoEmpleado
	 FROM PuestoEmpleado
	 WHERE Puesto = isnull(@Puesto,Puesto)
END

execute seleccionarPuestoEmpleado null

alter procedure modificarPuestoEmpleado
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

execute modificarPuestoEmpleado 'Gerente','Vendedor'

alter procedure insertarEmpleado
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
	 
	 IF @CedulaRepetida IS NULL AND @SucursalConfirmada IS NOT NULL AND @PuestoConfirmado IS NOT NULL
		BEGIN
		BEGIN TRANSACTION
		insert into Empleado(Nombre,Apellido,Telefono,Correo,IdSupervisor,IdPuestoEmpleado,IdSucursal,Cedula)
		values (@Nombre,@Apellido,@Telefono,@Correo,@SupervisadorConfirmado,@PuestoConfirmado,@SucursalConfirmada,@Cedula)
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

execute insertarEmpleado 'Pepito','Sanchez','949518','asdasd@asdasd.com','30120313','Vendedor',1,'3012035'

alter procedure seleccionarEmpleado
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

execute seleccionarEmpleado null,null,null,null,null,null,null,null

alter procedure modificarEmpleado
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

execute modificarEmpleado 'Pancho',null,null,null,null,null,null,'30120313'
