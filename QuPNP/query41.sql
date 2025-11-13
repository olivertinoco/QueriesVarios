-- select*from mastertable('dbo.prog_eo_grifo')
-- declare @Utabla22 tabla_generico
-- insert into @Utabla22
-- exec dbo.usp_listar_tablas 'dbo.prog_eo_grifo'
-- select*from @Utabla22

-- delete dbo.prog_ruta where Id_ProgRuta > 39
-- delete dbo.prog_extraord where Id_ProgExtraOrd > 3


select*from dbo.prog_extraord
select*from dbo.prog_ruta
select*from dbo.prog_eo_grifo where Id_ProgRuta = 33 and activo = 1

-- alter table dbo.prog_eo_grifo alter column CIP_Conductor varchar(10)
-- select*from mastertable('dbo.prog_eo_grifo')



-- set language english
-- insert into prog_eo_grifo(Id_ProgRuta, Id_Grifo, Fec_Abastecimiento, CantidadAbastecimiento, UsuarioI)
-- select 33,227,'2025-10-11','14','admin' union all
-- select 36,149,'2025-09-16','17','admin' union all
-- select 36,210,'2025-04-01','18','admin'
