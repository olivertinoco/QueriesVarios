if exists(select 1 from sys.sysobjects where id = object_id('dbo.usp_cargaDescripcionUltimaUnidad'))
drop procedure dbo.usp_cargaDescripcionUltimaUnidad
go
create procedure dbo.usp_cargaDescripcionUltimaUnidad
as
begin
set nocount on

;with tmp001_sep as(
    select*from(values(' / '))t(t)
)
update t set UltimaUnidad = iif(right(UltimaUnidad2, 1) = '/',  left(UltimaUnidad2, len(UltimaUnidad2) - 1), UltimaUnidad2)
from(select UltimaUnidad, 
rtrim(replace(concat(xcol1, t, xcol2, t, xcol3, t, xcol4, t, xcol5, t, xcol6, t, xcol7, t, xcol8, t, xcol9), '/  /', '')) UltimaUnidad2
from dbo.unidad, tmp001_sep where UltimaUnidad is null)t

end
go


