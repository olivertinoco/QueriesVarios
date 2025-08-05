if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_listarUnidades','p'))
drop procedure dbo.usp_listarUnidades
go
create procedure dbo.usp_listarUnidades
@id_unidad int = null
as
begin
set nocount on
set language english

;with tmp001_sep(t,r) as(
    select*from(values('|','~'))t(sepCol,sepReg)
)
,tmp001_soat as(
    select*from(select row_number()over(partition by IdVehiculo order by FecTerminoSeguro desc) item,
    IdVehiculo, NroCertificado, FecTerminoSeguro from dbo.certificado)t where item = 1
)
,tmp001_operatividad as(
    select*from(values(2),(3),(7),(12),(13),(14),(15),(18),(19),(22),(24))t(Id_TipoEstado)
)
,tmp001_cabeceras(dato) as(
select 'Id_Vehiculo|Placa_Interna|Placa_Rodaje|Id_TipoVehiculo|Tipo Vehiculo|Id_TipoMarca|Tipo Marca|\
Id_TipoModelo|Tipo Modelo|Anio_Fabricacion|Id_TipoColor|Tipo Color|Nro_Motor|Nro_Serie|Nro_Cilindros|\
Id_TipoTransmision|TIPO TRANSMISION|Id_TipoCombustible|Tipo Combustible|Id_UnidadDestino|UltimaUnidad|\
Id_TipoEstadoOpeVehiculo|Cantidad|xxxxxxxx|NroCertificado|FecTerminoSeguro'
)
select stuff((select r,
v.Id_Vehiculo, t, v.Placa_Interna, t, v.Placa_Rodaje, t, v.Id_TipoVehiculo, t, tv.DescripcionL, t,
v.Id_TipoMarca, t, TM.DescripcionL, t, v.Id_TipoModelo, t, isnull(tm.DescripcionL, ''), t, v.Anio_Fabricacion, t,
isnull(v.Id_TipoColor, ''), t, isnull(tcc.DescripcionL, ''), t, isnull(v.Nro_Motor, ''), t,
isnull(v.Nro_Serie, ''), t, v.Nro_Cilindros, t, v.Id_TipoTransmision, t, tt.DescripcionL, t, v.Id_TipoCombustible, t,
tc.DescripcionL, t, t.Id_UnidadDestino, t, t.UltimaUnidad, t, t.Id_TipoEstadoOpeVehiculo, t,
row_number() over(partition by t.Id_UnidadDestino order by (select 1)), t, s.NroCertificado, t, s.FecTerminoSeguro
from dbo.VEHICULO v
cross apply(
    select t.id, t.Id_UnidadDestino, t.UltimaUnidad, tt.Id_TipoEstadoOpeVehiculo
    from(
        select*from(select Id_UnidadDestino, UltimaUnidad, id
        from(select row_number()over(partition by id order by id, fechai desc) item, id, Id_UnidadDestino, UltimaUnidad
        from(select t.Id_Vehiculo id, t.Id_UnidadDestino, t.fechai, tt.UltimaUnidad
        from dbo.ASIGNAR_VEHICULO_UNIDAD t
        cross apply(select UltimaUnidad, CodUni from dbo.UNIDAD where id_unidad = isnull(@id_unidad, id_unidad))tt
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
for xml path, type).value('.','varchar(max)'), 1, 0, c.dato)
from tmp001_sep, tmp001_cabeceras c

end
go

exec dbo.usp_listarUnidades
exec dbo.usp_listarUnidades null
exec dbo.usp_listarUnidades default
exec dbo.usp_listarUnidades 215655
