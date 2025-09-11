if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_listar_ASIGNAR_VEHICULO_UNIDAD_01','p'))
drop procedure dbo.usp_listar_ASIGNAR_VEHICULO_UNIDAD_01
go
create procedure dbo.usp_listar_ASIGNAR_VEHICULO_UNIDAD_01
@data varchar(50)
as
begin
set nocount on
begin try

;with tmp001_sep(t,r)as(
    select*from(values('|','~'))t(sepCamp,sepReg)
)
,tmp001_cab as(
select cab ='Id_AsignarVehiculoUnidad|\
Id_vehiculo|\
Placa_Interna|\
Placa_Rodaje|\
Id_TipoVehiculo|\
Id_TipoMarca|\
Id_TipoModelo|\
Anio_Modelo|\
Id_TipoColor|\
Id_TipoCombustible|\
Cilindrada|\
Nro_Motor|\
Nro_Serie|\
Id_UnidadDestino|\
Procedencia|\
Tipo_Transmision|\
Ultima Unidad|\
Tipo Octanaje'
)
select concat(c.cab, (select r,
t.Id_AsignarVehiculoUnidad, t,
t.Id_vehiculo, t,
t.Placa_Interna, t,
tt.Placa_Rodaje, t,
tv.DescripcionL, t,
tm.DescripcionL, t,
tmo.DescripcionL, t,
tt.Anio_Modelo, t,
tc.DescripcionL, t,
tcomb.DescripcionL, t,
tt.Cilindrada, t,
tt.Nro_Motor, t,
tt.Nro_Serie, t,
t.Id_UnidadDestino, t,
tp.DescripcionL, t,
tr.DescripcionL, t,
u.UltimaUnidad, t,
oc.DescripcionL
from dbo.ASIGNAR_VEHICULO_UNIDAD t cross apply dbo.VEHICULO tt
outer apply(select*from dbo.tipo_vehiculo tv where tv.Id_TipoVehiculo = tt.Id_TipoVehiculo)tv
outer apply(select*from dbo.tipo_marca tm where tm.Id_TipoMarca = tt.Id_TipoMarca)tm
outer apply(select*from dbo.tipo_modelo tmo where tmo.Id_TipoModelo = tt.Id_TipoModelo)tmo
outer apply(select*from dbo.tipo_color tc where tc.Id_TipoColor = tt.Id_TipoColor)tc
outer apply(select*from dbo.tipo_combustible tcomb where tcomb.Id_TipoCombustible = tt.Id_TipoCombustible)tcomb
outer apply(select*from dbo.grupo_bien gg where gg.Id_GrupoBien = tt.Id_GrupoBien)gg
outer apply(select*from dbo.tipo_procedencia tp where tp.Id_TipoProcedencia = gg.Id_TipoProcedencia)tp
outer apply(select*from dbo.tipo_transmision tr where tr.Id_TipoTransmision = tt.Id_TipoTransmision)tr
outer apply(select*from dbo.unidad u where u.Id_Unidad = t.Id_UnidadDestino)u
outer apply(select*from dbo.tipo_octanaje oc where oc.Id_TipoOctanaje = tt.Id_TipoOctanaje)oc
where t.Id_vehiculo = tt.Id_vehiculo and t.Estado = 1 and tt.Estado = 1
and t.Id_UnidadDestino = @data
for xml path, type).value('.','varchar(max)'))
from tmp001_sep, tmp001_cab c

end try
begin catch
    select concat('error: ', error_message())
end catch
end
go

exec dbo.usp_listar_ASIGNAR_VEHICULO_UNIDAD_01 96777

go
if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_listar_ASIGNAR_VEHICULO_COMANDO_01','p'))
drop procedure dbo.usp_listar_ASIGNAR_VEHICULO_COMANDO_01
go
create procedure dbo.usp_listar_ASIGNAR_VEHICULO_COMANDO_01
@data varchar(50)
as
begin
set nocount on
begin try

;with tmp001_sep(t,r,a)as(
    select*from(values('|','~', ' '))t(sepCamp,sepReg,sepTab)
)
,tmp001_cab as(
select cab ='Id_AsignarVehiculoComando|\
Id_vehiculo|\
Placa_Interna|\
Placa_Rodaje|\
Id_TipoVehiculo|\
Id_TipoMarca|\
Id_TipoModelo|\
Anio_Modelo|\
Id_TipoColor|\
Id_TipoCombustible|\
Cilindrada|\
Nro_Motor|\
Nro_Serie|\
Procedencia|\
Tipo_Transmision|\
Tipo Octanaje|\
CIP|\
Grado|\
Nombres|\
Sit Policial'
)
select concat(c.cab, (select r,
t.Id_AsignarVehiculoComando, t,
t.Id_vehiculo, t,
t.Placa_Interna, t,
tt.Placa_Rodaje, t,
tv.DescripcionL, t,
tm.DescripcionL, t,
tmo.DescripcionL, t,
tt.Anio_Modelo, t,
tc.DescripcionL, t,
tcomb.DescripcionL, t,
tt.Cilindrada, t,
tt.Nro_Motor, t,
tt.Nro_Serie, t,
tp.DescripcionL, t,
tr.DescripcionL, t,
oc.DescripcionL, t,
right((100000000 + ltrim(rtrim(mas.cip))),8), t,
mas.DesGrado, t,
rtrim(mas.Paterno), a, rtrim(mas.Materno), a, rtrim(mas.Nombres), t,
mas.DesSitPol
from dbo.ASIGNAR_VEHICULO_COMANDO t cross apply dbo.VEHICULO tt
outer apply(select*from dbo.tipo_vehiculo tv where tv.Id_TipoVehiculo = tt.Id_TipoVehiculo)tv
outer apply(select*from dbo.tipo_marca tm where tm.Id_TipoMarca = tt.Id_TipoMarca)tm
outer apply(select*from dbo.tipo_modelo tmo where tmo.Id_TipoModelo = tt.Id_TipoModelo)tmo
outer apply(select*from dbo.tipo_color tc where tc.Id_TipoColor = tt.Id_TipoColor)tc
outer apply(select*from dbo.tipo_combustible tcomb where tcomb.Id_TipoCombustible = tt.Id_TipoCombustible)tcomb
outer apply(select*from dbo.grupo_bien gg where gg.Id_GrupoBien = tt.Id_GrupoBien)gg
outer apply(select*from dbo.tipo_procedencia tp where tp.Id_TipoProcedencia = gg.Id_TipoProcedencia)tp
outer apply(select*from dbo.tipo_transmision tr where tr.Id_TipoTransmision = tt.Id_TipoTransmision)tr
outer apply(select*from dbo.tipo_octanaje oc where oc.Id_TipoOctanaje = tt.Id_TipoOctanaje)oc
outer apply(select*from dbo.masterPNP mas
where right((100000000 + ltrim(rtrim(mas.cip))),8) = right((100000000 + ltrim(rtrim(t.Cip_Usuario))),8))mas
where t.Id_vehiculo = tt.Id_vehiculo and t.Estado = 1 and tt.Estado = 1
and t.Cip_Usuario = @data
for xml path, type).value('.','varchar(max)'))
from tmp001_sep, tmp001_cab c

end try
begin catch
    select concat('error: ', error_message())
end catch
end
go


exec usp_listar_ASIGNAR_VEHICULO_COMANDO_01 113597




set rowcount 20

select*from dbo.masterPNP

-- select t.*
-- from dbo.ASIGNAR_VEHICULO_COMANDO t where Cip_Usuario = 111782
-- select*from dbo.masterPNP where cip = 111782

-- select*from mastertable('dbo.ASIGNAR_VEHICULO_COMANDO')
-- select*from mastertable('dbo.masterPNP')


-- cross apply dbo.VEHICULO tt
-- where
-- t.Id_vehiculo = tt.Id_vehiculo and t.Estado = 1 and tt.Estado = 1
-- and
-- t.Cip_Usuario in(
-- select cip -- , DesGrado, Paterno, Materno, Nombres
-- from dbo.masterPNP)


return

-- grado
-- nombre
-- carnet



-- exec sp_spaceused ASIGNAR_VEHICULO_UNIDAD
-- exec sp_spaceused ASIGNAR_VEHICULO_COMANDO

select*from dbo.mastertable('dbo.ASIGNAR_VEHICULO_UNIDAD')
select*from dbo.mastertable('dbo.ASIGNAR_VEHICULO_COMANDO')
select*from dbo.mastertable('dbo.VEHICULO')
select*from dbo.mastertable('dbo.GRUPO_BIEN')
select*from dbo.mastertable('dbo.UNIDAD')


-- set rowcount 10
-- select*from dbo.VEHICULO

-- select *
-- from(select row_number()over(partition by Id_Vehiculo order by Id_Vehiculo) item,*
-- from dbo.ASIGNAR_VEHICULO_UNIDAD)t where item > 1


-- select *
-- from(select row_number()over(partition by Id_Vehiculo order by Id_Vehiculo) item,*
-- from dbo.ASIGNAR_VEHICULO_COMANDO)t where item > 1


return
use transporte
set rowcount 100

select t.Id_Vehiculo, t.Placa_Interna from dbo.ASIGNAR_VEHICULO_UNIDAD t, dbo.ASIGNAR_VEHICULO_COMANDO tt
where t.Id_Vehiculo = tt.Id_Vehiculo
-- select Id_Vehiculo, Placa_Interna dbo.ASIGNAR_VEHICULO_COMANDO
