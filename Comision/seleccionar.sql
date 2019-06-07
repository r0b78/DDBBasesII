USE Proyecto_BasesII;
GO

CREATE PROCEDURE SeleccionarComisiones(@IdComision INT, @ComisionInicial INT, @ComisionFinal INT, @FechaInicial DATE, @FechaFinal DATE)
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