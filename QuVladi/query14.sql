-- select text from sys.syscomments where id=object_id('dbo.usp_listarMenus22','p')
go
alter procedure dbo.usp_listarMenus22
@data varchar(max)
as
begin
set nocount on
begin try

select top 0
cast(null as varchar(100)) USER_Usuario,
cast(null as varchar(100)) clave into #tmp001_usuario
select @data =
concat('select*from(values(''', replace(@data, '|', ''','''), '''))t(a,b)')
insert into #tmp001_usuario exec(@data)

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~','^'))t(sepCamp,sepReg,sepList)
)
,tmp001_datos as(
    select coalesce((select convert(varchar, t.Pos_id)
    from dbo.A00_Usuarios t, #tmp001_usuario tt
    where t.USER_Usuario = tt.USER_Usuario and
    t.USER_Clave256 = convert(varchar(128), hashbytes('sha2_512', tt.clave), 2)),
    'warning') Pos_id
)
select concat(ttt.Pos_id,(select r, tt.menu_id, t, ltrim(tt.menu_nombre), t, ltrim(tt.menu_router)
from dbo.A00_UsuariosRoles t, dbo.A00_Menus tt
where t.menu_id = tt.menu_id and t.Pos_id = try_cast(ttt.Pos_id as int)
and t.rol_activo = 1
order by t.menu_id
for xml path, type).value('.','varchar(max)'))
from tmp001_sep, tmp001_datos ttt

end try
begin catch
    select concat('error:', error_message())
end catch
end
go

exec dbo.usp_listarMenus22 'varrieta|4321'
exec dbo.usp_listarMenus22 'varrieta|43214'



-- update t set t.menu_router = 'Submenu' from dbo.A00_Menus t where t.menu_id = '1102'
-- update t set t.menu_router = 'SubOrganigrama' from dbo.A00_Menus t where t.menu_id = '0401'
-- update t set t.menu_router = 'SubRQpersonal' from dbo.A00_Menus t where t.menu_id = '1004'
-- update t set t.menu_router = 'SubCandidatos' from dbo.A00_Menus t where t.menu_id = '0104'
-- update t set t.menu_router = 'SubVerificaPost' from dbo.A00_Menus t where t.menu_id = '0106'
-- update t set t.menu_router = 'SubDataPostulante' from dbo.A00_Menus t where t.menu_id = '0108'
-- go
