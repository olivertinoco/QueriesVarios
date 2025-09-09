if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_listar_tablas','p'))
drop procedure dbo.usp_listar_tablas
go
create procedure dbo.usp_listar_tablas
as
begin
set nocount on

select item, tabla into #tmp541y_tablas from(values
(1, 'dbo.asignar_vehiculo_unidad'),
(2, 'dbo.vehiculo')
)t(item, tabla)

select item, c.column_id, tabla, c.name, case when not c.collation_name is null then c.max_length end length,
nullif(c.is_nullable, 1) is_nullable, c.is_identity, c.default_object_id,
i.is_primary_key, i.is_unique_constraint
from sys.tables t cross apply #tmp541y_tablas cross apply sys.columns c
outer apply(select*from sys.index_columns ic
where ic.object_id = t.object_id and ic.object_id = c.object_id and ic.index_column_id = c.column_id)ic
outer apply(select*from sys.indexes i
where i.object_id = t.object_id and i.object_id = ic.object_id and i.index_id = ic.index_id)i
where t.name = parsename(tabla, 1)and t.schema_id = schema_id(parsename(tabla, 2))
and t.object_id = c.object_id
order by item, c.column_id

end
go


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

select*from @tmp001_tablas
