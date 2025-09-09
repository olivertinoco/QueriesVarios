-- PARA EL GENERICO:
-- =================
declare @tmp001_tablas table(
item int,
column_id int,
tabla varchar(300),
name varchar(300),
length int,
is_nullable int,
is_identity int,
default_object_id int,
is_primary_key int,
is_unique_constraint int)
insert into @tmp001_tablas exec dbo.usp_listar_tablas


-- NOTA: EN ESTE PUNTO COMENZAR A PONER VALIDACIONES DEL FRONTEND
-- ==============================================================

declare @vartabla varchar(500), @pos int, @data varchar(1000)
select @data =
't.Id_AsignarVehiculoUnidad.101|3434|DATA|pa|102,
t.Id_vehiculo.110|6545,
t.Placa_Interna.111|445,
t.Id_UnidadDestino.115|hhi|rt,
tt.Placa_Rodaje,
tt.Id_TipoVehiculo,
tt.Id_TipoMarca,
tt.Id_TipoModelo,
tt.Anio_Modelo,
tt.Id_TipoColor,
tt.Id_TipoCombustible,
tt.Cilindrada,
tt.Nro_Motor,
tt.Nro_Serie'
,@vartabla = 't.dbo.ASIGNAR_VEHICULO_UNIDAD,tt.dbo.VEHICULO'

set nocount on




declare @tabla table(
item varchar(20),
esquema varchar(20),
tabla varchar(100),
campo varchar(100)
)
select @data = replace(replace(@data, char(13),''), char(10), '')
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

insert into @tabla(item,tabla, campo)
select row_number()over(order by (select 1)) item,
concat(t.esquema, '.', t.tabla) tabla, tt.campo
from(select*from @tabla where campo is null)t,
(select*from @tabla where not campo is null)tt where t.item = tt.item

select concat(tt.item, '.', tt.column_id), tt.length, tt.is_nullable
from(select item, tabla, campo from @tabla where not try_cast(item as int) is null)t
cross apply @tmp001_tablas tt
where t.tabla = tt.tabla and t.campo = tt.name
order by t.tabla, cast(t.item as int)
