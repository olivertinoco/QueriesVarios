-- -- use SISPAP
-- use TRANSPORTE
-- go
set rowcount 0



-- select*from dbo.unidad




-- ;with tmp001_sep as(
--     select*from(values(' / '))t(t)
-- )
-- update t set UltimaUnidad = iif(right(UltimaUnidad2, 1) = '/',  left(UltimaUnidad2, len(UltimaUnidad2) - 1), UltimaUnidad2)
-- from(select UltimaUnidad, rtrim(replace(concat(xcol1, t, xcol2, t, xcol3, t, xcol4, t, xcol5, t, xcol6, t, xcol7, t, xcol8, t, xcol9), '/  /', '')) UltimaUnidad2
-- from dbo.unidad, tmp001_sep)t



-- return


;with tmp001_exclusion as(
    select*from(values('deposito'),('internado'),('rematado'),('empresa'))t(tipo)
)
,tmp001_operatividad as(
    select*from(values(2),(3),(7),(12),(13),(14),(15),(18),(19),(22),(24))t(Id_TipoEstado)
)
select v.Id_Vehiculo, v.Placa_Interna, v.Placa_Rodaje, v.Id_TipoVehiculo, tv.DescripcionL [Tipo Vehiculo],
v.Id_TipoMarca, TM.DescripcionL [Tipo Marca], v.Id_TipoModelo, isnull(tm.DescripcionL, '') [Tipo Modelo], v.Anio_Fabricacion,
isnull(v.Id_TipoColor, '') Id_TipoColor, isnull(tcc.DescripcionL, '') [Tipo Color], isnull(v.Nro_Motor, '') Nro_Motor,
isnull(v.Nro_Serie, '') Nro_Serie, v.Nro_Cilindros, v.Id_TipoTransmision, tt.DescripcionL [TIPO TRANSMISION], v.Id_TipoCombustible,
tc.DescripcionL [Tipo Combustible], t.Id_UnidadDestino, t.UltimaUnidad, t.Id_TipoEstadoOpeVehiculo,
row_number() over(partition by t.Id_UnidadDestino order by (select 1)) [Cantidad Vehiculos]
from dbo.VEHICULO v
cross apply
(select t.id, t.Id_UnidadDestino, t.UltimaUnidad, tt.Id_TipoEstadoOpeVehiculo
from(select*from(select Id_UnidadDestino, UltimaUnidad, id
from(select row_number()over(partition by id order by id, fechai desc) item, id, Id_UnidadDestino, UltimaUnidad
from(select t.Id_Vehiculo id, t.Id_UnidadDestino, t.fechai, tt.UltimaUnidad
from dbo.ASIGNAR_VEHICULO_UNIDAD t cross apply
(select coalesce(xcol9, xcol8, xcol7, xcol6, xcol5, xcol4, xcol3, xcol2, xcol1) UltimaUnidad, CodUni from dbo.UNIDAD)tt
where t.Id_UnidadDestino = tt.CodUni)t)t where t.item = 1 order by t.id offset 0 rows)t
-- outer apply(select 1 salida from tmp001_exclusion tt where lower(t.UltimaUnidad) like concat('%',lower(tt.tipo),'%'))tt where tt.salida is null
)t
cross apply
(select Id_TipoEstadoOpeVehiculo, id
from(select row_number()over(partition by id order by id, fechai desc) item, id, Id_TipoEstadoOpeVehiculo
from(select Id_Vehiculo id, Id_TipoEstadoOpeVehiculo, fechai
from dbo.OPERATIVIDAD_VEHICULO t cross apply tmp001_operatividad tt
where t.Id_TipoEstadoOpeVehiculo = tt.Id_TipoEstado)t)t where t.item = 1 order by t.id offset 0 rows)tt where t.id = tt.id)t
cross apply dbo.TIPO_VEHICULO tv
cross apply dbo.TIPO_MARCA tm
cross apply dbo.TIPO_TRANSMISION tt
cross apply dbo.TIPO_COMBUSTIBLE tc
outer apply(select*from dbo.TIPO_MODELO tm where tm.Id_TipoModelo = v.Id_TipoModelo)tmc
outer apply(select*from dbo.TIPO_COLOR tco where tco.Id_TipoColor = v.Id_TipoColor)tcc
where v.Id_Vehiculo = t.id and v.Id_TipoVehiculo = tv.Id_TipoVehiculo and v.Id_TipoMarca = tm.Id_TipoMarca and
v.Id_TipoTransmision = tt.Id_TipoTransmision and v.Id_TipoCombustible = tc.Id_TipoCombustible
order by Id_UnidadDestino
