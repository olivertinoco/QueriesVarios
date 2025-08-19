-- NOTA RECURSOS DE VLADIMIR ARRIETA
-- =================================
-- select * from dbo.RH10_Postulantes where Pos_id = 52
-- select*from dbo.A00_Usuarios where Pos_id = 52

if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_listarMenus22','p'))
drop procedure dbo.usp_listarMenus22
go
create procedure dbo.usp_listarMenus22
@data varchar(50)
as
begin
set nocount on

;with tmp001_sep(t,r)as(
    select*from(values('|','~'))t(sepCamp,sepReg)
)
select stuff((select r, tt.menu_id, t, ltrim(tt.menu_nombre)
from dbo.A00_UsuariosRoles t, dbo.A00_Menus tt
where t.menu_id = tt.menu_id and t.Pos_id = @data and t.rol_activo = 1
order by t.menu_id
for xml path, type).value('.','varchar(max)'),1,1,'') data
from tmp001_sep

end
go

exec dbo.usp_listarMenus22 52
