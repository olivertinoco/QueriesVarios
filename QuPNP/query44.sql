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


select*from dbo.vehiculo where id_vehiculo = 365182





select*from dbo.mastertable('dbo.PROG_TARJETA_MULTIFLOTA')

-- select*from dbo.mastertable('dbo.PROG_EXTRAORD')


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
