-- ===================================================================
-- NOTA: PARA EL GENERICO
-- ESTO ES PARA CONSUMO TANTO DE IDA COMO DE REGRESO ES EL SP DE PIVOT
-- EL GENERAL DE LA METADATA DE CADA TABLA U
-- ===================================================================
go
-- create table dbo.masterAudit(
--     campo varchar(100),
--     esFecha int
-- )
-- insert into dbo.masterAudit values('UsuarioI', 0), ('FechaI', 1)
go
-- create table dbo.masterTablas(
--     item int,
--     tabla varchar(300)
-- )
-- go
-- insert into dbo.masterTablas
-- select*from(values
-- (1, 'dbo.vehiculo'),
-- (2, 'dbo.asignar_vehiculo_unidad'),
-- (3, 'dbo.RH10_Postulantes'),
-- (4, 'dbo.PR20_SeguimientoCAB')
-- )t(item, tabla)

-- insert into dbo.masterTablas
-- select 4, 'dbo.prog_extraord'

select*from dbo.masterTablas
select*from dbo.masterAudit




go
if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_listar_tablas','p'))
drop procedure dbo.usp_listar_tablas
go
create procedure dbo.usp_listar_tablas
@tablas varchar(500)
as
begin
set nocount on
create table #tmp541yz_param(
    orden int identity,
    tablas varchar(200) collate database_default
)
insert into #tmp541yz_param
select tt.n.value('.','varchar(max)')
from(select cast(concat('<x>', replace(@tablas, ',', '</x><x>'),'</x>') as xml) val)t
cross apply t.val.nodes('/x')tt(n)

select t.item, t.tabla, tt.orden into #tmp541y_tablas
from dbo.masterTablas t cross apply #tmp541yz_param tt where t.tabla = tt.tablas

select*into #tmp001_types
from(values(1,'tinyint'),(1,'smallint'),(1,'int'),(1,'bigint'),(2,'float'),(2,'decimal'),(2,'numeric')
)t(tipo_dato,nombre)

select orden, item, c.column_id, tabla, c.name,
case when not c.collation_name is null then c.max_length end length,
nullif(c.is_nullable, 1) is_nullable, c.is_identity, c.default_object_id,
isnull(i.is_primary_key, 0) is_primary_key, isnull(i.is_unique_constraint, 0) is_unique_constraint,
yy.tipo_dato, isnull(au.audi, 0) audi, isnull(au.esFecha, 0) esFecha
from sys.tables t cross apply #tmp541y_tablas cross apply sys.columns c cross apply sys.types ty
outer apply(select*from sys.index_columns ic
where ic.object_id = t.object_id and ic.object_id = c.object_id and ic.index_column_id = c.column_id)ic
outer apply(select*from sys.indexes i
where i.object_id = t.object_id and i.object_id = ic.object_id and i.index_id = ic.index_id)i
outer apply(select*from #tmp001_types yy where yy.nombre = ty.name)yy
outer apply(select 1 audi, esFecha from dbo.masterAudit au where au.campo = c.name)au
where t.name = parsename(tabla, 1)and t.schema_id = schema_id(parsename(tabla, 2))
and t.object_id = c.object_id
and c.system_type_id = ty.system_type_id and c.user_type_id = ty.user_type_id
order by orden, c.column_id

end
go


-- create type tabla_generico
--
declare @tmp001_tablas table(
orden int,
item int,
column_id int,
tabla varchar(300),
name varchar(300),
length int,
is_nullable int,
is_identity int,
default_object_id int,
is_primary_key int,
is_unique_constraint int,
tipo_dato int,
audit int,
esFecha int)
insert into @tmp001_tablas
exec dbo.usp_listar_tablas
'dbo.ASIGNAR_VEHICULO_UNIDAD,dbo.VEHICULO'


select*from @tmp001_tablas
