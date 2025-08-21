if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_listaDotacionCombustible', 'p'))
drop procedure dbo.usp_listaDotacionCombustible
go
create procedure dbo.usp_listaDotacionCombustible
as
begin
set nocount on
set language english

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~','^'))t(sepCampo,sepReg,sepLst)
)
,tmp001_cab as(
    select 'Id Dotacion|Id Prog Veh|Id Vehiculo|Placa Interna|Id SerVehLR|\
Id TipoDotGD|GlnxDia|GlnxMes|Observacion~100|100|100|100|100|100|100|100|100' cab
)
,tmp002_cab as(
    select cab =
'a|b|c|Id_Prog|Id_Vehi|Placa_Interna|Placa_Rodaje|TipoRegistro|Est Vehiculo|Mes|Anio|\
CodRev|Unidad|Maestranza|TipoVehiculo|TipoColor|TipoCombustible|TipoOctanaje|\
TipoProcedencia|Cilindrada|Nro Motor|Serie|Kilometraje|EstadoOpe|EstadoOdometro|\
Fec_Operatividad|Mot. Inopera|TipoFuncion|Grifo|Certificado|Fec_TerminoSOAT|\
CIP_Conductor|Grado_Conductor|CIP_OperadorLR|Grado_OperadorLR~\
5|5|5|100|150|150|150|150|100|100|100|100|100|100|100|100|100|100|100|100|\
100|100|100|100|100|100|100|100|100|100|100|100|100|100|100'
)
,tmp001_tipo_funcion(data) as(
    select stuff((select r, Id_TipoFuncion, t, DescripcionL from dbo.tipo_funcion where estado = 1 and activo = 1
    order by DescripcionL
    for xml path, type).value('.','varchar(max)'),1,1,i)
    from tmp001_sep
)
,tmp001_tipo_registro(data) as(
    select stuff((select r, Id_TipoRegistro, t, DescripcionL from dbo.tipo_registro where estado = 1 and activo = 1
    order by DescripcionL
    for xml path, type).value('.','varchar(max)'),1,1,i)
    from tmp001_sep
)
,tmp001_tipo_vehiculo(data) as(
    select stuff((select r, Id_TipoVehiculo, t, DescripcionL from dbo.tipo_vehiculo
    where estado = 1 and activo = 1 and Id_TipoVehiculo != 0
    order by DescripcionL
    for xml path, type).value('.','varchar(max)'),1,1,i)
    from tmp001_sep
)
,tmp001_prog_dotacion(data) as(
    select concat(cab, (select r,
    Id_ProgDotacion, t, Id_ProgVehiculo, t, Id_Vehiculo, t, Placa_Interna, t,
    isnull(convert(varchar, Id_ServicioVehiculoLR),'-'), t,
    isnull(convert(varchar,Id_TipoDotacionGD), '-'), t,
    isnull(nullif(concat(try_cast(GlnxDia as numeric(5,2)), iif(GlnxDia = '', '-', ' gal')),'0.00 gal'), '-'), t,
    isnull(nullif(concat(convert(varchar, GlnxMes), ' gal'),'0.00 gal'), '-'),  t, isnull(Observacion, '-')
    from dbo.PROG_DOTACION order by Id_Vehiculo
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep, tmp001_cab
)
,tmp001_prog_vehiculo(data) as(
    select concat(i, cab, (select r,
    t.Id_TipoRegistro, t, t.Id_TipoFuncion, t, t.Id_TipoVehiculo, t,
    Id_ProgVehiculo, t, Id_Vehiculo, t, Placa_Interna, t,
    Placa_Rodaje, t, tr.DescripcionL, t, isnull(te.DescripcionL, '-'), t, Mes, t, Anio, t, CodRev, t,
    Id_Unidad, t, isnull(tm.DescripcionL, '-'), t, isnull(tv.DescripcionL, '-'), t,
    isnull(tc.DescripcionL, '-'), t, isnull(tco.DescripcionL, '-'), t, isnull(toc.DescripcionL, '-'), t,
    isnull(tp.DescripcionL, '-'), t, Cilindrada, t, Nro_Motor, t, Nro_Serie, t, isnull(Kilometraje, '-'), t,
    isnull(tope.DescripcionL, '-'), t, isnull(odo.DescripcionL, '-'), t, convert(varchar, Fec_Operatividad, 23), t,
    isnull(tino.DescripcionL, '-'), t, isnull(fn.DescripcionL, '-'), t, isnull(Id_Grifo,'-'), t, Nro_Certificado, t,
    convert(varchar, Fec_TerminoSOAT, 23), t, CIP_Conductor, t, isnull(tg.DescripcionL, '-'), t,
    CIP_OperadorLR, t, Grado_OperadorLR
    from dbo.PROG_VEHICULO t cross apply tipo_registro tr cross apply dbo.tipo_funcion fn
    outer apply(select*from dbo.tipo_estado_vehiculo te where te.Id_TipoEstadoVehiculo = t.Id_TipoEstadoVehiculo )te
    outer apply(select*from dbo.tipo_maestranza tm where tm.Id_TipoMaestranza = t.Id_TipoMaestranza)tm
    outer apply(select*from dbo.tipo_vehiculo tv where tv.Id_TipoVehiculo = t.Id_TipoVehiculo)tv
    outer apply(select*from dbo.tipo_color tc where tc.Id_TipoColor = t.Id_TipoColor)tc
    outer apply(select*from dbo.tipo_combustible tco where tco.Id_TipoCombustible = t.Id_TipoCombustible)tco
    outer apply(select*from dbo.tipo_octanaje toc where toc.Id_TipoOctanaje = t.Id_TipoOctanaje)toc
    outer apply(select*from dbo.tipo_procedencia tp where tp.Id_TipoProcedencia = t.Id_TipoProcedencia)tp
    outer apply(select*from dbo.tipo_estado_operatividad tope where tope.Id_TipoEstadoOperatividad = t.Id_TipoEstadoOpeVehiculo)tope
    outer apply(select*from dbo.tipo_estado_op_odometro odo where odo.IdEstadoOperatividadOdometro = t.Id_TipoEstadoOpeOdometro)odo
    outer apply(select*from dbo.tipo_inoperatividad tino where tino.Id_TipoInoperatividad = t.Id_TipoMotivoInoperatividad)tino
    outer apply(select*from dbo.tipo_grado tg where tg.Id_TipoGrado = t.Grado_Conductor)tg
    where t.id_tipoFuncion != 7 and t.Id_TipoRegistro = tr.Id_TipoRegistro and t.Id_TipoFuncion = fn.Id_TipoFuncion
    order by t.Id_Vehiculo
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep, tmp002_cab
)
select concat(t.data, tt.data, ttt.data, tttt.data, ttttt.data) data
from tmp001_prog_dotacion t, tmp001_prog_vehiculo tt, tmp001_tipo_funcion ttt,
tmp001_tipo_registro tttt, tmp001_tipo_vehiculo ttttt

end
go

exec dbo.usp_listaDotacionCombustible




-- declare @data varchar(max)=(
-- select(select '|', name
-- from dbo.mastertable('dbo.PROG_DOTACION')
-- order by column_id
-- for xml path, type).value('.','varchar(max)'))
-- select(@data)



-- declare @data varchar(max)=(
-- select(select ', t, ', name
-- from dbo.mastertable('dbo.PROG_VEHICULO')
-- order by column_id
-- for xml path, type).value('.','varchar(max)'))
-- select(@data)
