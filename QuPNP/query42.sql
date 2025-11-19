if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_listar_vehiculo_tarjeta_multiflota','p'))
drop procedure dbo.usp_listar_vehiculo_tarjeta_multiflota
go
create procedure dbo.usp_listar_vehiculo_tarjeta_multiflota
@data varchar(100)
as
begin
begin try
set nocount on
set language english
declare @item tinyint = 0
create table #tmp001_split(
    item int identity,
    dato varchar(100) collate database_default
)
select @data = concat('select*from(values(''', replace(@data, '|', '''),('''), '''))t(a)')
insert into #tmp001_split exec(@data)
select @item = 1 from #tmp001_split where item = 1 and dato = 'zz'
if @item = 1 select @data = dato from #tmp001_split where item = 2
else select @data = dato from #tmp001_split where item = 1

declare @Utabla tabla_generico
insert into @Utabla
exec dbo.usp_listar_tablas 'dbo.prog_tarjeta_multiflota'

;with tmp001_sep(t,r,i,a,item)as(
    select*,@item from(values('|','~','^','*'))t(sepCampo,sepReg,sepLst,sepAux)
)
,tmpAux_placaVehiculo(dato)as(
    select concat(i, 990, r, '300.0*0****101**Placa Interna:', r, '991|2*83|5*84|6*81|3*82|4')
    from tmp001_sep
)
,tmpAux_placaRodaje(dato)as(
    select concat(i, 991, r, '300.1*0****101**Placa Rodaje:', r, '990|1*83|5*84|6*81|3*82|4')
    from tmp001_sep
)
,hlp001_marcaModelo as(
    select t.Id_Vehiculo, ltrim(tt.DescripcionL) marca, ltrim(tm.DescripcionL) modelo,
    ltrim(tv.DescripcionL) tipovh, ltrim(toc.DescripcionL) octanaje
    from dbo.vehiculo t
    outer apply(select*from dbo.tipo_marca tt where tt.Id_TipoMarca = t.Id_TipoMarca) tt
    outer apply(select*from dbo.tipo_modelo tm where tm.Id_TipoModelo = t.Id_TipoModelo) tm
    outer apply(select*from dbo.tipo_vehiculo tv where tv.Id_TipoVehiculo = t.Id_TipoVehiculo) tv
    outer apply(select*from dbo.tipo_octanaje toc where toc.Id_TipoOctanaje = t.Id_TipoOctanaje) toc
)
,tmp001_cab(dato)as(
    select '~NRO TARJETA|FECHA ACTIVACION|FECHA CANCELACION|ACTIVO~400|200|200|200'
)
,tmp001_detalle_tarj_multiflota(dato)as(
    select concat(i, 18, c.dato, (select r, Nro_Tarjeta, t,
    convert(varchar, Fec_Activacion, 23), t, convert(varchar, Fec_cancelacion, 23), t,
    case activo when 1 then 'Act' else 'Desc' end
    from dbo.PROG_TARJETA_MULTIFLOTA where Id_Vehiculo = @data
    order by Id_Multiflota desc
    for xml path, type).value('.', 'varchar(max)'))
    from tmp001_sep, tmp001_cab c
)
,tmp001_grupos(dato)as(
    select stuff((select t, grupo, a, descr from(values
    (0,'DATOS VEHICULO :'), (1,'DATOS DE TARJETA :'))t(grupo,descr)
    for xml path, type).value('.','varchar(max)'),1,1,r)
    from tmp001_sep
)
,tmp001_meta(dato)as(
select concat(dato,
'|100.20*****101*81*Marca :*1*0+4.1|100.21*****101*82*Modelo :*1*0+4.2|\
100.22*****101*83*Tipo Vehículo:*1*0+4.3|100.23*****101*84*Tipo Octanaje:*1*0+4.4')
from dbo.udf_general_metadata(
't.Id_Multiflota..*100*10***0+55*****1,
t.Id_Vehiculo..*100*11***0+56*****1,
t.Placa_Interna.0.*151*990*Placa Interna :*1*0+3**1*1,
t.Placa_Rodaje..*151*991*Placa Rodaje :*1*0+4**1*1,
t.Nro_Tarjeta.0.*101*2*Nro Tarjeta :**1+5,
t.Fec_Activacion.0.*101*3*Fecha Activacion :*1*1+6,
t.Fec_Cancelacion..*101*4*Fecha Cancelación :*1*1+7,
t.Activo..*103*5*Activo :**1+8',
't.dbo.prog_tarjeta_multiflota',
@Utabla)
)
select concat((select
t.Id_Multiflota, t,
t.Id_Vehiculo, t,
t.Placa_Interna, t,
t.Placa_Rodaje, t,
t.Nro_Tarjeta, t,
convert(varchar, t.Fec_Activacion, 23), t,
convert(varchar, t.Fec_Cancelacion, 23), t,
t.Activo, t,
tt.marca, t, tt.modelo, t, tt.tipovh, t, tt.octanaje
from dbo.prog_tarjeta_multiflota t, hlp001_marcaModelo tt
where t.Id_Vehiculo = tt.Id_Vehiculo and estado = 1 and
t.Id_Vehiculo = @data
order by Id_Multiflota desc offset 0 rows fetch first 1 row only
for xml path, type).value('.', 'varchar(max)'),
m.dato, g.dato, t1.dato, t2.dato, t3.dato)
from tmp001_sep cross apply tmp001_meta m cross apply tmp001_grupos g
outer apply(select*from tmpAux_placaVehiculo where item=0) t1
outer apply(select*from tmpAux_placaRodaje where item=0) t2
outer apply(select*from tmp001_detalle_tarj_multiflota where item=1) t3

end try
begin catch
    select concat('error:', error_message())
end catch
end
go


declare @data varchar(100)
= 0
-- = 'zz|353253'


exec dbo.usp_listar_vehiculo_tarjeta_multiflota @data
