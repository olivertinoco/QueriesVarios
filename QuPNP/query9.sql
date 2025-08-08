set rowcount 0
select*from dbo.tipo_registro

select distinct id_tiporegistro from dbo.GRUPO_BIEN

-- select*from dbo.vehiculo where not Id_GrupoBien is null
-- order by Id_GrupoBien

select tt.id_tiporegistro, t.*from dbo.vehiculo t, dbo.GRUPO_BIEN tt
where t.Id_GrupoBien = tt.Id_GrupoBien and tt.id_tiporegistro = 2

select tt.id_tiporegistro, t.*from dbo.vehiculo t, dbo.GRUPO_BIEN tt
where t.Id_GrupoBien = tt.Id_GrupoBien and tt.id_tiporegistro = 1

return

-- update t set id_tiporegistro = 1
-- from dbo.GRUPO_BIEN t where id_tiporegistro is null

-- return
-- update tt set id_tiporegistro = 2
-- select tt.Id_GrupoBien, ttt.Placa_Interna, ttt.id_vehiculo, ttt.Id_GrupoBien
update ttt set ttt.Id_GrupoBien = tt.Id_GrupoBien
from dbo.GRUPO_BIEN tt cross apply
(select GB.Id_GrupoBien, GB.Tipo_Bien, V.Placa_Interna
from transporte.dbo.GRUPO_BIEN GB
inner join transporte.dbo.BIEN B on gb. Id_GrupoBien = b.IdGrupoCatalogo
inner join transporte.dbo.vehiculo V on B.Id_Bien = V.Id_Bien
where GB.Tipo_Bien = 2)t
cross apply dbo.vehiculo ttt
where t.Id_GrupoBien = tt.Id_GrupoBien and t.Placa_Interna = ttt.Placa_Interna
