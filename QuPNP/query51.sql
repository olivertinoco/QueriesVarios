-- insert into dbo.mastertablas
-- select 8, 'dbo.prog_abastecimiento_diario'
-- select*from dbo.mastertablas
set rowcount 0


declare @Utabla tabla_generico
insert into @Utabla
exec dbo.usp_listar_tablas 'dbo.prog_abastecimiento_diario'
select*from @Utabla

RETURN

-- declare @Utabla tabla_generico
-- insert into @Utabla
-- exec dbo.usp_listar_tablas 'dbo.prog_tarjeta_multiflota'
-- select*from @Utabla

-- alter table dbo.prog_tarjeta_multiflota alter column activo bit not null


select*from mastertable('dbo.prog_tarjeta_multiflota')

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
