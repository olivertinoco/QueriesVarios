set rowcount 0


;with tmp001_soat as(
    select*from(select row_number()over(partition by IdVehiculo order by FecTerminoSeguro desc) item,
    IdVehiculo, NroCertificado, FecTerminoSeguro from dbo.certificado)t where item = 1
)
,tmp001_operatividad as(
    select*from(values(2),(3),(7),(12),(13),(14),(15),(18),(19),(22),(24))t(Id_TipoEstado)
)
select v.Id_Vehiculo, v.Placa_Interna, v.Placa_Rodaje, v.Id_TipoVehiculo, tv.DescripcionL [Tipo Vehiculo],
v.Id_TipoMarca, TM.DescripcionL [Tipo Marca], v.Id_TipoModelo, isnull(tm.DescripcionL, '') [Tipo Modelo], v.Anio_Fabricacion,
isnull(v.Id_TipoColor, '') Id_TipoColor, isnull(tcc.DescripcionL, '') [Tipo Color], isnull(v.Nro_Motor, '') Nro_Motor,
isnull(v.Nro_Serie, '') Nro_Serie, v.Nro_Cilindros, v.Id_TipoTransmision, tt.DescripcionL [TIPO TRANSMISION], v.Id_TipoCombustible,
tc.DescripcionL [Tipo Combustible], t.Id_UnidadDestino, t.UltimaUnidad, t.Id_TipoEstadoOpeVehiculo,
row_number() over(partition by t.Id_UnidadDestino order by (select 1)) [Cantidad Vehiculos],
s.NroCertificado, s.FecTerminoSeguro
from dbo.VEHICULO v
cross apply(
    select t.id, t.Id_UnidadDestino, t.UltimaUnidad, tt.Id_TipoEstadoOpeVehiculo
    from(
        select*from(select Id_UnidadDestino, UltimaUnidad, id
        from(select row_number()over(partition by id order by id, fechai desc) item, id, Id_UnidadDestino, UltimaUnidad
        from(select t.Id_Vehiculo id, t.Id_UnidadDestino, t.fechai, tt.UltimaUnidad
        from dbo.ASIGNAR_VEHICULO_UNIDAD t
        cross apply(select UltimaUnidad, CodUni from dbo.UNIDAD)tt
        where tt.CodUni = t.Id_UnidadDestino)t
        )t where t.item = 1 order by t.id offset 0 rows)t
    )t
    cross apply(
    select Id_TipoEstadoOpeVehiculo, id
    from(select row_number()over(partition by id order by id, fechai desc) item, id, Id_TipoEstadoOpeVehiculo
        from(select Id_Vehiculo id, Id_TipoEstadoOpeVehiculo, fechai
            from dbo.OPERATIVIDAD_VEHICULO t cross apply tmp001_operatividad tt
            where t.Id_TipoEstadoOpeVehiculo = tt.Id_TipoEstado)t
        )t where t.item = 1 order by t.id offset 0 rows
    )tt where tt.id = t.id
)t
cross apply dbo.TIPO_VEHICULO tv
cross apply dbo.TIPO_MARCA tm
cross apply dbo.TIPO_TRANSMISION tt
cross apply dbo.TIPO_COMBUSTIBLE tc
outer apply(select*from dbo.TIPO_MODELO tm where tm.Id_TipoModelo = v.Id_TipoModelo)tmc
outer apply(select*from dbo.TIPO_COLOR tco where tco.Id_TipoColor = v.Id_TipoColor)tcc
outer apply(select*from tmp001_soat s where s.IdVehiculo = v.Id_Vehiculo)s
where v.Id_Vehiculo = t.id
and v.Id_TipoVehiculo = tv.Id_TipoVehiculo
and v.Id_TipoMarca = tm.Id_TipoMarca
and v.Id_TipoTransmision = tt.Id_TipoTransmision
and v.Id_TipoCombustible = tc.Id_TipoCombustible
order by t.Id_UnidadDestino
