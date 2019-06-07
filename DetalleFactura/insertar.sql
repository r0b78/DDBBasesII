USE Proyecto_BasesII;
GO

CREATE PROCEDURE InsertarDetalleFactura(@IdVendedor INT, @IdCliente INT, @SubTotal INT, @IdTipoPago INT, @Comentario VARCHAR(50))
AS
	IF @IdVendedor IS NULL OR @IdCliente IS NULL OR @SubTotal IS NULL OR @IdTipoPago IS NULL OR @Comentario IS NULL
		RAISERROR(N'Informacion Incompleta', 15001, 1);
	DECLARE @ComprobarVendedor INT,
			@ComprobarCliente INT,
			@ComprobarTipoPago INT;
	SELECT	@ComprobarVendedor = (SELECT IdEmpleado FROM Empleado WHERE IdEmpleado = @IdVendedor),
			@ComprobarCliente = (SELECT IdCliente FROM Cliente WHERE IdCliente = @IdCliente),
			@ComprobarTipoPago = (SELECT IdTipoPago FROM TipoPago WHERE IdTipoPago = @IdTipoPago);
	IF @ComprobarVendedor IS NULL
		RAISERROR(N'No existe el vendedor', 15001, 1);
	ELSE IF @ComprobarCliente IS NULL
		RAISERROR(N'No existe el cliente', 15001, 1);
	ELSE IF @ComprobarTipoPago IS NULL
		RAISERROR(N'No existe el metodo de pago', 15001, 1);
	ELSE
		BEGIN TRANSACTION
			INSERT INTO DetalleFactura(IdVendedor, IdCliente, SubTotal, IdTipoPago, Comentario)
			VALUES	(@IdVendedor, @IdCliente, @SubTotal, @IdTipoPago, @Comentario)
		COMMIT TRANSACTION
		RETURN @@IDENTITY;
GO