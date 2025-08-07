set rowcount 100
-- exec sp_spaceused PROG_VEHICULO
-- select*from mastertable('dbo.MasterPNP')


select*from dbo.MasterPNP


return
-- insert into dbo.MasterPNP
select
str(CAST(RAND(CHECKSUM(NEWID())) * 900000000 + 100000000 AS BIGINT), 9, 0),
str(t.ma76, 8, 0), str(t.ma98, 8, 0),
left(ltrim(t.APEPAT), 90), left(ltrim(t.APEMAT), 90),
left(ltrim(t.NOMBRE), 90), t.ma02, left(ltrim(t.DescripcionC),90),
tt.id_unidad, tt.UltimaUnidad, 1, 'ACTIVIDAD', getdate(), getdate()
from(select row_number()over(order by (select 1))item, ma76, ma98, APEPAT, APEMAT, NOMBRE, ma02, tt.DescripcionC
from transporte.dbo.MASPOL t cross apply transporte.dbo.Tipo_Grado tt
where t.ma02 = tt.Id_TipoGrado)t cross apply
(select row_number()over(order by (select 1))item, id_unidad, UltimaUnidad
from dbo.unidad)tt
where t.item = tt.item
