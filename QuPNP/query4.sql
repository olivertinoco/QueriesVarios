set rowcount 0

;WITH UltimoSOAT AS (
	select V.Id_Vehiculo, V.Placa_Interna, C.NroCertificado, C.FecInicioSeguro, C.FecTerminoSeguro
	, ROW_NUMBER() OVER (PARTITION BY V.Placa_Interna ORDER BY C.FecTerminoSeguro desc) AS Fecha
	from Vehiculo V
	inner join CERTIFICADO C on V.Id_Vehiculo = C.IdVehiculo
)
	Select Id_Vehiculo, Placa_Interna, NroCertificado, FecInicioSeguro, FecTerminoSeguro, Fecha
	, convert(date, getdate(), 103)
	from UltimoSOAT
	where Fecha = 1
	and FecTerminoSeguro >= convert(date, getdate(), 103)
	Group by Id_Vehiculo, Placa_Interna, NroCertificado, FecInicioSeguro, FecTerminoSeguro, Fecha
	order by FecTerminoSeguro desc
-- select t.*from dbo.vehiculo t
-- cross apply dbo.certificado tt
-- where t.Id_Vehiculo = tt.IdVehiculo


-- select*from dbo.mastertable('dbo.vehiculo')
