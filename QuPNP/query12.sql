if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_listaDotacionCombustible', 'p'))
drop procedure dbo.usp_listaDotacionCombustible
go
create procedure dbo.usp_listaDotacionCombustible
as
begin
set nocount on
set language english

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~','^'))t(sepCampo,sepReg,sepLst)
)
,tmp001_cab as(
    select 'Id Dotacion|Id Prog Veh|Id Vehiculo|Placa Interna|Id SerVehLR|\
Id TipoDotGD|GlnxDia|GlnxMes|Observacion|Usuario|Fech Ingreso|Activo|Estado~\
100|100|100|100|100|100|100|100|100|100|100|100|100' cab
)
select concat(cab, (select r,
Id_ProgDotacion, t, Id_ProgVehiculo, t, Id_Vehiculo, t, Placa_Interna, t, Id_ServicioVehiculoLR, t,
Id_TipoDotacionGD, t, GlnxDia, t, GlnxMes, t, Observacion, t, UsuarioI, t, convert(varchar, FechaI, 23), t,
Activo, t, Estado
from dbo.PROG_DOTACION
for xml path, type).value('.','varchar(max)')) data
from tmp001_sep, tmp001_cab

end
go

exec dbo.usp_listaDotacionCombustible


-- declare @data varchar(max)=(
-- select(select '|', name
-- from dbo.mastertable('dbo.PROG_DOTACION')
-- order by column_id
-- for xml path, type).value('.','varchar(max)'))
-- select(@data)
