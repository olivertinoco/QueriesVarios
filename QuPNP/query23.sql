if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_loginXmenusTransporte','p'))
drop procedure dbo.usp_loginXmenusTransporte
go
create procedure dbo.usp_loginXmenusTransporte
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
select concat(p.usuario,(select r, id_menu, t, descripcion, t, data_router
from dbo.menuTransportes order by id_menu
for xml path, type).value('.','varchar(max)')) dato
from tmp001_sep, #tmp001_param p

end try
begin catch
    select concat('error', error_message()) dato
end catch
end
go

exec dbo.usp_loginXmenusTransporte 'maria|545'
