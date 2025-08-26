set rowcount 0
-- select text from sys.syscomments where id=object_id('dbo.usp_listarMenus22','p')

-- create procedure dbo.usp_listarMenus22
declare
@data varchar(max)
= 'varrieta|4321'

set nocount on

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
select tt.menu_id,  ltrim(tt.menu_nombre)
from dbo.A00_UsuariosRoles t, dbo.A00_Menus tt, tmp001_datos ttt
where t.menu_id = tt.menu_id and t.Pos_id = try_cast(ttt.Pos_id as int)
and t.rol_activo = 1
order by t.menu_id


-- end try
-- begin catch
--     select concat('error:', error_message())
-- end catch
-- end


-- exec dbo.usp_listarMenus22 'varrieta|4321'
