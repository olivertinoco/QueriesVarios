if exists(select 1 from sys.sysobjects where id=object_id('dbo.udf_general_metadata02','tf'))
drop function dbo.udf_general_metadata02
go
create function dbo.udf_general_metadata02(
    @data varchar(max),
    @vartabla varchar(1000),
    @tmp001_tablas tabla_generico readonly
)returns @sqlResult table(dato varchar(max))
as
begin
declare @pos int
declare @tabla table(
item int identity,
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
        insert into @tabla(campo, req, param) select
        parsename(@data,3),
        nullif(parsename(@data,2),''),
        parsename(@data,1)
        break;
    end
    insert into @tabla(campo, req, param) select
    parsename(substring(@data, 1, @pos - 1), 3),
    nullif(parsename(substring(@data, 1, @pos - 1), 2),''),
    parsename(substring(@data, 1, @pos - 1), 1)
    select @data = stuff(@data, 1, @pos, '')
end
select @vartabla = stuff(@vartabla, 1, charindex('.', @vartabla), 'dbo.')

;with tmp001_sep(t,s,r)as(
    select*from(values('|','*','~'))t(sepCamp,sepSubcamp,sepReg)
)
insert into @sqlResult
select stuff((select t, tt.item, '.', tt.column_id, s,
isnull(t.req, tt.is_nullable) , s, tt.tipo_dato, s, tt.length, s, t.param
from @tabla t, @tmp001_tablas tt
where t.campo = tt.name and tt.tabla = @vartabla
order by t.item
for xml path, type).value('.','varchar(max)'),1,1,r)
from tmp001_sep

return
end
go




-- ASIGNAR:
-- ============================================================
-- const { selectedItems } = useSelectStore.getState();
-- if (!selectedItems || selectedItems.length === 0) return;
-- const elementoSeleccionado = selectedItems[0];


-- ALMACENAR:
-- ============================================================
-- const { setSelectedItems } = useSelectStore.getState();
-- setSelectedItems([fila]);


-- ELIMINAR:
-- ============================================================
-- useSelectStore.setState({ selectedItems: [] });
