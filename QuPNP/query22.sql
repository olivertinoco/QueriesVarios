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
insert into @tmp001_tablas
exec dbo.usp_listar_tablas
'dbo.PR20_SeguimientoCAB,dbo.RH10_Postulantes'


-- NOTA: EN ESTE PUNTO COMENZAR A PONER VALIDACIONES DEL FRONTEND
-- ==============================================================

declare @vartabla varchar(500), @pos int, @data varchar(1000)
select @data =
'tt.Pos_DocTipoId. .43*mama,
tt.Pos_DocNumero. .44*mama,
tt.Pos_ApPat. .45*mama,
tt.Pos_ApMat. .46*mama,
tt.Pos_Nombres. .47*mama,
tt.Pos_Id. .48*mama,
tt.Pos_Sexo. .49*mama,
tt.Pos_Email. .50*mama,
t.FechaFin. .12*maria,
t.Comentarios. .13*maria,
t.Seg_Id. .14*maria,
t.Proy_Id. .15*maria,
t.Actividad.0.16*maria,
t.Lugar. .17*maria,
t.Responsable_Id. .18*maria,
t.FechaTermino. .19*maria,
t.Prioridad_Id. .120*maria,
t.Avance. .122*maria,
t.Estado_Id. . '
,@vartabla = 't.dbo.PR20_SeguimientoCAB,tt.dbo.RH10_Postulantes'

set nocount on




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

select*from @tabla

insert into @tabla(item, tabla, campo, req, param)
select row_number()over(order by (select 1)) item,
concat(t.esquema, '.', t.tabla) tabla, tt.campo, tt.req, tt.param
from(select*from @tabla where campo is null)t,
(select*from @tabla where not campo is null)tt where t.item = tt.item

select concat(tt.item, '.', tt.column_id, '*', tt.length, '*',
isnull(t.req, tt.is_nullable) ,'*', t.param)
from(select item, tabla, campo, req, param
from @tabla where not try_cast(item as int) is null)t
cross apply @tmp001_tablas tt
where t.tabla = tt.tabla and t.campo = tt.name
order by t.tabla, cast(t.item as int)
