-- insert into dbo.mastertablas
-- select 8, 'dbo.prog_abastecimiento_diario'
-- select*from dbo.mastertablas
set rowcount 0

-- go
-- create table dbo.prog_abastecimiento_diario(
--     Id_AbastecimientoDiario int not null primary key identity,
--     Id_ProgVehiculo         int,
--     Id_Unidad               int not null,
--     Id_Grifo                int,
--     Id_Multiflota           int not null,
--     Anio                    varchar(4) not null,
--     Mes                     varchar(2) not null,
--     Placa_Interna           varchar(10) not null,
--     Placa_Rodaje            varchar(10),
--     Fec_Consumo             datetime not null,
--     Dotacion_Abastecida     varchar(5),
--     Dotacion_Adicional      varchar(5),
--     Nro_Voucher             varchar(15),
--     Saldo_x_Mes             varchar(10),
--     UsuarioI                varchar(20) not null,
--     FechaI                  datetime not null default getdate(),
--     Activo                  bit not null default 1,
--     Estado                  bit not null default 1
-- )
-- go




select*from dbo.prog_abastecimiento_diario
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
