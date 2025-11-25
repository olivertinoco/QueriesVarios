if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_generico_grabar_tarjeta_multiflota','p'))
drop procedure dbo.usp_generico_grabar_tarjeta_multiflota
go
create procedure dbo.usp_generico_grabar_tarjeta_multiflota
@data varchar(max)
as
begin
begin try
set nocount on
set language english
declare @Utabla tabla_generico
declare @flag char(1), @dato int,
@tempGlob varchar(200) = replace(convert(varchar(36), newid()), '-','_')
select top 0 cast(null as int) id_multiflota into #tmp001_salida

insert into @Utabla
exec dbo.usp_listar_tablas 'dbo.PROG_TARJETA_MULTIFLOTA'

select @dato = dato, @flag = flag from dbo.udf_duplicado_tarjeta_multiflota(@data, @Utabla)
if (@dato = 1)
begin
    if (@flag = 'D') select 'duplicado' dato
    if (@flag = 'E') select 'existe' dato
    return
end

exec dbo.usp_crud_generico01 @data, @tempGlob

insert into #tmp001_salida
exec('select*from ##tmp001_salida' + @tempGlob)

;with tmp001_sep(t,r,i,a)as(
    select*from(values('|','~','^','*'))t(sepCampo,sepReg,sepLst,sepAux)
)
,tmp001_vehiculo as(
    select t.id_vehiculo veh, t.id_multiflota id
    from dbo.PROG_TARJETA_MULTIFLOTA t, #tmp001_salida tt
    where t.id_multiflota = tt.id_multiflota
)
,tmp001_cab(dato)as(
    select 'NRO TARJETA|FECHA ACTIVACION|FECHA CANCELACION|ESTADO~400|200|200|200'
)
select concat(v.id, i, c.dato, (select r, Nro_Tarjeta, t,
convert(varchar, Fec_Activacion, 23), t,
convert(varchar, case when Fec_Cancelacion != cast('' as date) then Fec_Cancelacion end, 23), t,
case activo when 1 then 'Act' else 'Desc' end
from dbo.PROG_TARJETA_MULTIFLOTA where Id_Vehiculo = v.veh
order by Id_Multiflota desc
for xml path, type).value('.', 'varchar(max)'))
from tmp001_sep, tmp001_vehiculo v, tmp001_cab c

end try
begin catch
    select concat('error:', error_message())
end catch
end
go





declare @data varchar(max)
-- ='1457~350352||PRUEBA-KS-SS|2025-11-19|1|PL-10543|EPA-514|7.2|7.1|7.5|7.6|7.8|7.3|7.4'
='1457~350352|13|2025-11-19|0|7.2|7.1|7.7|7.8'
-- ='1457~350352|13||1|7.2|7.1|7.7|7.8'

exec dbo.usp_generico_grabar_tarjeta_multiflota @data


-- select*from dbo.PROG_TARJETA_MULTIFLOTA
