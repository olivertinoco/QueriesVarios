use transporte;
-- set rowcount 200
-- exec sp_spaceused OPERATIVIDAD_VEHICULO

-- select*from dbo.tipo_estado_registro
-- select*from sispap1.dbo.tipo_estado_registro

select top 20 *from sispap1.dbo.OPERATIVIDAD_VEHICULO

;with tmp001_opera as(
select distinct top 1000 id_vehiculo
from(select row_number()over(partition by id_vehiculo order by (select 1))item, id_vehiculo
from dbo.OPERATIVIDAD_VEHICULO)t where item > 20
)
select
Id_Operatividad_Vehiculo, Id_Vehiculo, Placa_Interna,
Id_TipoEstadoRegistro, Id_TipoEstadoRegistro2,
IdTipoMotivoInoperatividad, Id_TipoEstadoVehiculo, Id_TipoMaestranza, Id_TipoDocumento,
Nro_Documento, Fec_Documento, Fec_Operatividad, Observacion, UsuarioI, FechaI, Estado
from(select lead(Id_TipoEstadoRegistro)over(partition by id_vehiculo order by fechaI desc) Id_TipoEstadoRegistro2,*
from(select row_number()over(partition by t.id_vehiculo order by t.fechaI desc)item2, t.*
from dbo.OPERATIVIDAD_VEHICULO t, tmp001_opera tt where t.id_vehiculo = tt.id_vehiculo)t,(values(1),(2))tt(item)
where t.item2 = tt.item)t
where not Id_TipoEstadoRegistro2 is null
order by t.id_vehiculo, t.fechaI desc










-- Id_TipoEstadoOpeOdometro
-- Id_TipoEstadoOpeVehiculo
