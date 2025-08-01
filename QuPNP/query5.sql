set rowcount 0

-- NOTA: SON HERRAMIENTAS DE DESARROLLO PARA HOMOLOGAR LAS TABLAS DE SISPAP Y TRANSPORTE

select top 0
cast(null as varchar(200)) name,
cast(null as int) rows,
cast(null as varchar(50)) reserved,
cast(null as varchar(50)) data,
cast(null as varchar(50)) index_size,
cast(null as varchar(50)) unused into #tmp001_sizeU


select top 0 cast(null as varchar(100)) tabla into #tmp001_tablas
declare @datos varchar(max) = (
select (select ';select distinct tabla from dbo.mastertable(''', name, ''') where name = ''Id_Vehiculo'''
from sys.tables
order by 1
for xml path, type).value('.','varchar(max)'))
insert into #tmp001_tablas exec(@datos)

select @datos = (select ';exec sp_spaceused ', tabla
from #tmp001_tablas
for xml path, type).value('.','varchar(max)')
insert into #tmp001_sizeU exec(@datos)


select @datos = (select ';select*from mastertable(''', name, ''')'
-- select @datos = (select ';alter table ', name, ' alter column Id_Vehiculo int null'
-- select @datos = (select ';update t set Id_Vehiculo = null from ', name, ' t'
from(select*from #tmp001_sizeU where rows != 0)t where name != 'VEHICULO'
for xml path, type).value('.','varchar(max)')
-- exec(@datos)

-- NOTA: QUEREMOS POBLAR EL ID DE VEHICULO QUE VIENE DE TRANSPORTE PARA ESTA LISTA DE TABLAS:
select *
from(select*from #tmp001_sizeU where rows != 0)t where name != 'VEHICULO'
