-- select*from mastertable('dbo.prog_extraord')

-- delete dbo.prog_ruta where Id_ProgRuta > 39
-- delete dbo.prog_extraord where Id_ProgExtraOrd > 3


select*from dbo.prog_extraord
select*from dbo.prog_ruta
select*from dbo.prog_eo_grifo


select
t.Id_Grifo, t.Nro_RUC, rtrim(t.NombreGrifo), rtrim(t.Direccion),
rtrim(u.Departamento), rtrim(u.Provincia), rtrim(u.Distrito)
from dbo.grifo t
outer apply(select*from dbo.UBIGEO u where u.Id_Ubigeo =t.Id_Ubigeo)u
where t.activo = 1 and t.estado = 1
