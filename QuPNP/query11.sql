if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_diasXmeses', 'p'))
drop procedure dbo.usp_diasXmeses
go
create procedure dbo.usp_diasXmeses
as
begin
set nocount on
set ansi_warnings off
set language english

select distinct dias, dias - count(fecha)over() habiles
from(select dias,
case datepart(dw, fecha_correlativa) when 7 then fecha_correlativa else f.fecha end fecha
from(select dateadd(dd, item, inicio) fecha_correlativa, inicio, final, dias
from(select inicio, final, stuff(convert(varchar, final, 112),1,6,'') dias,
row_number()over(order by (select 1)) - 1 item
from(select inicio, dateadd(dd, -1, dateadd(mm, 1, inicio)) final
from(select cast(concat(convert(varchar(6), dateadd(mm, 1, getdate()), 112),'01') as date) inicio)t)t
cross apply sys.fn_helpcollations())t where item < dias)t
outer apply(select f.fecha from dbo.dias_feriados f where f.fecha = t.fecha_correlativa)f)t

set ansi_warnings on
end
go



go
if exists(select 1 from sys.sysobjects where id=object_id('dbo.udf_dotacionPolicia', 'if'))
drop function dbo.udf_dotacionPolicia
go
create function dbo.udf_dotacionPolicia(
@Id_TipoCombustible varchar(5),
@cilindrada int,
@id_tipoFuncion int,
@dias tinyint,
@habiles tinyint
)returns table as return(
    select Id_TipoDotacionGD, RendimientoxGln,
    case Id_TipoFuncion when 1 then @habiles else @dias end * isnull(try_cast(RendimientoxGln as numeric(5,2)), 0) galMes
    from dbo.tipo_dotacion_gd where rtrim(Id_TipoCombustible) = @Id_TipoCombustible
    and Id_TipoFuncion = @id_tipoFuncion
    and @cilindrada between parsename(Rango_Cilindrada, 2) and parsename(Rango_Cilindrada, 1)
    and Activo = 1 and Estado = 1
)
go


go
if exists(select 1 from sys.sysobjects where id=object_id('dbo.udf_dotacionComando', 'if'))
drop function dbo.udf_dotacionComando
go
create function dbo.udf_dotacionComando(
@Grado_Conductor int,
@dias int
)returns table as return(
    select Id_ServicioVehiculoLR, dotacionDiaria, isnull(try_cast(dotacionDiaria as numeric(5,2)), 0) * @dias galMes
    from dbo.SERVICIO_VEHICULO_LR
    where id_tipoGrado = @Grado_Conductor and Activo = 1 and Estado = 1
)
go


return
select*from dbo.tipo_grado
select*from dbo.Mae_UBIGEO
select*from transporte.dbo.TIPO_SITUACION_POLICIAL



-- select isnull(t1.saludo, t2.saludo) dato, t.* from(
-- select top 5 *from dbo.PROG_VEHICULO where Id_TipoRegistro = 1
-- union all
-- select top 5 *from dbo.PROG_VEHICULO where Id_TipoRegistro = 2
-- )t
-- outer apply(select*from dbo.udf_prueba1() where t.Id_TipoRegistro = 1)t1
-- outer apply(select*from dbo.udf_prueba2() where t.Id_TipoRegistro = 2)t2


-- create function dbo.udf_prueba1()returns table as return(select 'primera prueba' saludo)
-- go
-- create function dbo.udf_prueba2()returns table as return(select 'segunda prueba' saludo)

-- select distinct Id_TipoRegistro  from dbo.PROG_VEHICULO
