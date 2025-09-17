-- NOTA: TAMAÑO DE REGISTROS X TABLA
-- =================================
select top 0
cast(null as varchar(300)) name,
cast(null as int) rows,
cast(null as varchar(20)) reserved,
cast(null as varchar(20)) data,
cast(null as varchar(20)) index_size,
cast(null as varchar(20)) unused into #tmp001_registros
select top 0
cast(null as varchar(max)) tabla into #tmp001_tablas
declare @tabla varchar(max)=(
select concat('\
select concat('';exec sys.sp_spaceused '''''', a, '''''''') from(values(''',
replace(tabla,'|','''),('''), '''))t(a)')
from(values('\
dbo.tipo_registro|\
dbo.tipo_rubro|\
dbo.tipo_procedencia|\
dbo.tipo_estado_registro|\
dbo.tipo_entidad|\
dbo.tipo_donante|\
dbo.tipo_unidad_medida|\
dbo.tipo_forma_adquisicion|\
dbo.tipo_documento|\
dbo.tipo_grupo_bien|\
dbo.catalogo_bien'
))t(tabla))
insert into #tmp001_tablas exec(@tabla)
select @tabla = (select tabla from #tmp001_tablas
for xml path, type).value('.','varchar(max)')
insert into #tmp001_registros exec(@tabla)
select*from #tmp001_registros order by rows


set rowcount 10
select*from dbo.grupo_bien

return
-- casuistica
select*from dbo.ASIGNAR_VEHICULO_COMANDO  where CIP_USUARIO =  284783

select ttt.id_tipoRegistro, tt.id_grupobien, t.*
from dbo.ASIGNAR_VEHICULO_COMANDO t, dbo.vehiculo tt, dbo.grupo_bien ttt
WHERE t.id_vehiculo = tt.id_vehiculo and tt.id_grupobien = ttt.id_grupobien and  t.CIP_USUARIO =  284783
