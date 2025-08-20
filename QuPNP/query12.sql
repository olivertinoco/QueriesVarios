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
Id TipoDotGD|GlnxDia|GlnxMes|Observacion|Usuario|Fech Ingreso|Activo|Estado~\
100|100|100|100|100|100|100|100|100|100|100|100|100' cab
)
,tmp002_cab as(
    select cab =
'Id_Prog|Id_Vehi|Placa_Interna|Placa_Rodaje|Id_TipoRegistro|Id_TipoEstadoVehiculo|Mes|Anio|\
CodRev|Id_Unidad|Id_TipoMaestranza|Id_TipoVehiculo|Id_TipoColor|Id_TipoCombustible|Id_TipoOctanaje|\
Id_TipoProcedencia|Cilindrada|Nro_Motor|Nro_Serie|Kilometraje|Id_TipoEstadoOpeVehiculo|Id_TipoEstadoOpeOdometro|\
Fec_Operatividad|Id_TipoMotivoInoperatividad|Id_TipoFuncion|Id_Grifo|Nro_Certificado|Fec_TerminoSOAT|\
CIP_Conductor|Grado_Conductor|CIP_OperadorLR|Grado_OperadorLR~\
100|150|150|150|150|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100'
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
    Id_ProgDotacion, t, Id_ProgVehiculo, t, Id_Vehiculo, t, Placa_Interna, t, Id_ServicioVehiculoLR, t,
    Id_TipoDotacionGD, t, GlnxDia, t, GlnxMes, t, Observacion, t, UsuarioI, t, convert(varchar, FechaI, 23), t,
    Activo, t, Estado
    from dbo.PROG_DOTACION
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep, tmp001_cab
)
,tmp001_prog_vehiculo(data) as(
    select concat(i, cab, (select r,
    Id_ProgVehiculo, t, Id_Vehiculo, t, Placa_Interna, t, Placa_Rodaje, t, Id_TipoRegistro, t, Id_TipoEstadoVehiculo, t,
    Mes, t, Anio, t, CodRev, t, Id_Unidad, t, Id_TipoMaestranza, t, Id_TipoVehiculo, t, Id_TipoColor, t,
    Id_TipoCombustible, t, Id_TipoOctanaje, t, Id_TipoProcedencia, t, Cilindrada, t, Nro_Motor, t, Nro_Serie, t,
    Kilometraje, t, Id_TipoEstadoOpeVehiculo, t, Id_TipoEstadoOpeOdometro, t, convert(varchar, Fec_Operatividad, 23), t,
    Id_TipoMotivoInoperatividad, t, Id_TipoFuncion, t, Id_Grifo, t, Nro_Certificado, t, convert(varchar, Fec_TerminoSOAT, 23), t,
    CIP_Conductor, t, Grado_Conductor, t, CIP_OperadorLR, t, Grado_OperadorLR
    from dbo.PROG_VEHICULO
    where id_tipoFuncion != 7
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
