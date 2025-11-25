-- insert into dbo.mastertablas
-- select 8, 'dbo.prog_abastecimiento_diario'
set rowcount 50



select
t.Id_ProgVehiculo, t.Id_Vehiculo, t.Anio, t.Mes,
ltrim(tv.DescripcionL) tipovh, ltrim(toc.DescripcionL) tipoComb
from dbo.prog_vehiculo t
outer apply(select*from dbo.tipo_vehiculo tv where tv.Id_TipoVehiculo = t.Id_TipoVehiculo) tv
outer apply(select*from dbo.tipo_combustible toc where toc.Id_TipoCombustible = t.Id_TipoCombustible) toc
-- outer apply(select*from dbo.prog_tarjeta_multiflota)




select*from mastertable('dbo.prog_abastecimiento_diario')
return

-- Id_ProgVehiculo Anio Mes
select*from dbo.prog_vehiculo



-- Id_ProgDotacion Id_ProgVehiculo Id_Vehiculo GlnxDia    GlnxMes
select*from dbo.prog_dotacion

return

-- Id_Multiflota Nro_Tarjeta
select*from dbo.prog_tarjeta_multiflota

-- Id_TipoCombustible DescripcionL
select*from dbo.tipo_combustible
return

-- select*from mastertable('dbo.prog_abastecimiento_diario')
-- select*from mastertable('dbo.PROG_DOTACION')
-- select*from mastertable('dbo.prog_tarjeta_multiflota')
-- select*from mastertable('dbo.grifo')
select*from mastertable('dbo.vehiculo')
select*from mastertable('dbo.unidad_1') -- coduni
