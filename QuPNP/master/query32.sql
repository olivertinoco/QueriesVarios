set rowcount 10

select*from dbo.vehiculo

-- select Id_TipoMarca, DescripcionL
-- from dbo.tipo_marca  where activo = 1 and estado = 1 order by 2

select t.Id_TipoModelo, t.Id_TipoMarca, rtrim(tt.DescripcionL), rtrim(t.DescripcionL)
from dbo.tipo_modelo t,  dbo.tipo_marca tt
where t.Id_TipoMarca = tt.Id_TipoMarca and t.activo = 1 and t.estado = 1
-- and t.Id_TipoMarca = 10
order by 2, 3
