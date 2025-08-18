set rowcount 0
set nocount off

select top 0
cast(null as tinyint) dias,
cast(null as tinyint) habiles into #tmp001_dias
insert into #tmp001_dias exec dbo.usp_diasXmeses

-- delete dbo.PROG_DOTACION
-- DBCC CHECKIDENT ('dbo.PROG_DOTACION', RESEED, 0);
-- go

-- select distinct id_tipoFuncion, count(1)over(partition by id_tipoFuncion) from dbo.PROG_VEHICULO
-- where id_tipoFuncion in (6,7,8)


select*from dbo.PROG_DOTACION
where GlnxMes = '0.00'
order by Id_ServicioVehiculoLR desc, Id_TipoDotacionGD desc

return


-- select tt.Id_TipoEstadoVehiculo, t.Id_Vehiculo, t.Id_TipoFuncion, t.Id_GrupoBien, t.Placa_Interna
-- from dbo.vehiculo t cross apply dbo.operatividad_vehiculo tt
-- cross apply (values(6),(7),(8))ttt(Id_TipoFuncion)
-- where t.Id_Vehiculo = tt.Id_Vehiculo and t.Id_TipoFuncion = ttt.Id_TipoFuncion
-- order by tt.Id_TipoEstadoVehiculo


select*from dbo.tipo_estado_operatividad

return
insert into dbo.PROG_DOTACION(
Id_ProgVehiculo,Id_Vehiculo,Placa_Interna,Id_ServicioVehiculoLR,Id_TipoDiasMes,Id_TipoDotacionGD,
GlnxDia,GlnxMes,Observacion,UsuarioI,FechaI,Activo,Estado)
select
t.Id_ProgVehiculo, t.Id_Vehiculo, t.Placa_Interna, c.Id_ServicioVehiculoLR, null,
p.Id_TipoDotacionGD,
coalesce(p.RendimientoxGln, c.dotacionDiaria, ''), coalesce(p.galMes, c.galMes, 0), null, 'systemas', getdate(), 1, 1
from dbo.PROG_VEHICULO t cross apply #tmp001_dias d
outer apply(select*from
dbo.udf_dotacionPolicia(isnull(nullif(rtrim(t.Id_TipoCombustible),'GSL'),'GSH'), t.cilindrada, t.id_tipoFuncion, d.dias, d.habiles)
where t.id_tipoRegistro = 1)p
outer apply(select*from dbo.udf_dotacionComando(t.Grado_Conductor, d.dias)
where t.id_tipoRegistro = 2)c
where t.id_tipoFuncion != 7
order by t.id_tipoFuncion



-- select*from dbo.SERVICIO_VEHICULO_LR
-- select*from dbo.tipo_dotacion_gd
-- select*from dbo.tipo_funcion
