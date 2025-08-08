set rowcount 5000
-- exec sp_spaceused PROG_VEHICULO
-- select*from mastertable('PROG_VEHICULO')
set language english

select*from dbo.PROG_VEHICULO order by 1



return
;with tmp001_soat as(
    select*from(select row_number()over(partition by IdVehiculo order by FecTerminoSeguro desc) item,
    IdVehiculo, NroCertificado, FecTerminoSeguro from dbo.certificado)t where item = 1
)
insert into dbo.PROG_VEHICULO(
Id_Vehiculo,Placa_Interna,Placa_Rodaje,Id_TipoRegistro,Id_TipoEstadoVehiculo,
Mes,Anio,CodRev,Id_Unidad,
Id_TipoMaestranza,Id_TipoVehiculo,Id_TipoColor,Id_TipoCombustible,Id_TipoOctanaje,
Id_TipoProcedencia,Cilindrada,Nro_Motor,Nro_Serie,Kilometraje,Id_TipoEstadoOpeVehiculo,
Id_TipoEstadoOpeOdometro,Fec_Operatividad,Id_TipoMotivoInoperatividad,Id_TipoFuncion,Id_Grifo,
Nro_Certificado,Fec_TerminoSOAT,
CIP_Conductor,Grado_Conductor,CIP_OperadorLR,Grado_OperadorLR,UsuarioI,FechaI,Activo,Estado)
select v.id_vehiculo, v.placa_interna, v.placa_rodaje, g.Id_TipoRegistro, o.Id_TipoEstadoVehiculo,
right(100 + month(dateadd(mm, 1, getdate())), 2), year(dateadd(mm, 1, getdate())), '', u.Id_Unidad,
o.Id_TipoMaestranza, v.Id_TipoVehiculo, v.Id_TipoColor, v.Id_TipoCombustible, v.Id_TipoOctanaje,
g.Id_TipoProcedencia, v.Cilindrada, v.Nro_Motor, v.Nro_Serie, null, o.Id_TipoEstadoOpeVehiculo,
isnull(o.Id_TipoEstadoOpeOdometro, 0), o.Fec_Operatividad, o.IdTipoMotivoInoperatividad, v.Id_TipoFuncion, null,
s.NroCertificado, s.FecTerminoSeguro,
m.cip, m.idGrado, m.cip, m.idGrado, 'sistemas', getdate(), 1, 1
from dbo.vehiculo v cross apply dbo.grupo_bien g cross apply dbo.operatividad_vehiculo o
cross apply dbo.asignar_vehiculo_unidad a cross apply dbo.unidad u cross apply dbo.masterPNP m
outer apply(select*from tmp001_soat s where s.IdVehiculo = v.Id_Vehiculo)s
where v.id_grupobien = g.id_grupobien and v.id_vehiculo = o.id_vehiculo and v.id_vehiculo = a.id_vehiculo
and a.Id_UnidadDestino = u.CodUni



return
-- insert into dbo.MasterPNP
select
str(CAST(RAND(CHECKSUM(NEWID())) * 900000000 + 100000000 AS BIGINT), 9, 0),
str(t.ma76, 8, 0), str(t.ma98, 8, 0),
left(ltrim(t.APEPAT), 90), left(ltrim(t.APEMAT), 90),
left(ltrim(t.NOMBRE), 90), t.ma02, left(ltrim(t.DescripcionC),90),
tt.id_unidad, tt.UltimaUnidad, 1, 'ACTIVIDAD', getdate(), getdate()
from(select row_number()over(order by (select 1))item, ma76, ma98, APEPAT, APEMAT, NOMBRE, ma02, tt.DescripcionC
from transporte.dbo.MASPOL t cross apply transporte.dbo.Tipo_Grado tt
where t.ma02 = tt.Id_TipoGrado)t cross apply
(select row_number()over(order by (select 1))item, id_unidad, UltimaUnidad
from dbo.unidad)tt
where t.item = tt.item


select (select ',', name
from dbo.mastertable('dbo.PROG_VEHICULO')
for xml path, type).value('.','varchar(max)')


-- select*from mastertable('dbo.PROG_VEHICULO')


-- select*from mastertable('dbo.VEHICULO')
-- select*from mastertable('dbo.OPERATIVIDAD_VEHICULO')
-- select*from mastertable('dbo.GRUPO_BIEN')
-- select*from mastertable('dbo.CERTIFICADO')
-- select*from mastertable('dbo.MASTERPNP')


select count(1)
from(select row_number()over(partition by placa_interna order by (select 1))item
from dbo.VEHICULO)t where item > 1
