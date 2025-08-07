set rowcount 0
-- select top 20 *from dbo.OPERATIVIDAD_VEHICULO
-- delete from dbo.OPERATIVIDAD_VEHICULO

exec sys.sp_spaceused OPERATIVIDAD_VEHICULO
exec transporte.sys.sp_spaceused OPERATIVIDAD_VEHICULO
return


set identity_insert dbo.OPERATIVIDAD_VEHICULO on

insert into dbo.OPERATIVIDAD_VEHICULO(
Id_Operatividad_Vehiculo, Id_Vehiculo, Placa_Interna,Id_TipoEstadoOpeVehiculo,Id_TipoEstadoOpeOdometro,
IdTipoMotivoInoperatividad, Id_TipoEstadoVehiculo, Id_TipoMaestranza, Id_TipoDocumento,
Nro_Documento, Fec_Documento, Fec_Operatividad, Observacion, UsuarioI, FechaI, Estado)
select
Id_Operatividad_Vehiculo, Id_Vehiculo, Placa_Interna,
nullif(coalesce(nullif(Id_TipoEstadoRegistro, 2), nullif(Id_TipoEstadoRegistro2, 2), 3), 3) Id_TipoEstadoOpeVehiculo,
nullif(coalesce(nullif(Id_TipoEstadoRegistro, 1), nullif(Id_TipoEstadoRegistro2, 1), 3), 3) Id_TipoEstadoOpeOdometro,
IdTipoMotivoInoperatividad, Id_TipoEstadoVehiculo, Id_TipoMaestranza, Id_TipoDocumento,
Nro_Documento, Fec_Documento, Fec_Operatividad, Observacion, UsuarioI, FechaI, Estado
from(select lead(Id_TipoEstadoRegistro)over(partition by t.id_vehiculo order by t.fechaI desc) Id_TipoEstadoRegistro2,t.*
from(select row_number()over(partition by id_vehiculo order by fechaI desc)item,
sum(1)over(partition by id_vehiculo)cta,*
from transporte.dbo.OPERATIVIDAD_VEHICULO)t cross apply (values(1),(2))tt(item)
where t.item = tt.item)t
where t.cta = 1 or (not t.Id_TipoEstadoRegistro2 is null)

set identity_insert dbo.OPERATIVIDAD_VEHICULO off



-- NOTA: PARA CONFIRMAR EL TAMAÑO DE LA DATA POBLADA
-- =================================================

use sispap1;
exec sp_spaceused OPERATIVIDAD_VEHICULO

select count(1)
from(select row_number()over(partition by id_vehiculo order by(select 1))item
from dbo.operatividad_vehiculo)t where item = 1

select count(1)
from(select row_number()over(partition by id_vehiculo order by(select 1))item
from transporte.dbo.operatividad_vehiculo)t where item = 1




-- select*from dbo.TIPO_VEHICULO
-- select*from transporte.dbo.TIPO_VEHICULO

-- select*from dbo.TIPO_MARCA
-- select*from transporte.dbo.TIPO_MARCA

-- select*from dbo.TIPO_MODELO
-- select*from transporte.dbo.TIPO_MODELO

-- select*from dbo.TIPO_COLOR
-- select*from transporte.dbo.TIPO_COLOR

-- select*from dbo.TIPO_TRANSMISION
-- select*from transporte.dbo.TIPO_TRANSMISION

-- select*from dbo.TIPO_COMBUSTIBLE
-- select*from transporte.dbo.TIPO_COMBUSTIBLE
