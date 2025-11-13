if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_crud_generico_prog_eo_grifo','p'))
drop procedure dbo.usp_crud_generico_prog_eo_grifo
go
create procedure dbo.usp_crud_generico_prog_eo_grifo
@data varchar(max)
as
begin
begin try
set nocount on
set language english

declare @pks varchar(100), @flag int = 0,
@tempGlob varchar(200) = replace(convert(varchar(36), newid()), '-','_')
select top 0 cast(null as int) flag into #tmp001_flag
select top 0 cast(null as varchar(100)) collate database_default pks into #tmp001_claves
select top 0 cast(null as varchar(100)) collate database_default pks into #tmp001_clavesHead

exec dbo.usp_crud_generico02_data @data, @tempGlob

if exists(select 1 from #tmp001_flag where flag = 1)begin
    select @pks = pks from #tmp001_clavesHead
    exec ('insert into #tmp001_claves select*from ##tmp001_salida' + @tempGlob)
    select @flag = 1
end
if exists(select 1 from #tmp001_flag where flag = 2)begin
    exec ('select*from ##tmp001_salida' + @tempGlob)
end
if exists(select 1 from #tmp001_flag where flag = 3)begin
    select @pks = ''
    exec ('insert into #tmp001_claves select*from ##tmp001_salida' + @tempGlob)
    select @flag = 1
end
if(@flag = 1)begin
    declare @Utabla22 tabla_generico
    insert into @Utabla22
    exec dbo.usp_listar_tablas 'dbo.prog_eo_grifo'

    select @data = tt.Id_ProgExtraOrd
    from(select tt.Id_ProgRuta
    from #tmp001_claves t, dbo.prog_eo_grifo tt where t.pks = tt.Id_EOGrifos)t,
    dbo.prog_ruta tt where t.Id_ProgRuta = tt.Id_ProgRuta
    select stuff(dato, 1, 1, '') from dbo.udf_detalle_prog_eo_grifo(@data, @Utabla22)
end

end try
begin catch
    select concat('error:', error_message())
end catch
end
go


declare @data varchar(max) =
'^1457~4|33|239|2025-10-11|MAR|1||33|104||222|1||33|189||458|1|6.1|6.2|6.3|6.4|6.5|6.10|6.1|6.2|6.3|6.4|6.5|6.10|6.1|6.2|6.3|6.4|6.5|6.10'
-- '^1457~13|33|104|1900-01-01T00:00:00|222|0|14|33|189|1900-01-01T00:00:00|458|0|15|33|104|1900-01-01T00:00:00|222|0|17|33|104|1900-01-01T00:00:00|222|0|18|33|189|1900-01-01T00:00:00|458|0|19|33|104|1900-01-01T00:00:00|222|0|6.1|6.2|6.3|6.4|6.5|6.10|6.1|6.2|6.3|6.4|6.5|6.10|6.1|6.2|6.3|6.4|6.5|6.10|6.1|6.2|6.3|6.4|6.5|6.10|6.1|6.2|6.3|6.4|6.5|6.10|6.1|6.2|6.3|6.4|6.5|6.10'


exec dbo.usp_crud_generico_prog_eo_grifo @data

select*from dbo.prog_eo_grifo
