USE Proyecto_BasesII;
GO

CREATE PROCEDURE ActualizarComision(@IdComision INT, @IdFactura INT, @IdEmpleado INT, @Comision INT)
AS
	IF @IdComision IS NULL
		RAISERROR(N'El ID es nulo', 15021, 1);
	IF @IdFactura IS NOT NULL
		DECLARE @ComprobarFactura INT;
		SET	@ComprobarFactura = (SELECT IdFactura FROM Factura WHERE IdFactura = @IdFactura);
		IF @ComprobarFactura IS NULL
			RAISERROR(N'No existe la factura', 15001, 1);
	IF @IdEmpleado IS NOT NULL
		DECLARE @ComprobarEmpleado INT;
		SET	@ComprobarEmpleado = (SELECT IdEmpleado FROM Empleado WHERE IdEmpleado = @IdEmpleado);
		IF @ComprobarEmpleado IS NULL
			RAISERROR(N'No existe el Empleado', 15001, 1);
	BEGIN TRANSACTION
		UPDATE Comision
		SET IdFactura = ISNULL(@IdFactura, IdFactura), IdEmpleado = ISNULL(@IdEmpleado, IdEmpleado), Comision = ISNULL(@Comision, Comision)
		WHERE IdComision = @IdComision
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO