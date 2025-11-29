-- select *from sys.tables order by 1
-- alter table dbo.PROG_TARJETA_MULTIFLOTA add UsuarioI varchar(20)
-- alter table dbo.PROG_TARJETA_MULTIFLOTA add FechaI datetime default getdate()
-- exec sp_rename 'dbo.PROG_TARJETA_MULTIFLOTA.Fec_cancelación', 'Fec_cancelacion', 'column';

-- insert into dbo.mastertablas
-- select 7, 'dbo.prog_tarjeta_multiflota'


-- insert into dbo.menu
-- select '010300', 'Tarjeta Multiflota', 'ProgTarjetaMultiflota'

-- insert into dbo.menu
-- select '010400', 'Tarjeta Multiflota Masivo', 'ProgTarjetaMultiflotaMasivo' union all
-- select '020100', 'Programación Extraordinaria', 'xxxx' union all
-- select '020200', 'Programación C. Unidades', 'ProgCmbUnidades' union all
-- select '020300', 'Programación C. Grifos', 'ProgCmbGrifos' union all
-- select '030100', 'Orden de Pedido', 'AdqOrdenPedido' union all
-- select '030200', 'Pedidos Planta PP', 'AdqPedidoPlantaPP' union all
-- select '040100', 'Control Saldo Unidad', 'RctaControlSaldoUnidad' union all
-- select '040200', 'Control Saldo Grifos', 'RctaControlSaldoGrifo' union all
-- select '040300', 'Acta Conciliar Volúmen', 'RctaActaConciliarVolumen' union all
-- select '050100', 'Control Consumo Diario', 'UndPNPControlConsumoDiario' union all
-- select '060000', 'Mantenimiento', null union all
-- select '060100', 'Tipo Paradas', 'MtoParada' union all
-- select '060200', 'Grifos', 'MtoGrifos' union all
-- select '060300', 'Representantes Grifo', 'MtoRepteGrifos' union all
-- select '060400', 'Productos Planta', 'MtoProdPlanta' union all
-- select '060500', 'Empresa Transporte', 'MtoEmpTransporte' union all
-- select '060600', 'Códigos Pedidos', 'MtoCodigosPedidos' union all
-- select '060700', 'Servicio Vehículo LR', 'MtoServiciosVehiculosLR' union all
-- select '060800', 'Días Feriados', 'MtoDiasFeriados'union all
-- select '060900', 'Planta Grifo', 'MtoProdPlantaGrifo' union all
-- select '061000', 'Tipo Grifo', 'MtoTipoGrifo' union all
-- select '061100', 'Tipo Dotación', 'MtoTipoDotacion' union all
-- select '061200', 'Camiones', 'MtoCamiones' union all
-- select '061300', 'Conductores Camiones', 'MtoConductoresCamiones'

-- update t set t.descripcion = 'Programación Combustible'
-- from dbo.menu t
-- where t.id_menu = '010100'


-- update t set t.descripcion = 'Distribución Combustible'
-- from dbo.menu t
-- where t.id_menu = '020000'

-- update t set t.data_router = 'ProgExtraordinariaSearch'
-- from dbo.menu t
-- where t.id_menu = '020100'


-- update t set t.descripcion = 'Adquisición Combustible'
-- from dbo.menu t
-- where t.id_menu = '030000'

-- update t set t.descripcion = 'Rendición de Cuentas'
-- from dbo.menu t
-- where t.id_menu = '040000'

-- update t set t.descripcion = 'Unidades PNP'
-- from dbo.menu t
-- where t.id_menu = '050000'



select*from dbo.menu order by 1
select*from dbo.menuTransportes


select*from dbo.PROG_TARJETA_MULTIFLOTA
-- where id_vehiculo = 353253
-- order by Id_Multiflota desc offset 0 rows fetch first 1 row only


select*from dbo.mastertable('dbo.PROG_TARJETA_MULTIFLOTA')


declare @Utabla tabla_generico
insert into @Utabla
exec dbo.usp_listar_tablas 'dbo.prog_tarjeta_multiflota'
select*from @Utabla



-- return

select*from dbo.prog_extraord
select*from dbo.prog_ruta
select*from dbo.prog_eo_grifo where Id_ProgRuta = 33 and activo = 1

select*from mastertable('dbo.prog_extraord')
select*from mastertable('dbo.prog_ruta')
select*from mastertable('dbo.prog_eo_grifo')


select*From dbo.masterAudit
select*From dbo.mastertablas
