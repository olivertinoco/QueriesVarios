if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_listaOperatividadVehiculo', 'p'))
drop procedure dbo.usp_listaOperatividadVehiculo
go
create procedure dbo.usp_listaOperatividadVehiculo
as
begin
set nocount on
set language english

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~','^'))t(sepCampo,sepReg,sepLst)
)
,tmp001_cab(cab)as(
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
    select right(100 + month(dateadd(mm, 0, getdate())), 2), year(dateadd(mm, 1, getdate()))
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
select concat(c.cab, (select r,
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
where o.Ano = p.anno and o.Mes = cast(p.mes as int) and o.estado = 1
and o.IdVehiculo = v.id_vehiculo and o.PlacaInterna = v.Placa_Interna
for xml path, type).value('.','varchar(max)'),
t1.data, t2.data, t3.data
)
from tmp001_sep, tmp001_cab c,
tmp001_tipo_funcion t1,
tmp001_tipo_registro t2,
tmp001_tipo_vehiculo t3

end
go

exec dbo.usp_listaOperatividadVehiculo



-- alter table dbo.PROG_VEHICULO add flag_entrega bit not null default(0)
-- select*from mastertable('dbo.PROG_VEHICULO')


return

-- select*from mastertable('dbo.ASIGNAR_VEHICULO_UNIDAD')
-- select*from mastertable('dbo.OPERATIVIDAD_VEHICULO')
-- select*from mastertable('dbo.masterLicencia')

-- select*from mastertable('dbo.OPERATIVIDAD')
-- select*from mastertable('dbo.PROG_VEHICULO')
-- select*from mastertable('dbo.VEHICULO')
-- select*from mastertable('dbo.PROG_DOTACION')

set rowcount 20

select*from dbo.masterPNP
select*from dbo.masterLicencia

-- select*from dbo.OPERATIVIDAD
-- select*from dbo.PROG_VEHICULO
-- select*from dbo.PROG_DOTACION


select t.Id_UnidadDestino, tt.UltimaUnidad
from(select distinct Id_UnidadDestino from dbo.ASIGNAR_VEHICULO_UNIDAD)t
outer apply(select*from dbo.unidad tt where tt.id_unidad = t.Id_UnidadDestino)tt
where exists(
select distinct id_vehiculo from dbo.OPERATIVIDAD_VEHICULO o,
(values(2),(3),(4),(5),(19))t(Id_TipoEstadoOpeVehiculo)
where o.Id_TipoEstadoOpeVehiculo != t.Id_TipoEstadoOpeVehiculo)
