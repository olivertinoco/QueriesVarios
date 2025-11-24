
declare
@data varchar(100) = 0

declare @item int = 0
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
,tmpAux_placaVehiculo(dato)as(
    select concat(i, 992, r, '300.0*0****101**Placa Interna:', r, '991|2*83|5*84|6*81|3*82|4')
    from tmp001_sep
)
,tmpAux_placaRodaje(dato)as(
    select concat(i, 993, r, '300.1*0****101**Placa Rodaje:', r, '990|1*83|5*84|6*81|3*82|4')
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
select dato
from dbo.udf_general_metadata(
't.Id_AbastecimientoDiario..*100*10***0+110*****1,
t.Id_ProgDotacion..*100*11***0+111*****1,
t.Id_Unidad.0.*151*990*Unidad /OO PNP :*1*0+1**1*1,
t.Id_Grifo..*151*991*Estación de Servicio :*1*1+2**1*1,
t.Id_Multiflota..*100*12***0+112*****1,
t.Anio..*111*1*Año :*1*2+3,
t.Mes..*111*2*Mes :*1*2+4,
t.Id_vehiculo..*100*13***0+113*****1,
t.Placa_Interna.0.*151*992*Placa Interna :*1*2+5**1*1,
t.Placa_Rodaje..*151*993*Placa Rodaje :*1*2+6**1*1,
t.Fec_Consumo..*102*3*Fecha :**2+7,
t.Dotacion_Abastecida..*101*4*Abastecimiento :**4+9,
t.Saldo_x_Mes..*101*5*Saldo :**3+8',
't.dbo.prog_abastecimiento_diario',
@Utabla)
)
select concat((select
t.Id_AbastecimientoDiario, t,
t.Id_ProgDotacion, t,
t.Id_Unidad, t,
t.Id_Grifo, t,
t.Id_Multiflota, t,
t.Anio, t,
t.Mes, t,
t.Id_vehiculo, t,
t.Placa_Interna, t,
t.Placa_Rodaje, t,
t.Fec_Consumo, t,
t.Dotacion_Abastecida, t,
t.Saldo_x_Mes
from dbo.prog_abastecimiento_diario t
where t.Id_AbastecimientoDiario = @data
for xml path, type).value('.', 'varchar(max)'),
m.dato, g.dato)
from tmp001_sep cross apply tmp001_meta m cross apply tmp001_grupos g





return
select*from mastertable('dbo.prog_abastecimiento_diario')
select*from mastertable('dbo.prog_tarjeta_multiflota')
select*from mastertable('dbo.PROG_DOTACION')
