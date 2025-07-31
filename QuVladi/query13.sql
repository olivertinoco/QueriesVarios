set rowcount 20

select Doc_Id, Doc_Descripcion, Doc_Cod
from dbo.m_DocsVarios where Doc_Disponible = 1
order by Doc_Descripcion

-- select*from dbo.RH10_PosDocsAfiliacion

select t.Pos_AFP, j.UO_Id, jj.bloqueo
from dev.RH10_Postulantes t
outer apply(select*from dbo.A10_Proyectos j where j.Proy_Id = t.Proy_Id)j
outer apply(select*from dbo.udf_enProceso()jj where jj.Proceso_Id = t.PosEst_Proceso)jj
where pos_id = 52




-- NOTA: BUSQUEDA ...
-- declare @pos_id int = 3255, @Pos_DocNumero varchar(20) = '40545510'
-- select*from dev.RH10_Postulantes where
-- -- lower(rtrim(ltrim(Pos_Nombres))) = 'oliver'
-- Pos_DocNumero = @Pos_DocNumero

-- return
-- delete dev.RH10_Postulantes where pos_id = @pos_id
-- delete dev.RH10_PosDirecciones where pos_id = @pos_id
-- delete dev.RH10_PosEPPs where pos_id = @pos_id
-- delete dev.A00_Usuarios where pos_id = @pos_id

-- select*from dev.RH10_Postulantes where pos_id = @pos_id
-- select*from dev.RH10_PosDirecciones where pos_id = @pos_id
-- select*from dev.RH10_PosEPPs where pos_id = @pos_id
-- select*from dev.A00_Usuarios where pos_id = @pos_id
