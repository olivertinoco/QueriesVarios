set rowcount 0

-- select Id_TipoParada, DescripcionL from dbo.TIPO_PARADA where estado = 1 and activo = 1


return

select Id_TipoCombustible DescripcionL from dbo.TIPO_COMBUSTIBLE where activo = 1 and estado = 1
select Id_TipoOctanaje, DescripcionL from dbo.TIPO_OCTANAJE
select*from dbo.TIPO_DOCUMENTO
select*from dbo.UNIDAD
select*from dbo.MasterPNP


set rowcount 20
select concat('t.', name, ',') from mastertable('dbo.PROG_EXTRAORD') order by column_id






-- select*from dbo.PROG_RUTA
-- select*from dbo.PROG_EO_GRIFO
-- select*from dbo.PROG_EXTRAORD
-- select Id_Grifo, NombreGrifo, Id_Ubigeo, Direccion from dbo.Grifo


-- PROG_VEHICULO
-- MasterLicencia
-- MasterPNP
