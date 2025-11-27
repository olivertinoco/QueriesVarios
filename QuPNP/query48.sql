if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_listar_prog_abastecimiento_diario','p'))
drop procedure dbo.usp_listar_prog_abastecimiento_diario
go
create procedure dbo.usp_listar_prog_abastecimiento_diario
@data varchar(100) = 0
as
begin
begin try
set nocount on
set language english
declare @item int = 0, @periodo_intervalo int = -2
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
exec dbo.usp_listar_tablas 'dbo.prog_abastecimiento_diario'

;with tmp001_sep(t,r,i,a,item)as(
    select*,@item from(values('|','~','^','*'))t(sepCampo,sepReg,sepLst,sepAux)
)
,tmp001_periodo(mes, anno) as(
    select right(100 + month(dateadd(mm, @periodo_intervalo, getdate())), 2),
    year(dateadd(mm, @periodo_intervalo, getdate()))
)
,tmp001_progVehiculo as(
    select t.Id_ProgVehiculo, tt.GlnxDia, tt.GlnxMes,
    ltrim(tv.DescripcionL) tipovh, ltrim(toc.DescripcionL) tipoComb
    from dbo.prog_vehiculo t cross apply dbo.prog_dotacion tt cross apply tmp001_periodo pp
    outer apply(select*from dbo.tipo_vehiculo tv where tv.Id_TipoVehiculo = t.Id_TipoVehiculo) tv
    outer apply(select*from dbo.tipo_combustible toc where toc.Id_TipoCombustible = t.Id_TipoCombustible) toc
    where t.Id_ProgVehiculo = tt.Id_ProgVehiculo and pp.anno = t.anio and pp.mes = t.mes
)
,tmp001_annos(dato)as(
    select concat(i, 1, (select distinct r, anio, t, anio from dbo.prog_vehiculo order by 1 desc
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_meses(dato)as(
    select concat(i, 2, (select r,
    right(concat('0', row_number()over(order by (select 1))),2), t, ttt.value
    from sys.syslanguages t cross apply dbo.udf_split(months,',')ttt
    outer apply(
    select 0 item from(values(format(getdate(), 'MMMM', 'es-es')))tt(mes) where tt.mes = ttt.value)tt
    where t.alias = 'Spanish'
    order by isnull(tt.item, 1)
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmpAux_Unidad(dato)as(
    select concat(i, 990, r, '300.0*0****101**Unidad /OO PNP :', r, '991|2*83|5*84|6*81|3*82|4')
    from tmp001_sep
)
-- ,tmpAux_grifo(dato)as(
--     select concat(i, 991, r, '300.1*0****101**Estación de Servicio:', r, '991|2*83|5*84|6*81|3*82|4')
--     from tmp001_sep
-- )
,tmpAux_placaVehiculo(dato)as(
    select concat(i, 992, r, '300.2*0****101**Placa Interna:', r, '991|2*83|5*84|6*81|3*82|4')
    from tmp001_sep
)
,tmpAux_placaRodaje(dato)as(
    select concat(i, 993, r, '300.3*0****101**Placa Rodaje:', r, '990|1*83|5*84|6*81|3*82|4')
    from tmp001_sep
)
,tmp001_cab_grifo(dato)as(
    select '~a1|RUC|NOMBRE|DIRECCION|DEPARTAMENTO|PROVINCIA|DISTRITO|NO~10|150|400|600|350|350|350|10'
)
,hlp001_dataGrifos(dato)as(
    select concat(i, 771, c.dato, (select r, t.id_grifo, t, t.Nro_RUC, t,
    rtrim(dbo.fn_LimpiarXML(t.NombreGrifo)), t, rtrim(t.direccion), t,
    rtrim(u.Departamento), t, rtrim(u.Provincia), t, rtrim(u.Distrito), t,
    rtrim(dbo.fn_LimpiarXML(t.NombreGrifo))
    from dbo.grifo t
    outer apply(select*from dbo.UBIGEO u where u.Id_Ubigeo =t.Id_Ubigeo)u
    where t.activo = 1 and t.estado = 1 order by t.Nro_RUC desc
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep, tmp001_cab_grifo c
)
,hlp001_unidad(dato)as(
    select concat(i, 990, (select r, ltrim(str(t.coduni, 10,0)), t, rtrim(t.descx_final)
    from dbo.prog_abastecimiento_diario tt, dbo.unidad_1 t
    where tt.activo = 1 and tt.Id_AbastecimientoDiario = @data
    and tt.Id_Unidad = t.coduni
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp001_grifo(dato)as(
    select concat(i, 771, (select r, t.id_grifo, t, rtrim(t.nombreGrifo)
    from dbo.prog_abastecimiento_diario tt, dbo.grifo t
    where tt.activo = 1 and tt.Id_AbastecimientoDiario = @data
    and tt.id_grifo = t.id_grifo
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_grupos(dato)as(
    select stuff((select t, grupo, a, descr from(values
    (0,'UNIDAD/OO PNP :'),(1,'DATO ESTACION SERVICIO :'),(2,'DATO VEHICULO :'),
    (3,'DOTACION PROGRAMADA MENSUAL :'),(4,'DOTACION CONSUMIDA POR DIA :'))t(grupo,descr)
    for xml path, type).value('.','varchar(max)'),1,1,r)
    from tmp001_sep
)
,tmp001_meta(dato)as(
select concat(dato,
'|100.13*****101*81*Nro Tarjeta Multiflota :*1*2+4.1|100.14*****101*82*Tipo Vehiculo :*1*2+4.2|\
100.15*****101*83*Tipo Combustible :*1*2+4.3|100.16*****101*84*Diario :*1*3+9|\
100.17*****101*85*Mensual :*1*3+10|100.18*****101*86*Acumulado :*1*4+13')
from dbo.udf_general_metadata(
't.Id_AbastecimientoDiario..*100*10***0+110*****1,
t.Id_ProgVehiculo..*100*11***0+111*****1,
t.Id_Unidad.0.*151*990*Unidad /OO PNP :*1*0+1*3*1*1,
t.Id_Grifo..*151*771*Estación de Servicio :*1*1+2*2*1*1*1500,
t.Id_Multiflota..*100*12***0+112*****1,
t.Anio..*111*1*Año :**2+5**1,
t.Mes..*111*2*Mes :**2+6**1,
t.Placa_Interna.0.*151*992*Placa Interna :*1*2+3**1*1,
t.Placa_Rodaje..*151*993*Placa Rodaje :*1*2+4**1*1,
t.Fec_Consumo..*111*3*Dia :**2+7,
t.Dotacion_Abastecida..*101*4*Abastecimiento :**4+12,
t.Saldo_x_Mes..*101*5*Saldo :*1*3+11',
't.dbo.prog_abastecimiento_diario',
@Utabla)
)
select concat((select
t.Id_AbastecimientoDiario, t,
t.Id_ProgVehiculo, t,
t.Id_Unidad, t,
t.Id_Grifo, t,
t.Id_Multiflota, t,
t.Anio, t,
t.Mes, t,
t.Placa_Interna, t,
t.Placa_Rodaje, t,
t.Fec_Consumo, t,
t.Dotacion_Abastecida, t,
t.Saldo_x_Mes, t,
tt.Nro_Tarjeta, t,
ttt.tipovh, t,
ttt.tipoComb, t,
ttt.GlnxDia, t,
ttt.GlnxMes
from dbo.prog_abastecimiento_diario t
outer apply(select*from dbo.prog_tarjeta_multiflota tt where tt.Id_Multiflota = t.Id_Multiflota)tt
outer apply(select*from tmp001_progVehiculo ttt where ttt.Id_ProgVehiculo = t.Id_ProgVehiculo)ttt
where t.activo = 1 and t.Id_AbastecimientoDiario = @data
for xml path, type).value('.', 'varchar(max)'),
m.dato, g.dato, u.dato, gr.dato, t1.dato, t3.dato, t4.dato, t5.dato, t6.dato, t7.dato)
from tmp001_sep cross apply tmp001_meta m cross apply tmp001_grupos g
cross apply hlp001_unidad u cross apply hlp001_grifo gr
outer apply(select*from tmpAux_Unidad where item=0) t1
-- outer apply(select*from tmpAux_grifo where item=0) t2
outer apply(select*from tmpAux_placaVehiculo where item=0) t3
outer apply(select*from tmpAux_placaRodaje where item=0) t4
outer apply(select*from hlp001_dataGrifos where item=0) t5
outer apply(select*from tmp001_annos where item=0) t6
outer apply(select*from tmp001_meses where item=0) t7


end try
begin catch
    select concat('error:', error_message())
end catch
end
go

exec dbo.usp_listar_prog_abastecimiento_diario 0

select*from dbo.menu order by 1


select*from mastertable('dbo.prog_abastecimiento_diario')
-- select*from mastertable('dbo.grifo')
select*from mastertable('dbo.prog_tarjeta_multiflota')

return
select*from mastertable('dbo.PROG_VEHICULO')
select*from mastertable('dbo.PROG_DOTACION')
