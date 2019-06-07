USE Proyecto_BasesII;
GO

CREATE PROCEDURE ActualizarDetalleFactura(@IdDetalleFactura INT, @IdVendedor INT, @IdCliente INT, @SubTotal INT, @IdTipoPago INT, @Comentario VARCHAR(50))
AS
	IF @IdDetalleFactura IS NULL
		RAISERROR(N'El ID es nulo', 15001, 1);
	IF @IdVendedor IS NOT NULL
		DECLARE @ComprobarVendedor INT;
		SET	@ComprobarVendedor = (SELECT IdEmpleado FROM Empleado WHERE IdEmpleado = @IdVendedor);
		IF @ComprobarVendedor IS NULL
			RAISERROR(N'No existe el vendedor', 15001, 1);
	IF @IdCliente IS NOT NULL
		DECLARE @ComprobarCliente INT;
		SET	@ComprobarCliente = (SELECT IdCliente FROM Cliente WHERE IdCliente = @IdCliente);
		IF @ComprobarCliente IS NULL
			RAISERROR(N'No existe el Cliente', 15001, 1);
	IF @IdTipoPago IS NOT NULL
		DECLARE @ComprobarTipoPago INT;
		SET	@ComprobarTipoPago = (SELECT IdTipoPago FROM TipoPago WHERE IdTipoPago = @IdTipoPago);
		IF @ComprobarTipoPago IS NULL
			RAISERROR(N'No existe el Tipo de Pago', 15001, 1);
	BEGIN TRANSACTION
		UPDATE DetalleFactura
		SET IdVendedor = ISNULL(@IdVendedor, IdVendedor), IdCliente = ISNULL(@IdCliente, IdCliente), SubTotal = ISNULL(@SubTotal, SubTotal), IdTipoPago = ISNULL(@IdTipoPago, IdTipoPago),
			Comentario = ISNULL(@Comentario, Comentario)
		WHERE IdDetalleFactura = @IdDetalleFactura;
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO