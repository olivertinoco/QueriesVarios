-- declare @data varchar(max) =
-- 'tret~146|1|1253|MARIa|3.1|3.8|3.10|3.12'
-- 'sda~|2|1|122312|ASSD|3.1|3.3|3.8|3.10|3.12'

go
if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_crud_generico01','p'))
drop procedure dbo.usp_crud_generico01
go
create procedure dbo.usp_crud_generico01
@data varchar(max)
as
begin
set nocount on
set language english
begin try

declare
@maxi int, @tablas varchar(max), @Utabla tabla_generico, @merge varchar(max),
@usuario varchar(20) = substring(@data,0, charindex('~',@data))
select @data = stuff(@data,1, charindex('~',@data), '')
create table #tmp001_param(
    orden1 int identity,
    dato varchar(1000)
)
select @data = concat('select*from(values(''', replace(@data, '|', '''),('''), '''))t(a)')
insert into #tmp001_param exec(@data)
select @maxi = scope_identity() / 2

select @tablas = stuff((select ',', tabla
from(select distinct parsename(dato, 2) item from #tmp001_param where orden1 > @maxi)t,
dbo.masterTablas tt where t.item = tt.item
for xml path, type).value('.','varchar(max)'),1,1,'')
insert into @Utabla
exec dbo.usp_listar_tablas @tablas

select distinct @tablas = tabla from @Utabla

select tt.orden1, t.name, t.is_identity, t.default_object_id, t.is_primary_key into #tmp001_dato
from @Utabla t, #tmp001_param tt
where tt.orden1 > @maxi and concat(t.item,'.',t.column_id) = tt.dato
union all select*from(
select row_number()over(order by (select 0))+999 item,
t.name, t.is_identity, t.default_object_id, t.is_primary_key
from @Utabla t where audit = 1 order by esFecha offset 0 rows)t

;with tmp001_dato as(
    select*from #tmp001_dato
)
,tmp001_merge(dato) as(
    select concat(';merge into ', @tablas,
    ' t using #tmp001_datos s on(www)when matched then update set xxx when not matched then insert(yyy)values(zzz);')
)
,tmp001_on(dato) as(
    select stuff((select ' and t.', name, '=s.', name
    from tmp001_dato where is_primary_key = 1 order by orden1
    for xml path, type).value('.','varchar(max)'),1,5,'')
)
,tmp001_matched(dato) as(
    select stuff((select ',t.', name, '=s.', name
    from tmp001_dato where is_primary_key = 0 and is_identity = 0 order by orden1
    for xml path, type).value('.','varchar(max)'),1,1,'')
)
,tmp001_not_matched(dato) as(
    select stuff((select ',',name
    from tmp001_dato where is_identity = 0 and default_object_id = 0 order by orden1
    for xml path, type).value('.','varchar(max)'),1,1,'')
)
,tmp002_not_matched(dato) as(
    select stuff((select ',s.',name
    from tmp001_dato where is_identity = 0 and default_object_id = 0 order by orden1
    for xml path, type).value('.','varchar(max)'),1,1,'')
)
select @merge =
replace(replace(replace(replace(t.dato, 'www', t1.dato), 'xxx', t2.dato), 'yyy', t3.dato), 'zzz', t4.dato)
from tmp001_merge t,
tmp001_on t1,
tmp001_matched t2,
tmp001_not_matched t3,
tmp002_not_matched t4

select @tablas = concat('select ', stuff((select ',', case is_identity when 1 then 'cast(null as int)' end, name
from #tmp001_dato order by orden1
for xml path, type).value('.','varchar(max)'),1,1,''), ' into #tmp001_datos from ', @tablas, ' where 1=2;')

select orden1, dato into #tmp001_data_crud from #tmp001_param where orden1 < @maxi + 1
union all select 999, @usuario

;with tmp001_cab(dato) as(
    select concat(stuff((select ',a', orden1 from #tmp001_data_crud
    for xml path, type).value('.','varchar(max)'),1,1,''), ',a0')
)
select @tablas = concat(@tablas, stuff((select ',''', dato, ''''
from #tmp001_data_crud order by orden1
for xml path, type).value('.','varchar(max)'),1,1,'insert into #tmp001_datos select*from(values('),
', getdate()))t(', c.dato, ')')
from tmp001_cab c

exec(@tablas + @merge)

select 1

end try
begin catch
    select concat('error:', error_message())
end catch
end
go


declare @data varchar(max) =
-- 'tret~146|1|1253|MARIa|3.1|3.8|3.10|3.12'
'sda~|2|1|122312|ASSD|3.1|3.3|3.8|3.10|3.12'

-- exec dbo.usp_crud_generico01 @data

select top 10 *from dbo.grupo_bien order by  Id_GrupoBien desc
-- -- 12819
