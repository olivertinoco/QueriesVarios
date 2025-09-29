if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_poblarTablasDotacionComb', 'p'))
drop procedure dbo.usp_poblarTablasDotacionComb
go
create procedure dbo.usp_poblarTablasDotacionComb
@data varchar(25)
as
begin
set nocount on
set language english
begin try
declare @pos int
select top 0 cast(null as int) codigo into #tmp001_salida
select top 0 cast(null as int) codigo into #tmp002_salida
select @pos = case charindex('|', @data) when 0 then 0 else -1 end
if (@pos = -1) select @data = substring(@data, 1, charindex('|', @data) -1)

;with tmp001_periodo(mes, anno) as(
    select right(100 + month(dateadd(mm, @pos, getdate())), 2), year(dateadd(mm, @pos, getdate()))
)
,tmp001_periodo_anterior(mes, anno) as(
    select right(100 + month(dateadd(mm, @pos -1, getdate())), 2), year(dateadd(mm, @pos -1, getdate()))
)
,tmp001_dato_grifo as(
    select distinct
    Id_Vehiculo, Id_Grifo from dbo.PROG_VEHICULO t, tmp001_periodo_anterior p
    where t.Anio = p.anno and t.mes = p.mes
)
insert into dbo.PROG_VEHICULO(
Id_ProgLR, Id_Vehiculo, Anio, Mes, Placa_Interna, Placa_Rodaje, Id_Unidad, Id_TipoRegistro,
Id_TipoEstadoVehiculo, Id_TipoMaestranza, Id_TipoVehiculo, Id_TipoColor, Id_TipoCombustible, Id_TipoOctanaje,
Id_TipoProcedencia, Cilindrada, Nro_Motor, Nro_Serie,
Id_TipoEstadoOpeVehiculo, Id_TipoEstadoOpeOdometro, Fec_Operatividad, Kilometraje, Id_TipoMotivoInoperatividad,
Id_TipoFuncion, Id_Grifo, Id_Certificado, Fec_TerminoSOAT, CIP_Conductor,
Grado_Conductor, CIP_OficialLR, Grado_OficialLR, Flag, UsuarioI, FechaI, Activo, Estado)
output inserted.Id_ProgLR into #tmp001_salida
select
o.IdOperatividad, v.id_vehiculo, o.Ano, o.Mes, v.placa_interna, v.placa_rodaje, o.IdUnidadOperativdad, o.FlatAfectacion,
oo.Id_TipoEstadoVehiculo, oo.Id_TipoMaestranza, v.Id_TipoVehiculo, v.Id_TipoColor, left(v.Id_TipoCombustible,5), v.Id_TipoOctanaje,
g.Id_TipoProcedencia, left(v.Cilindrada,5), left(v.Nro_Motor,30), left(v.Nro_Serie,35),
isnull(o.IdTipoEstadoOpeVehiculo,''), isnull(o.IdTipoEstadoOpeOdometro, 0), o.FchOperativida, o.Kilometraje, oo.IdTipoMotivoInoperatividad,
v.Id_TipoFuncion, gr.Id_Grifo, o.IdCertificado, o.FcterminoSoat, o.CipConductor,
isnull(m1.IdGrado,''), isnull(o.CipAfectado, ''), isnull(m2.IdGrado,''),  1, @data, getdate(), 1, 1
from dbo.OPERATIVIDAD o cross apply dbo.vehiculo v cross apply tmp001_periodo p
outer apply(select*from dbo.grupo_bien g where g.id_grupobien = v.id_grupobien)g
outer apply(select*from dbo.operatividad_vehiculo oo where oo.id_vehiculo = v.id_vehiculo)oo
outer apply(select*from dbo.masterPNP m1 where m1.cip = o.CipConductor and isnull(o.CipConductor, '') != '')m1
outer apply(select*from dbo.masterPNP m2 where m2.cip = o.CipAfectado and isnull(o.CipAfectado, '') != '')m2
outer apply(select*from tmp001_dato_grifo gr where gr.Id_Vehiculo = o.IdVehiculo)gr
where o.Ano = p.anno and o.Mes = cast(p.mes as int) and o.estado = 1
and o.IdVehiculo = v.id_vehiculo and o.PlacaInterna = v.Placa_Interna

update tt set tt.estado = 2, tt.UsuarioComb = @data, tt.FchaRegComb = getdate()
from #tmp001_salida t, dbo.OPERATIVIDAD tt where t.codigo = tt.IdOperatividad


select top 0
cast(null as tinyint) dias,
cast(null as tinyint) habiles into #tmp001_dias
insert into #tmp001_dias exec dbo.usp_diasXmeses

;with tmp001_periodo(mes, anno) as(
    select right(100 + month(dateadd(mm, @pos, getdate())), 2), year(dateadd(mm, @pos, getdate()))
)
insert into dbo.PROG_DOTACION(
Id_ProgVehiculo,Id_Vehiculo,Placa_Interna,Id_ServicioVehiculoLR,Id_TipoDiasMes,Id_TipoDotacionGD,
GlnxDia,GlnxMes,Observacion,UsuarioI,FechaI,Activo,Estado)
output inserted.Id_ProgVehiculo into #tmp002_salida
select
t.Id_ProgVehiculo, t.Id_Vehiculo, t.Placa_Interna, c.Id_ServicioVehiculoLR, null,
p.Id_TipoDotacionGD,
coalesce(p.RendimientoxGln, c.dotacionDiaria, ''), coalesce(p.galMes, c.galMes, 0), null, @data, getdate(), 1, 1
from dbo.PROG_VEHICULO t cross apply tmp001_periodo p cross apply #tmp001_dias d
outer apply(select*from
dbo.udf_dotacionPolicia(isnull(nullif(rtrim(t.Id_TipoCombustible),'GSL'),'GSH'), t.cilindrada, t.id_tipoFuncion, d.dias, d.habiles)
where t.id_tipoRegistro = 1)p
outer apply(select*from dbo.udf_dotacionComando(t.Grado_Conductor, d.dias)
where t.id_tipoRegistro = 2)c
where t.Anio = p.anno and t.mes = p.mes and t.flag_entrega = 0 and t.id_tipoFuncion != 7
order by t.id_tipoFuncion

update tt set tt.flag_entrega = 1, tt.UsuarioI = @data, tt.FechaI = getdate()
from #tmp002_salida t, dbo.PROG_VEHICULO tt where t.codigo = tt.Id_ProgVehiculo

end try
begin catch
    select concat('error: ', error_message())
end catch
end
go
