

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



select*from dbo.certificado

select*from sys.databases

select tt.name, tt.recovery_model_desc, t.name, t.physical_name,
convert(decimal(10, 2), (size * 8.0)/ 1024)/ 1024 size_GB
from sys.master_files t, sys.databases tt
where t.database_id = tt.database_id




SELECT name, type_desc,* FROM transporte.sys.database_files

-- use transporte
-- go
-- dbcc shrinkfile (TRANSPORTE_log, 1024);
