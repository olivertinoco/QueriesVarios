if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_crud_generico02_data','p'))
drop procedure dbo.usp_crud_generico02_data
go
create procedure dbo.usp_crud_generico02_data
@data varchar(max),
@tempGlob varchar(200)
as
begin
begin try
set nocount on
set language english

declare @nombreCampo varchar(100),
@cabeGlob varchar(200) = replace(convert(varchar(36), newid()), '-','_')
select top 0 cast(null as varchar(100)) collate database_default pks into #tmp001_pks
create table #tmp001_tablas(
    item int identity,
    dato varchar(max) collate database_default
)
insert into #tmp001_tablas
select*from dbo.udf_split(@data, '^')

if exists(select 1 from #tmp001_tablas where dato != '' having count(1) = 2)begin
    select @data = dato from #tmp001_tablas where item = 1
    exec dbo.usp_crud_generico01 @data, @cabeGlob
    exec ('insert into #tmp001_pks select*from ##tmp001_salida' + @cabeGlob)
    insert into #tmp001_clavesHead select pks from #tmp001_pks
    select @nombreCampo = 'tempdb.dbo.##tmp001_salida' + @cabeGlob
    select @nombreCampo = name from tempdb.sys.columns where object_id = object_id(@nombreCampo)
    select @data = dato from #tmp001_tablas where item = 2
    exec dbo.usp_crud_generico01 @data, @tempGlob, @nombreCampo
    insert into #tmp001_flag select*from(values(1))t(a)
end
if exists(select 1 from #tmp001_tablas where item = 2 and dato = '' )begin
    select @data = dato from #tmp001_tablas where item = 1
    exec dbo.usp_crud_generico01 @data, @tempGlob
    insert into #tmp001_flag select*from(values(2))t(a)
end
if exists(select 1 from #tmp001_tablas where item = 1 and dato = '' )begin
    select @data = dato from #tmp001_tablas where item = 2
    exec dbo.usp_crud_generico01 @data, @tempGlob
    insert into #tmp001_flag select*from(values(3))t(a)
end

end try
begin catch
    select concat('error:', error_message())
end catch
end
go
