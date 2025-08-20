set rowcount 10

select*from dbo.prog_vehiculo
select*from dbo.prog_dotacion

set rowcount 0

-- select*from mastertable('dbo.prog_dotacion')
-- select*from mastertable('dbo.prog_vehiculo')

-- Placa_Interna
select Id_TipoFuncion, DescripcionL from dbo.tipo_funcion where estado = 1 and activo = 1
select Id_TipoRegistro, DescripcionL from dbo.tipo_registro where estado = 1 and activo = 1
select Id_TipoVehiculo, DescripcionL from dbo.tipo_vehiculo where estado = 1 and activo = 1
