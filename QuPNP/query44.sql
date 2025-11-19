-- select *from sys.tables order by 1
-- alter table dbo.PROG_TARJETA_MULTIFLOTA add UsuarioI varchar(20)
-- alter table dbo.PROG_TARJETA_MULTIFLOTA add FechaI datetime default getdate()
-- exec sp_rename 'dbo.PROG_TARJETA_MULTIFLOTA.Fec_cancelación', 'Fec_cancelacion', 'column';

-- insert into dbo.mastertablas
-- select 7, 'dbo.prog_tarjeta_multiflota'

-- select*from tipo_vehiculo
-- select*from tipo_octanaje

-- insert into dbo.menu
-- select '010300', 'Tarjeta Multiflota', 'ProgTarjetaMultiflota'


-- ;with tmp001_sec as(
--     select top 10 row_number()over(order by (select 1)) item from dbo.vehiculo
-- )
-- insert into dbo.PROG_TARJETA_MULTIFLOTA(id_vehiculo, placa_interna, placa_rodaje,Nro_Tarjeta,Fec_Activacion,Fec_cancelacion,Activo)
-- select id_vehiculo, placa_interna, placa_rodaje, left(replace(newid(), '-', ''), 30),
-- dateadd(dd, item, getdate()), dateadd(hh, 5, dateadd(dd, item, getdate())), 0
-- from dbo.vehiculo, tmp001_sec where id_vehiculo = 353253

-- update t set activo = 1, Fec_cancelacion = null from dbo.PROG_TARJETA_MULTIFLOTA t where Id_Multiflota = 10
-- update t set usuarioI = 'ADMIN' from dbo.PROG_TARJETA_MULTIFLOTA t



select*from dbo.PROG_TARJETA_MULTIFLOTA
where id_vehiculo = 353253
order by Id_Multiflota desc offset 0 rows fetch first 1 row only


select*from dbo.mastertable('dbo.PROG_TARJETA_MULTIFLOTA')


declare @Utabla tabla_generico
insert into @Utabla
exec dbo.usp_listar_tablas 'dbo.prog_tarjeta_multiflota'
select*from @Utabla



return
select*from dbo.menu
select*from dbo.menuTransportes

select*from dbo.prog_extraord
select*from dbo.prog_ruta
select*from dbo.prog_eo_grifo where Id_ProgRuta = 33 and activo = 1

select*from mastertable('dbo.prog_extraord')
select*from mastertable('dbo.prog_ruta')
select*from mastertable('dbo.prog_eo_grifo')


select*From dbo.masterAudit
select*From dbo.mastertablas
