if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_loginXmenus','p'))
drop procedure dbo.usp_loginXmenus
go
create procedure dbo.usp_loginXmenus
@data varchar(100)
as
begin
set nocount on
begin try

select top 0
cast(null as varchar(50)) usuario,
cast(null as varchar(50)) clave into #tmp001_param
select @data = concat('select*from(values(''', replace(@data, '|', ''','''), '''))t(a,b)')
insert into #tmp001_param exec(@data)

;with tmp001_sep(t,r) as(
    select*from(values('|','~'))t(sepCamp,sepReg)
)
select concat(1457,(select r, id_menu, t, descripcion, t, data_router
from dbo.menu order by id_menu
for xml path, type).value('.','varchar(max)')) dato
from tmp001_sep

end try
begin catch
    select concat('error', error_message()) dato
end catch
end
go

exec dbo.usp_loginXmenus '1212|545'

select*from dbo.menu


-- create table dbo.menu(
--     id_menu varchar(6),
--     descripcion varchar(100),
--     data_router varchar(50)
-- )

-- -- delete dbo.menu
-- insert into dbo.menu
-- select '010000', 'Programacion Combustible', null union all
-- select '030000', 'Distribucion Combustible', null union all
-- select '020000', 'Adquisicion Combustible', null union all
-- select '040000', 'Control Previo', null union all
-- select '050000', 'Rendicion de Cuentas', null union all
-- select '010100', 'Programacion Dotacion', 'ProgDotacion' union all
-- select '010200', 'Programacion Extraordinaria', 'ProgExtraordinaria'

-- select*from dbo.menu
