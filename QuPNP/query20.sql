-- PARA EL GENERICO:
-- =================
declare @vartabla varchar(500), @pos int, @data varchar(500)=(
select
't.Id_AsignarVehiculoUnidad,\
t.Id_vehiculo,\
t.Placa_Interna,\
tt.Placa_Rodaje,\
tt.Id_TipoVehiculo,\
tt.Id_TipoMarca,\
tt.Id_TipoModelo,\
tt.Anio_Modelo,\
tt.Id_TipoColor,\
tt.Id_TipoCombustible,\
tt.Cilindrada,\
tt.Nro_Motor,\
tt.Nro_Serie,\
t.Id_UnidadDestino')
select @vartabla = 't.dbo.ASIGNAR_VEHICULO_UNIDAD,tt.dbo.VEHICULO'

-- from dbo.ASIGNAR_VEHICULO_UNIDAD t, dbo.VEHICULO tt
-- outer apply(select*from dbo.tipo_vehiculo tv where tv.Id_TipoVehiculo = tt.Id_TipoVehiculo)tv
-- outer apply(select*from dbo.tipo_marca tm where tm.Id_TipoMarca = tt.Id_TipoMarca)tm
-- outer apply(select*from dbo.tipo_modelo tmo where tmo.Id_TipoModelo = tt.Id_TipoModelo)tmo
-- outer apply(select*from dbo.tipo_color tc where tc.Id_TipoColor = tt.Id_TipoColor)tc
-- outer apply(select*from dbo.tipo_combustible tcomb where tcomb.Id_TipoCombustible = tt.Id_TipoCombustible)tcomb
-- where t.Id_vehiculo = tt.Id_vehiculo

set nocount off

declare @tabla table(
item varchar(20),
esquema varchar(20),
tabla varchar(100),
campo varchar(100)
)

while 1=1 begin
    select @pos = charindex(',', @data)
    if @pos = 0 begin
        insert into @tabla(item, campo)
        select parsename(@data,2), parsename(@data,1)
        break;
    end
    insert into @tabla(item, campo) select
    parsename(substring(@data, 1, @pos - 1), 2),
    parsename(substring(@data, 1, @pos - 1), 1)
    select @data = stuff(@data, 1, @pos, '')
end
select @pos = 1
while 1=1 begin
    select @pos = charindex(',', @vartabla)
    if @pos = 0 begin
        insert into @tabla(item, esquema, tabla)
        select parsename(@vartabla,3), parsename(@vartabla,2), parsename(@vartabla,1)
        break;
    end
    insert into @tabla(item, esquema, tabla) select
    parsename(substring(@vartabla, 1, @pos - 1), 3),
    parsename(substring(@vartabla, 1, @pos - 1), 2),
    parsename(substring(@vartabla, 1, @pos - 1), 1)
    select @vartabla = stuff(@vartabla, 1, @pos, '')
end

select t.tabla, c.name, c.max_length, c.collation_name
from(select*from @tabla where campo is null)t,
(select*from @tabla where not campo is null)tt, sys.tables u, sys.columns c
where t.item = tt.item and schema_id(t.esquema) = u.schema_id and t.tabla = u.name
and u.object_id = c.object_id and tt.campo = col_name(c.object_id, c.column_id)


set rowcount 10
