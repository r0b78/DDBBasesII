USE Proyecto_BasesII;
GO

CREATE PROCEDURE InsertarImpuestoXDetalleFactura(@IdImpuesto INT, @IdDetalleFactura INT)
AS
	IF @IdImpuesto IS NULL OR @IdDetalleFactura IS NULL
		RAISERROR(N'Informacion incompleta', 15001, 1);
	DECLARE @ComprobarImpuesto INT,
			@ComprobarDetalle INT;
	SELECT	@ComprobarImpuesto = (SELECT IdImpuesto FROM Impuesto WHERE IdImpuesto = @IdImpuesto),
			@ComprobarDetalle = (SELECT IdDetalleFactura FROM DetalleFactura WHERE IdDetalleFactura = @IdDetalleFactura)
	IF @ComprobarImpuesto IS NULL
		RAISERROR(N'El Impuesto no existe', 15002, 1)
	ELSE IF @ComprobarDetalle IS NULL
		RAISERROR(N'El detalle no existe', 15002, 1)
	ELSE
		BEGIN TRANSACTION
			INSERT INTO ImpuestoXDetalleFactura(IdImpuesto, IdDetalleFactura)
			VALUES	(@IdImpuesto, @IdDetalleFactura)
		COMMIT TRANSACTION
		RETURN @@IDENTITY;
GO