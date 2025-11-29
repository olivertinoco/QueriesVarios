-- insert into dbo.mastertablas
-- select 8, 'dbo.prog_abastecimiento_diario'
set rowcount 50

;with tmp001_sep(t,r,i,a)as(
    select*from(values('|','~','^','*'))t(sepCampo,sepReg,sepLst,sepAux)
)
select concat(t, t, t, t, t, anno, t, mes)
from(select max(anio) anno, max(mes) mes from dbo.prog_vehiculo group by anio, mes)t,
tmp001_sep


-- declare @Utabla tabla_generico
-- insert into @Utabla
-- exec dbo.usp_listar_tablas 'dbo.prog_abastecimiento_diario'
-- select*from @Utabla

select*from mastertable('dbo.prog_abastecimiento_diario')

-- declare @Utabla tabla_generico
-- insert into @Utabla
-- exec dbo.usp_listar_tablas 'dbo.prog_tarjeta_multiflota'
-- select*from @Utabla

-- select*from mastertable('dbo.prog_tarjeta_multiflota')

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
