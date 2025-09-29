-- PARA EL GENERICO:
-- =================
-- drop function dbo.udf_general_metadata
-- go
-- drop type tabla_generico
-- go
-- create type tabla_generico as table(
-- orden int,
-- item int,
-- column_id int,
-- tabla varchar(300),
-- name varchar(300),
-- length int,
-- is_nullable int,
-- is_identity int,
-- default_object_id int,
-- is_primary_key int,
-- is_unique_constraint int,
-- tipo_dato int)
-- go

-- NOTA: EN ESTE PUNTO COMENZAR A PONER VALIDACIONES DEL FRONTEND
-- ==============================================================

go
if exists(select 1 from sys.sysobjects where id=object_id('dbo.udf_general_metadata','tf'))
drop function dbo.udf_general_metadata
go
create function dbo.udf_general_metadata(
    @data varchar(max),
    @vartabla varchar(1000),
    @tmp001_tablas tabla_generico readonly
)returns @sqlResult table(dato varchar(max))
as
begin
declare @pos int
declare @tabla table(
item varchar(20),
esquema varchar(20),
tabla varchar(100),
campo varchar(100),
req varchar(1),
param varchar(100)
)
select @data = replace(replace(@data, char(13),''), char(10), '')
while 1=1 begin
    select @pos = charindex(',', @data)
    if @pos = 0 begin
        insert into @tabla(item, campo, req, param) select
        parsename(@data,4), parsename(@data,3),
        nullif(parsename(@data,2),''), parsename(@data,1)
        break;
    end
    insert into @tabla(item, campo, req, param) select
    parsename(substring(@data, 1, @pos - 1), 4),
    parsename(substring(@data, 1, @pos - 1), 3),
    nullif(parsename(substring(@data, 1, @pos - 1), 2),''),
    parsename(substring(@data, 1, @pos - 1), 1)
    select @data = stuff(@data, 1, @pos, '')
end
select @pos = 1
while 1=1 begin
    select @pos = charindex(',', @vartabla)
    if @pos = 0 begin
        insert into @tabla(item, esquema, tabla)select
        parsename(@vartabla,3), parsename(@vartabla,2),
        parsename(@vartabla,1)
        break;
    end
    insert into @tabla(item, esquema, tabla) select
    parsename(substring(@vartabla, 1, @pos - 1), 3),
    parsename(substring(@vartabla, 1, @pos - 1), 2),
    parsename(substring(@vartabla, 1, @pos - 1), 1)
    select @vartabla = stuff(@vartabla, 1, @pos, '')
end

insert into @tabla(item, tabla, campo, req, param)
select row_number()over(order by (select 1)) item,
concat(t.esquema, '.', t.tabla) tabla, tt.campo, tt.req, tt.param
from(select*from @tabla where campo is null)t,
(select*from @tabla where not campo is null)tt where t.item = tt.item

;with tmp001_sep(t,s,r)as(
    select*from(values('|','*','~'))t(sepCamp,sepSubcamp,sepReg)
)
insert into @sqlResult
select stuff((select t, tt.item, '.', tt.column_id, s,
isnull(t.req, tt.is_nullable) , s, tt.tipo_dato, s, tt.length, s, t.param
from(select item, tabla, campo, req, param
from @tabla where not try_cast(item as int) is null)t
cross apply @tmp001_tablas tt
where t.tabla = tt.tabla and t.campo = tt.name
order by t.tabla, cast(t.item as int)
for xml path, type).value('.','varchar(max)'),1,1,r)
from tmp001_sep

return
end
go

-- ========================================================================
-- NOTA: CODIGO QUE HAY QUE ACOPLAR EN LOS SPs DE CADA UNO PARA LA METADATA
-- ========================================================================



declare @tablas tabla_generico
insert into @tablas exec dbo.usp_listar_tablas
'dbo.ASIGNAR_VEHICULO_UNIDAD,dbo.VEHICULO'

select dato from dbo.udf_general_metadata(
't.Id_AsignarVehiculoUnidad..*100,
t.Placa_Interna..*101,
t.Id_vehiculo.0.*100,
t.Id_UnidadDestino..*111,
tt.Placa_Rodaje..*101,
tt.Id_TipoVehiculo..*111,
tt.Id_TipoMarca.0.*111,
tt.Id_TipoModelo..*111,
tt.Anio_Modelo..*101,
tt.Id_TipoColor..*111,
tt.Id_TipoCombustible..*111,
tt.Cilindrada..*101,
tt.Nro_Motor..*101,
tt.Nro_Serie..*101',
't.dbo.ASIGNAR_VEHICULO_UNIDAD,tt.dbo.VEHICULO',
@tablas)

select*from dbo.masterTablas
select*from @tablas
