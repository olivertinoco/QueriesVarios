if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_buscar_vehiculo_tarjeta_multiflota','p'))
drop procedure dbo.usp_buscar_vehiculo_tarjeta_multiflota
go
create procedure dbo.usp_buscar_vehiculo_tarjeta_multiflota
@data varchar(100)
as
begin
begin try
set nocount on
set language english

create table #tmp001_param(
    interna varchar(50) collate database_default,
    rodajes varchar(50) collate database_default
)
select @data = dato from dbo.udf_splice(@data, default, default)
insert into #tmp001_param exec(@data)

;with tmp001_sep(t,r,i,a)as(
    select*from(values('|','~','^','*'))t(sepCampo,sepReg,sepLst,sepAux)
)
,tmp001_cab(dato)as(
    select 'a1|PLACA INTERNA|PLACA RODAJE|MARCA|MODELO|TIPO VEHICULO|OCTANAJE~10|200|200|400|400|400|400'
)
,hlp001_marcaModelo as(
    select t.Id_Vehiculo, t.placa_interna, t.placa_rodaje,
    ltrim(tt.DescripcionL) marca, ltrim(tm.DescripcionL) modelo,
    ltrim(tv.DescripcionL) tipovh, ltrim(toc.DescripcionL) octanaje
    from dbo.vehiculo t
    outer apply(select*from dbo.tipo_marca tt where tt.Id_TipoMarca = t.Id_TipoMarca) tt
    outer apply(select*from dbo.tipo_modelo tm where tm.Id_TipoModelo = t.Id_TipoModelo) tm
    outer apply(select*from dbo.tipo_vehiculo tv where tv.Id_TipoVehiculo = t.Id_TipoVehiculo) tv
    outer apply(select*from dbo.tipo_octanaje toc where toc.Id_TipoOctanaje = t.Id_TipoOctanaje) toc
    where t.estado = 1
)
select concat(c.dato, (select r,
t.Id_Vehiculo, t, t.placa_interna, t, t.placa_rodaje, t, t.marca, t, t.modelo, t, t.tipovh, t, t.octanaje
from hlp001_marcaModelo t, #tmp001_param tt where
t.placa_interna like concat('%', tt.interna, '%') and placa_rodaje like concat('%', tt.rodajes, '%')
order by t.placa_interna
for xml path, type).value('.', 'varchar(max)'))
from tmp001_sep, tmp001_cab c

end try
begin catch
    select concat('error:', error_message())
end catch
end
go


declare @data varchar(100)
-- ='cm|'
= '|lie'

exec dbo.usp_buscar_vehiculo_tarjeta_multiflota @data
