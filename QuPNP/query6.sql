set rowcount 100

declare @tabla varchar(100) = 'OPERATIVIDAD_VEHICULO'

select*from sys.default_constraints
where parent_object_id = object_id(@tabla)

select object_name(constraint_object_id) fk_name,
col_name(parent_object_id, parent_column_id) campo,
object_name(referenced_object_id) tabla_ref,
col_name(referenced_object_id, referenced_column_id) campo_ref
from sys.foreign_key_columns
where parent_object_id = object_id(@tabla)

select*into #tmp001_operatividadSISPAP from mastertable(@tabla)

-- select*from dbo.OPERATIVIDAD_VEHICULO
-- return
-- select distinct Id_TipoEstadoOpeVehiculo from dbo.OPERATIVIDAD_VEHICULO
-- select distinct Id_TipoEstadoOpeOdometro from dbo.OPERATIVIDAD_VEHICULO
-- SELECT * FROM dbo.TIPO_ESTADO_OPERATIVIDAD
-- SELECT * FROM dbo.TIPO_ESTADO_REGISTRO
-- SELECT * FROM dbo.TIPO_ESTADO_VEHICULO
-- return

use transporte;

;with tmp001_existSISPAP as(
    select t.name, t.type, t.max_length
    from #tmp001_operatividadSISPAP t,(
    select name from #tmp001_operatividadSISPAP
    except
    select name from mastertable(@tabla))tt where t.name = tt.name
)
select t.name, t.type, t.max_length, tt.name, tt.type, tt.max_length
from mastertable(@tabla)t outer apply(
select*from #tmp001_operatividadSISPAP tt where tt.name = t.name)tt
union all
select null, null, null, name, type, max_length from tmp001_existSISPAP
