set rowcount 150

set language english

-- select*from dbo.PROG_VEHICULO
select*from dbo.SERVICIO_VEHICULO_LR
select*from dbo.tipo_dotacion_gd order by Id_TipoFuncion
select*from dbo.tipo_funcion

return


;with tmp001_soat as(
    select*from(select row_number()over(partition by IdVehiculo order by FecTerminoSeguro desc) item,
    IdVehiculo, NroCertificado, FecTerminoSeguro from dbo.certificado)t where item = 1
)
,tmp001_periodo(mes, anno) as(
    select right(100 + month(dateadd(mm, 1, getdate())), 2), year(dateadd(mm, 1, getdate()))
)
insert into dbo.PROG_VEHICULO(
Id_Vehiculo,Placa_Interna,Placa_Rodaje,Id_TipoRegistro,Id_TipoEstadoVehiculo,
Mes,Anio,CodRev,Id_Unidad,
Id_TipoMaestranza,Id_TipoVehiculo,Id_TipoColor,Id_TipoCombustible,Id_TipoOctanaje,
Id_TipoProcedencia,Cilindrada,Nro_Motor,Nro_Serie,Kilometraje,Id_TipoEstadoOpeVehiculo,
Id_TipoEstadoOpeOdometro,Fec_Operatividad,Id_TipoMotivoInoperatividad,
Id_TipoFuncion,Id_Grifo,Nro_Certificado,Fec_TerminoSOAT,
CIP_Conductor,Grado_Conductor,CIP_OperadorLR,Grado_OperadorLR,UsuarioI,FechaI,Activo,Estado)
select v.id_vehiculo, v.placa_interna, v.placa_rodaje, g.Id_TipoRegistro, o.Id_TipoEstadoVehiculo,
p.mes, p.anno, '', isnull(u.Id_Unidad,''),
o.Id_TipoMaestranza, v.Id_TipoVehiculo, v.Id_TipoColor, left(v.Id_TipoCombustible,5), v.Id_TipoOctanaje,
g.Id_TipoProcedencia, left(v.Cilindrada,5), left(v.Nro_Motor,30), left(v.Nro_Serie,35), null, isnull(o.Id_TipoEstadoOpeVehiculo,''),
isnull(o.Id_TipoEstadoOpeOdometro, 0), isnull(o.Fec_Operatividad,''), o.IdTipoMotivoInoperatividad,
v.Id_TipoFuncion, null, left(s.NroCertificado,20), s.FecTerminoSeguro,
isnull(m.cip,''), isnull(m.idGrado,''), isnull(m.cip,''), isnull(m.idGrado,''), 'sistemas', getdate(), 1, 1
from dbo.vehiculo v cross apply tmp001_periodo p
outer apply(select*from dbo.grupo_bien g where g.id_grupobien = v.id_grupobien)g
outer apply(select*from dbo.operatividad_vehiculo o where o.id_vehiculo = v.id_vehiculo)o
outer apply(select*from dbo.asignar_vehiculo_unidad a where a.id_vehiculo = v.id_vehiculo)a
outer apply(select*from dbo.unidad u where u.CodUni = a.Id_UnidadDestino)u
outer apply(select*from dbo.masterPNP m where m.IdUnidad = a.Id_UnidadDestino)m
outer apply(select*from tmp001_soat s where s.IdVehiculo = v.Id_Vehiculo)s
where not exists(select 1 from dbo.PROG_VEHICULO pv where rtrim(pv.Placa_Interna) = rtrim(v.placa_interna)
and pv.Anio = p.anno and pv.Mes = p.mes)

return
select count(1) from dbo.PROG_VEHICULO

select Placa_Interna, count(1)over(partition by Placa_Interna) cta
from(select Placa_Interna, row_number()over(partition by Placa_Interna order by(select 1))item
from dbo.PROG_VEHICULO)t where item > 1
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


-- ma04 (tipo situacion)
select*from dbo.TIPO_SITUACION_POLICIAL


return
select (select ',', name
from dbo.mastertable('dbo.PROG_VEHICULO')
for xml path, type).value('.','varchar(max)')


-- select*from mastertable('dbo.PROG_VEHICULO')
-- select*from mastertable('dbo.VEHICULO')
-- select*from mastertable('dbo.OPERATIVIDAD_VEHICULO')
-- select*from mastertable('dbo.GRUPO_BIEN')
-- select*from mastertable('dbo.CERTIFICADO')
-- select*from mastertable('dbo.MASTERPNP')
-- DBCC CHECKIDENT ('dbo.PROG_VEHICULO', RESEED, 0);

select count(1)
from(select row_number()over(partition by placa_interna order by (select 1))item
from dbo.VEHICULO)t where item > 1


-- create table dbo.SERVICIO_VEHICULO_LR(
--     Id_ServicioVehiculoLR int identity primary key not null,
--     Id_TipoGrado int not null,
--     DesGrado varchar(50) not null,
--     CodDotacion varchar(2) not null,
--     DotacionDiaria varchar(10) not null,
--     Activo int not null,
--     Estado int not null
-- );


-- insert into dbo.SERVICIO_VEHICULO_LR(Id_TipoGrado,DesGrado,CodDotacion,DotacionDiaria,Activo,Estado)
-- select 10, 'Tnte. Gral', 'S1', 3, 1, 1 union all
-- select 20, 'General', 'S2', 2, 1, 1 union all
-- select 30, 'Coronel', 'S3', 1.5, 1, 1

select*from TIPO_COMBUSTIBLE


-- insert into dbo.tipo_dotacion_gd(
-- Rango_Cilindrada,RendimientoxGln,Id_TipoFuncion,RKxG_Menor,RKxG_Mayor,Activo,Estado)
select rango, rendimiento, id_tipoFuncion, menor, mayor, 1, 1
from(values
('1026-1150', 35.7, 50, 3, 1),
('1026-1150', 35.7, 50, 4.5, 2),
('1026-1150', 35.7, 50, 4.5, 5),
('1026-1150', 35.7, 50, 6, 3),
('1026-1150', 35.7, 50, 6, 9),
('1026-1150', 35.7, 50, 6.5, 4),

('1151-1250', 33.8, 47.3, 3.5, 1),
('1151-1250', 33.8, 47.3, 4.5, 2),
('1151-1250', 33.8, 47.3, 4.5, 5),
('1151-1250', 33.8, 47.3, 6.5, 3),
('1151-1250', 33.8, 47.3, 6.5, 9),
('1151-1250', 33.8, 47.3, 7, 4),

('1251-1350', 32.1, 45, 3.5, 1),
('1251-1350', 32.1, 45, 5, 2),
('1251-1350', 32.1, 45, 5, 5),
('1251-1350', 32.1, 45, 7, 3),
('1251-1350', 32.1, 45, 7, 9),
('1251-1350', 32.1, 45, 7.5, 4),

('1351-1450', 30.7, 42, 3.5, 1),
('1351-1450', 30.7, 42, 5, 2),
('1351-1450', 30.7, 42, 5, 5),
('1351-1450', 30.7, 42, 7, 3),
('1351-1450', 30.7, 42, 7, 9),
('1351-1450', 30.7, 42, 8, 4),

('1451-1550', 29.4, 41.1, 3.5, 1),
('1451-1550', 29.4, 41.1, 5.5, 2),
('1451-1550', 29.4, 41.1, 5.5, 5),
('1451-1550', 29.4, 41.1, 7.5, 3),
('1451-1550', 29.4, 41.1, 7.5, 9),
('1451-1550', 29.4, 41.1, 8, 4),

('1551-1650', 28.2, 39.5, 4, 1),
('1551-1650', 28.2, 39.5, 5.5, 2),
('1551-1650', 28.2, 39.5, 5.5, 5),
('1551-1650', 28.2, 39.5, 8, 3),
('1551-1650', 28.2, 39.5, 8, 9),
('1551-1650', 28.2, 39.5, 8.5, 4),

('1651-1750', 27.1, 38, 4, 1),
('1651-1750', 27.1, 38, 6, 2),
('1651-1750', 27.1, 38, 6, 5),
('1651-1750', 27.1, 38, 8, 3),
('1651-1750', 27.1, 38, 8, 9),
('1651-1750', 27.1, 38, 9, 4)

)ttt(rango, menor, mayor, rendimiento, id_tipoFuncion)
