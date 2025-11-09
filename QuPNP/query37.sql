if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_crud_generico_progRutas','p'))
drop procedure dbo.usp_crud_generico_progRutas
go
create procedure dbo.usp_crud_generico_progRutas
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
    select @data = tt.Id_ProgExtraOrd from #tmp001_claves t,
    dbo.prog_ruta tt where t.pks = tt.Id_ProgRuta
    exec dbo.usp_listar_prog_rutas @data, @pks
end

end try
begin catch
    select concat('error:', error_message())
end catch
end
go


declare @data varchar(max) =
-- '1457~32|3|2|240274|PRUEBA DE OBSERVACION DE DATOS 01|52|0|35|3|5|240267|PRUEBA DE OBSERVACION DE DATOS 04|55|0|40|3|3|228674|SALUDO|0|0|42|3|3|228674|SALUDO|0|0||3|3|239376|OLIVER PRUEBA||1|5.1|5.2|5.3|5.4|5.5|5.6|5.9|5.1|5.2|5.3|5.4|5.5|5.6|5.9|5.1|5.2|5.3|5.4|5.5|5.6|5.9|5.1|5.2|5.3|5.4|5.5|5.6|5.9|5.1|5.2|5.3|5.4|5.5|5.6|5.9'
-- '1457~3|368459|4036|DFS2|4.1|4.4|4.2|4.25^1457~35|3|5|240267|PRUEBA DE OBSERVACION DE DATOS 04|55|0|5.1|5.2|5.3|5.4|5.5|5.6|5.9'
-- '1457~3|368459|4036|HOLA|4.1|4.4|4.2|4.25^'
-- '^1457~35|3|5|240267|SOMOS LOS QUE QUEDAMOS DE DATOS 04|55|0|5.1|5.2|5.3|5.4|5.5|5.6|5.9'
-- '1457~3|368459|4036|DATA PRUEB|4.1|4.4|4.2|4.25^1457~33|3|3|240286|PRUEBA DE OBSERVACION DE DATOS 02|53|0|36|3|2|240264|ESTAMOS AQUI EN LA PRUBA|52|1|38|3|4|240257|PRUEBA DE OBSERVACION DE DATOS 03|54|0||3|4|240174|NO PASA NADA||1|5.1|5.2|5.3|5.4|5.5|5.6|5.9|5.1|5.2|5.3|5.4|5.5|5.6|5.9|5.1|5.2|5.3|5.4|5.5|5.6|5.9|5.1|5.2|5.3|5.4|5.5|5.6|5.9'


-- '1457~|357629|2316|GSH|265|1|EPB-770|PL-15336|4.1|4.4|4.2|4.7|4.8|4.3|4.6|4.5^1457~||3|150944|PRUEBA 01||1|||5|231673|PRUEBA ESTANDAR 87|1414|1|||5|231673|PRUEBA ESTANDAR 8700|1414|1|5.1|5.2|5.3|5.4|5.5|5.6|5.9|5.1|5.2|5.3|5.4|5.5|5.6|5.9|5.1|5.2|5.3|5.4|5.5|5.6|5.9'
-- '1457~|357629|2316|GSH|265|1|EPB-770|PL-15336|4.1|4.4|4.2|4.7|4.8|4.3|4.6|4.5^'
'^1457~35|3|5|240267|SOMOS LOS QUE QUEDAMOS DE DATOS 04|55|0|5.1|5.2|5.3|5.4|5.5|5.6|5.9'


exec dbo.usp_crud_generico_progRutas @data
