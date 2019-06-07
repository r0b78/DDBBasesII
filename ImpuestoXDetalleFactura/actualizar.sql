USE Proyecto_BasesII;
GO

CREATE PROCEDURE ActualizarImpuestoXDetalleFactura(@IdImpuestoXDetalleFactura INT, @IdImpuesto INT, @IdDetalleFactura INT)
AS
	IF @IdImpuestoXDetalleFactura IS NULL
		RAISERROR(N'El ID es nulo', 15003, 1);
	IF @IdImpuesto IS NOT NULL
		DECLARE @ComprobarImpuesto INT;
		SELECT	@ComprobarImpuesto = (SELECT IdImpuesto FROM Impuesto WHERE IdImpuesto = @IdImpuesto);
		IF @ComprobarImpuesto IS NULL
			RAISERROR(N'El Impuesto no existe', 15002, 1)
	IF @IdDetalleFactura IS NOT NULL
		DECLARE @ComprobarDetalleFactura INT;
		SELECT	@ComprobarDetalleFactura = (SELECT IdDetalleFactura FROM DetalleFactura WHERE IdDetalleFactura = @IdDetalleFactura);
		IF @ComprobarDetalleFactura IS NULL
			RAISERROR(N'El DetalleFactura no existe', 15002, 1)
	BEGIN TRANSACTION
		UPDATE ImpuestoXDetalleFactura
		SET IdImpuesto = ISNULL(@IdImpuesto, IdImpuesto), IdDetalleFactura = ISNULL(@IdDetalleFactura, IdDetalleFactura)
		WHERE IdImpuestoXDetalleFactura = @IdImpuestoXDetalleFactura
	COMMIT TRANSACTION
	RETURN @@IDENTITY;
GO