-- insert into dbo.mastertablas
-- select 8, 'dbo.prog_abastecimiento_diario'
-- alter table dbo.prog_abastecimiento_diario add id_vehiculo int
-- exec sp_rename 'dbo.prog_abastecimiento_diario.Id_ProgVehiculo', 'Id_ProgDotacion', 'COLUMN'


-- select t.Id_Vehiculo, ltrim(tt.DescripcionL) marca, ltrim(tm.DescripcionL) modelo,
-- ltrim(tv.DescripcionL) tipovh, ltrim(toc.DescripcionL) octanaje
-- from dbo.vehiculo t
-- outer apply(select*from dbo.tipo_marca tt where tt.Id_TipoMarca = t.Id_TipoMarca) tt
-- outer apply(select*from dbo.tipo_modelo tm where tm.Id_TipoModelo = t.Id_TipoModelo) tm
-- outer apply(select*from dbo.tipo_vehiculo tv where tv.Id_TipoVehiculo = t.Id_TipoVehiculo) tv
-- outer apply(select*from dbo.tipo_octanaje toc where toc.Id_TipoOctanaje = t.Id_TipoOctanaje) toc

set rowcount 50


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
