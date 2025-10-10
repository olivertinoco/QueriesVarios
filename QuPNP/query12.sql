if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_listaDotacionCombustible', 'p'))
drop procedure dbo.usp_listaDotacionCombustible
go
create procedure dbo.usp_listaDotacionCombustible
as
begin
set nocount on
set language english
declare @periodo_intervalo int = -1

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~','^'))t(sepCampo,sepReg,sepLst)
)
,tmp001_cab(cab) as(
    select 'Id Dotacion|Id Prog Veh|Id Vehiculo|Placa Interna|Id SerVehLR|\
Id TipoDotGD|GlnxDia|GlnxMes|Observacion~100|100|100|100|100|100|100|100|100'
)
,tmp002_cab(cab) as(
    select
'a|b|c|Id_Prog|Id_Vehi|Placa_Interna|Placa_Rodaje|TipoRegistro|Est Vehiculo|Anio|Mes|\
Unidad|Maestranza|TipoVehiculo|TipoColor|TipoCombustible|TipoOctanaje|\
TipoProcedencia|Cilindrada|Nro Motor|Serie|Kilometraje|EstadoOpe|EstadoOdometro|\
Fec_Operatividad|Mot. Inopera|TipoFuncion|Grifo|Certificado|Fec_TerminoSOAT|\
CIP_Conductor|Grado_Conductor|CIP_OperadorLR|Grado_OperadorLR~\
5|5|5|100|150|150|150|150|100|100|100|100|100|100|100|100|100|100|100|100|\
100|100|100|100|100|100|100|100|100|100|100|100|100|100|100'
)
,tmp003_cab(cab)as(
select concat('idOp|anno|mes|vehiculo|placa int|placa rod|\
desc Registro|desc est veh|desc maestranza|desc tipo veh|\
desc color|desc combustible|desc octanaje|desc proceden|\
cilindrada|motor|serie|desc operatividad|\
desc odometro|fech operatividad|Kilometraje|desc inoperatividad|\
desc funcion|certificado|fech term SOAT|cip conductor|\
desc grado cond|cip afectado|desc grado afect|unidad', r,
'100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|100|1000')
from tmp001_sep
)
,tmp001_periodo(mes, anno) as(
    select right(100 + month(dateadd(mm, @periodo_intervalo, getdate())), 2), year(dateadd(mm, @periodo_intervalo, getdate()))
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
,tmp001_id_prog_vehiculo(id) as(
    select t.Id_ProgVehiculo from dbo.PROG_VEHICULO t cross apply dbo.tipo_registro tr
    cross apply dbo.tipo_funcion fn cross apply tmp001_periodo pp
    where t.Anio = pp.anno and t.mes = pp.mes and t.flag_entrega = 1 and
    t.id_tipoFuncion != 7 and t.Id_TipoRegistro = tr.Id_TipoRegistro and t.Id_TipoFuncion = fn.Id_TipoFuncion
)
,tmp001_prog_dotacion(data) as(
    select concat(cab, (select r,
    Id_ProgDotacion, t, Id_ProgVehiculo, t, Id_Vehiculo, t, Placa_Interna, t,
    isnull(convert(varchar, Id_ServicioVehiculoLR),'-'), t,
    isnull(convert(varchar,Id_TipoDotacionGD), '-'), t,
    isnull(nullif(concat(try_cast(GlnxDia as numeric(5,2)), iif(GlnxDia = '', '-', ' gal')),'0.00 gal'), '-'), t,
    isnull(nullif(concat(convert(varchar, GlnxMes), ' gal'),'0.00 gal'), '-'),  t, isnull(Observacion, '-')
    from dbo.PROG_DOTACION t, tmp001_id_prog_vehiculo tt
    where t.Id_ProgVehiculo = tt.id
    order by t.Id_Vehiculo
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep, tmp001_cab
)
,tmp001_prog_vehiculo(data) as(
    select concat(i, cab, (select r,
    t.Id_TipoRegistro, t, t.Id_TipoFuncion, t, t.Id_TipoVehiculo, t,
    Id_ProgVehiculo, t, Id_Vehiculo, t, Placa_Interna, t,
    Placa_Rodaje, t, tr.DescripcionL, t, isnull(te.DescripcionL, '-'), t, t.Anio, t, t.Mes, t,
    Id_Unidad, t, isnull(tm.DescripcionL, '-'), t, isnull(tv.DescripcionL, '-'), t,
    isnull(tc.DescripcionL, '-'), t, isnull(tco.DescripcionL, '-'), t, isnull(toc.DescripcionL, '-'), t,
    isnull(tp.DescripcionL, '-'), t, Cilindrada, t, Nro_Motor, t, Nro_Serie, t, isnull(Kilometraje, '-'), t,
    isnull(tope.DescripcionL, '-'), t, isnull(odo.DescripcionL, '-'), t, convert(varchar, Fec_Operatividad, 23), t,
    isnull(tino.DescripcionL, '-'), t, isnull(fn.DescripcionL, '-'), t, isnull(gr.NombreGrifo,'-'), t, cer.NroCertificado, t,
    convert(varchar, Fec_TerminoSOAT, 23), t, CIP_Conductor, t, isnull(tg.DescripcionL, '-'), t,
    CIP_OficialLR, t, Grado_OficialLR
    from dbo.PROG_VEHICULO t cross apply tipo_registro tr cross apply dbo.tipo_funcion fn
    cross apply tmp001_periodo pp
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
    outer apply(select*from dbo.certificado cer where cer.IdCertificado = t.Id_Certificado and cer.IdVehiculo = t.Id_Vehiculo)cer
    outer apply(select*from dbo.grifo gr where gr.id_grifo = t.Id_Grifo)gr
    where t.Anio = pp.anno and t.mes = pp.mes and t.flag_entrega = 1 and
    t.id_tipoFuncion != 7 and t.Id_TipoRegistro = tr.Id_TipoRegistro and t.Id_TipoFuncion = fn.Id_TipoFuncion
    order by t.Id_Vehiculo
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep, tmp002_cab
)
,tmp001_operatividad(data) as(
    select concat(i, cab, (select r,
    o.IdOperatividad, t, o.Ano, t, o.Mes, t, v.id_vehiculo, t, v.placa_interna, t, v.placa_rodaje, t,
    rtrim(reg.DescripcionL), t, rtrim(te.DescripcionL), t, rtrim(tm.DescripcionL), t, rtrim(tv.DescripcionL), t,
    rtrim(tc.DescripcionL), t, left(tco.DescripcionL,5), t, rtrim(toc.DescripcionL), t, rtrim(tp.DescripcionL), t,
    left(v.Cilindrada,5), t, left(v.Nro_Motor,30), t, left(v.Nro_Serie,35), t, rtrim(tope.DescripcionL), t,
    rtrim(odo.DescripcionL), t, convert(varchar, o.FchOperativida, 23), t, o.Kilometraje, t, rtrim(tino.DescripcionL), t,
    rtrim(tf.DescripcionL), t, o.IdCertificado, t, convert(varchar, o.FcterminoSoat, 23), t, o.CipConductor, t,
    rtrim(tg1.DescripcionL), t, o.CipAfectado, t, rtrim(tg2.DescripcionL), t, u.UltimaUnidad
    from dbo.OPERATIVIDAD o cross apply dbo.vehiculo v cross apply tmp001_periodo p
    outer apply(select*from dbo.grupo_bien g where g.id_grupobien = v.id_grupobien)g
    outer apply(select*from dbo.operatividad_vehiculo oo where oo.id_vehiculo = v.id_vehiculo)oo
    outer apply(select*from dbo.masterPNP m1 where m1.cip = o.CipConductor and isnull(o.CipConductor, '') != '')m1
    outer apply(select*from dbo.masterPNP m2 where m2.cip = o.CipAfectado and isnull(o.CipAfectado, '') != '')m2
    outer apply(select*from dbo.unidad u where u.id_unidad = o.IdUnidadOperativdad)u
    outer apply(select*from dbo.tipo_registro reg where reg.Id_TipoRegistro = o.FlatAfectacion)reg
    outer apply(select*from dbo.tipo_estado_vehiculo te where te.Id_TipoEstadoVehiculo = oo.Id_TipoEstadoVehiculo )te
    outer apply(select*from dbo.tipo_maestranza tm where tm.Id_TipoMaestranza = oo.Id_TipoMaestranza)tm
    outer apply(select*from dbo.tipo_vehiculo tv where tv.Id_TipoVehiculo = v.Id_TipoVehiculo)tv
    outer apply(select*from dbo.tipo_color tc where tc.Id_TipoColor = v.Id_TipoColor)tc
    outer apply(select*from dbo.tipo_combustible tco where tco.Id_TipoCombustible = v.Id_TipoCombustible)tco
    outer apply(select*from dbo.tipo_octanaje toc where toc.Id_TipoOctanaje = v.Id_TipoOctanaje)toc
    outer apply(select*from dbo.tipo_procedencia tp where tp.Id_TipoProcedencia = g.Id_TipoProcedencia)tp
    outer apply(select*from dbo.tipo_estado_operatividad tope where tope.Id_TipoEstadoOperatividad = o.IdTipoEstadoOpeVehiculo)tope
    outer apply(select*from dbo.tipo_estado_op_odometro odo where odo.IdEstadoOperatividadOdometro = o.IdTipoEstadoOpeOdometro)odo
    outer apply(select*from dbo.tipo_inoperatividad tino where tino.Id_TipoInoperatividad = oo.IdTipoMotivoInoperatividad)tino
    outer apply(select*from dbo.tipo_funcion tf where tf.Id_TipoFuncion = v.Id_TipoFuncion)tf
    outer apply(select*from dbo.tipo_grado tg1 where tg1.Id_TipoGrado = m1.IdGrado)tg1
    outer apply(select*from dbo.tipo_grado tg2 where tg2.Id_TipoGrado = m2.IdGrado)tg2
    -- where o.Ano = p.anno and o.Mes = cast(p.mes as int)
    where o.Ano = p.anno and o.Mes = cast(p.mes as int) + 1
    and o.estado = 1 and o.IdVehiculo = v.id_vehiculo and o.PlacaInterna = v.Placa_Interna
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep, tmp003_cab
)
select concat(t.data, tt.data, o.data, ttt.data, tttt.data, ttttt.data) data
from tmp001_prog_dotacion t,
tmp001_prog_vehiculo tt,
tmp001_operatividad o,
tmp001_tipo_funcion ttt,
tmp001_tipo_registro tttt,
tmp001_tipo_vehiculo ttttt

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

return
select id_grifo, Nro_RUC, NombreGrifo, direccion, Id_Ubigeo, Latitud_Longitud
from dbo.grifo
where activo = 1 and estado = 1
order by nro_ruc
