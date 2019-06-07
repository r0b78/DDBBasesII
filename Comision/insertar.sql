USE Proyecto_BasesII;
GO

CREATE PROCEDURE InsertarComision(@IdFactura INT, @IdEmpleado INT, @Comision INT)
AS
	IF @IdFactura IS NULL OR @IdEmpleado IS NULL OR @Comision IS NULL
		RAISERROR(N'Informacion incompleta', 15001, 1);
	DECLARE @ComprobarFactura INT,
			@ComprobarEmpleado INT;
	SELECT	@ComprobarFactura = (SELECT IdFactura FROM Factura WHERE IdFactura = @IdFactura),
			@ComprobarEmpleado = (SELECT IdEmpleado FROM Empleado WHERE IdEmpleado = @IdEmpleado);
	IF @ComprobarFactura IS NULL
		RAISERROR(N'No existe la factura', 15001, 1);
	ELSE IF @ComprobarEmpleado IS NULL
		RAISERROR(N'No existe el empleado', 15001, 1);
	ELSE IF @Comision <= 0
		RAISERROR(N'Monto no valido', 15020, 1);
	ELSE
		BEGIN TRANSACTION
			INSERT INTO Comision(IdFactura, IdEmpleado, Comision)
			VALUES	(@IdFactura, @IdEmpleado, @Comision)
		COMMIT TRANSACTION
		RETURN @@IDENTITY;
GO