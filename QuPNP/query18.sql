-- NOTA: LOCAL
-- ==========
use sispap
go
if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_listaGeometrias','p'))
drop procedure dbo.usp_listaGeometrias
go
create procedure dbo.usp_listaGeometrias
as
begin
set nocount on
begin try

;with tmp001_sep(t,r, i) as(
    select*from(values('|','~','^'))t(sepCol,sepReg,sepList)
)
,tmp001_geojson_redvialdepartamental(dato)as(
    select concat(i, '#ff0000', t, 0.75, (select r, id, t, geom
    from dbo.geojson_redvialdepartamental
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
select concat(stuff((select r, id_ubigeo, t, departamento, t, provincia, t, distrito
from dbo.ubigeo order by id_ubigeo
for xml path, type).value('.','varchar(max)'),1,1,''), t1.dato)
from tmp001_sep,
tmp001_geojson_redvialdepartamental t1

end try
begin catch
    select concat('error:', error_message())
end catch
end
go

exec dbo.usp_listaGeometrias

select*from dbo.geojson_redvialdepartamental

-- select (select geom
-- from dbo.geojson_redvialdepartamental
-- for xml path, type).value('.','varchar(max)')

-- select dato from tmp001_geojson_redvialdepartamental t1
