-- select *from sys.tables order by 1

-- alter table dbo.PROG_TARJETA_MULTIFLOTA add UsuarioI varchar(20)
-- alter table dbo.PROG_TARJETA_MULTIFLOTA add FechaI datetime default getdate()

-- insert into dbo.mastertablas
-- select 7, 'dbo.prog_tarjeta_multiflota'



select*from dbo.mastertable('dbo.PROG_TARJETA_MULTIFLOTA')
select*from dbo.mastertable('dbo.PROG_EXTRAORD')

select*From dbo.masterAudit



select*From dbo.mastertablas
