-- NOTA: ESTO ES LA DESCRIPCION DE CADA CAMPO DE UNA TABLA
-- =======================================================
set rowcount 10

-- select t.name tabla, tt.name columna, convert(varchar(100), ttt.value) comentario
-- from sys.tables t, sys.columns tt, sys.extended_properties ttt
-- where t.object_id = tt.object_id
-- and t.schema_id = schema_id('dbo') and t.name = 'operatividad'
-- and tt.object_id = ttt.major_id and tt.column_id = ttt.minor_id
-- return

select*from dbo.operatividad
select*from dbo.asignar_vehiculo_unidad
select*from dbo.masterLicencia
select*from dbo.masterPNP


set rowcount 0
select*from dbo.mastertable('dbo.operatividad')

select t.name tabla, tt.name columna, convert(varchar(100), ttt.value) comentario
from sys.tables t, sys.columns tt, sys.extended_properties ttt
where t.object_id = tt.object_id
and t.schema_id = schema_id('dbo') and t.name = 'operatividad'
and tt.object_id = ttt.major_id and tt.column_id = ttt.minor_id

select*from dbo.mastertable('dbo.asignar_vehiculo_unidad')
select*from dbo.mastertable('dbo.masterLicencia')
select*from dbo.mastertable('dbo.masterPNP')
