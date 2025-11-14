if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_crud_prog_extraOrdinaria','p'))
drop procedure dbo.usp_crud_prog_extraOrdinaria
go
create procedure dbo.usp_crud_prog_extraOrdinaria
@data varchar(100) = 0
as
begin
begin try
set nocount on
set language english
declare @item tinyint = 0, @param varchar(max)
select top 0 cast(null as varchar(max)) dato into #lista_hlp_prog_extraOrdinaria
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
exec dbo.usp_listar_tablas 'dbo.prog_extraord,dbo.prog_ruta,dbo.prog_eo_grifo'

;with tmp001_sep(t,r,i,a,item)as(
    select*,@item from(values('|','~','^','*'))t(sepCampo,sepReg,sepLst,sepAux)
)
,tmp001_param(dato)as(
    select concat('990|991|992', r,
    rtrim(t.Placa_Interna), t, rtrim(t.Id_UnidadSolicitante), t, rtrim(t.CIP_Conductor))
    from dbo.PROG_EXTRAORD t, tmp001_sep where t.Id_ProgExtraOrd = @data and item=1
)
select @param = dato from tmp001_param
exec dbo.usp_lista_hlp_prog_extraOrdinaria @param

;with tmp001_sep(t,r,i,a,item)as(
    select*,@item from(values('|','~','^','*'))t(sepCampo,sepReg,sepLst,sepAux)
)
,tmpAux_placaVehiculo(dato)as(
    select '~300.0*0****101**Placa Interna:~11|2*12|3*7|7*1|4*2|5'
)
,tmpAux_unidadSolicita(dato)as(
    select '~300.1*0****101**Unidad Destino:***3~26|3*27|4*28|5'
)
,tmpAux_unidad(dato)as(
    select '~400.0*0****101**Unidad:***3~30|3*31|4*32|5'
)
,tmpAux_cipConductor(dato)as(
    select '~300.6*0*1***101**CIP del Conductor:~6|2*29|4'
)
,tmpAux_metaDataGrifo(dato)as(
select '~300.23*1****151*701*Nombre del Grifo:*1**2*1*1*1200|300.25*****101*702*Departamento:*1|\
300.26*****101*703*Provincia:*1|300.27*****101*704*Distrito:*1|\
300.21*1***3*101*705*Dotación (Gln):|300.22*****102*706*Abastecimiento:'
)
,hlp_TipoCombustible(dato)as(
    select concat(i, 1, (select r, rtrim(Id_TipoCombustible), t, rtrim(DescripcionL)
    from dbo.TIPO_COMBUSTIBLE where activo = 1 and estado = 1 order by 2
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp_TipoOctanaje(dato)as(
    select concat(i, 2, (select r, Id_TipoOctanaje, t, rtrim(DescripcionL)
    from dbo.TIPO_OCTANAJE where activo = 1 and estado = 1 order by 2
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp_TipoDocumento(dato)as(
    select concat(i, 3, (select r, Id_TipoDocumento, t, rtrim(DescripcionL)
    from dbo.TIPO_DOCUMENTO where activo = 1 and estado = 1 order by 2
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp_TipoParada(dato)as(
    select concat(i, 4, (select r, Id_TipoParada, t, rtrim(DescripcionL)
    from dbo.TIPO_PARADA where estado = 1 and activo = 1 order by 2
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_cab_grifo(dato)as(
    select '~a1|RUC|NOMBRE|DIRECCION|DEPARTAMENTO|PROVINCIA|DISTRITO|NOMBRE~10|150|400|600|350|350|350|10'
)
,hlp_grifos(dato)as(
    select concat(i, 77, m.dato, c.dato, (select r, t.id_grifo, t, t.Nro_RUC, t,
    rtrim(dbo.fn_LimpiarXML(t.NombreGrifo)), t, rtrim(t.direccion), t,
    rtrim(u.Departamento), t, rtrim(u.Provincia), t, rtrim(u.Distrito), t,
    rtrim(dbo.fn_LimpiarXML(t.NombreGrifo))
    from dbo.grifo t
    outer apply(select*from dbo.UBIGEO u where u.Id_Ubigeo =t.Id_Ubigeo)u
    where t.activo = 1 and t.estado = 1 order by t.Nro_RUC desc
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep, tmp001_cab_grifo c, tmpAux_metaDataGrifo m
)
,hlp_TipoProgramacion(dato)as(
    select concat(i, 5, (select r, id, t, descr
    from(values(1, 'Programación Ordinaria'),(2, 'Programación ExtraOrdinaria'))t(id,descr)
    outer apply(select*from(values(1))tt(item) where tt.item = t.id)tt
    order by tt.item desc, t.descr
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp_TipoGrado(dato)as(
    select concat(i, 6, (select r, Id_TipoGrado, t, rtrim(DescripcionL)
    from dbo.tipo_grado -- where activo = 1 and estado = 1
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp_placaVehiculo(dato)as(
    select concat(i, 990, t.dato) from tmpAux_placaVehiculo t, tmp001_sep
)
,hlp_unidadSolicita(dato)as(
    select concat(i, 991, t.dato) from tmpAux_unidadSolicita t, tmp001_sep
)
,hlp_cipConductor(dato)as(
    select concat(i, 992, t.dato) from tmpAux_cipConductor t, tmp001_sep
)
,hlp_unidad(dato)as(
    select concat(i, 993, t.dato) from tmpAux_unidad t, tmp001_sep
)
,tmp001_cab_prog_ruta(dato)as(
select '~dato|a1|a2|a3|a4|a5|a6|a7|a8|a9|a10|UNIDAD|MOVIMIENTO|OBSERVACION~10|10|10|10|10|10|10|10|10|10|10|600|200|300'
)
,tmp001_prog_ruta(dato)as(
select stuff((select '+', substring(t.value, 0, charindex(a, t.value))
from dbo.udf_general_metadata(
'tt.Id_ProgRuta..*,
tt.Id_ProgExtraOrd..*,
tt.Id_TipoParada..*,
tt.Id_Unidad..*,
tt.Observaciones..*,
tt.Dias_Permanencia..*,
tt.activo..*',
'tt.dbo.prog_ruta',
@Utabla)tt cross apply dbo.udf_split(tt.dato, default)t
for xml path, type).value('.','varchar(max)'),1,2,r)
from tmp001_sep
)
,info001_prog_ruta(dato)as(
    select concat(i, 741, r.dato, c.dato, (select r.dato, t,
    t.Id_ProgRuta, t,
    t.Id_ProgExtraOrd, t,
    t.Id_TipoParada, t,
    t.Id_Unidad, t,
    rtrim(t.Observaciones), t,
    t.Dias_Permanencia, t,
    t.activo, t,
    rtrim(u.Departamento), t, rtrim(u.Provincia), t, rtrim(u.Distrito), t,
    rtrim(tt.descx_final), t, rtrim(ttt.DescripcionL), t, rtrim(t.Observaciones)
    from dbo.prog_ruta t, dbo.unidad_1 tt, dbo.ubigeo u, dbo.tipo_parada ttt
    where t.Id_Unidad = tt.coduni and right(cast(1000000 + tt.ubigeo as int), 6) = u.Id_Ubigeo
    and t.id_tipoParada = ttt.id_tipoParada and t.activo = 1 and t.estado = 1
    and t.Id_ProgExtraOrd = @data order by t.Id_ProgRuta
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep, tmp001_cab_prog_ruta c, tmp001_prog_ruta r
)
,tmp001_grupos(dato)as(
    select stuff((select t, grupo, a, descr from(values
    (0,'TIPO PROGRAMACION :'),(1,'DATO VEHICULO :'),
    (2,'DATO COMISION :'),(3,'DATO CONDUCTOR (opcional) :'),(4,'RUTA :'))t(grupo,descr)
    for xml path, type).value('.','varchar(max)'),1,1,r)
    from tmp001_sep
)
,tmp001_meta(dato)as(
select concat(dato,
'|100.2*****101*26*Departamento:*1*2+6|100.3*****101*27*Provincia:*1*2+7|\
100.4*****101*28*Distrito:*1*2+8|100.5*****101*29*Nombres y Apellidos:*1*3+25*2|\
100.6*****151*993*UNIDAD:*1*4+26*2*1*6|100.7*****101*30*Departamento:*1*4+27|\
100.8*****101*31*Provincia:*1*4+28|100.9*****101*32*Distrito:*1*4+29|\
100.10*****111*4*Tipo Movimiento:**4+30|100.11*****101*34*Observación:**4+31*2|\
100.12**1***101*35*Dias Permanencia :**4+32')
from dbo.udf_general_metadata(
't.Id_ProgExtraOrd..*100*10***0+1,
t.Id_ProgVehiculo..*100*11***0+2,
t.Id_TipoProgramacion..*111*5*Tipo Programación:**0+0**1,
t.Id_Vehiculo..*100*12***0+3,
t.Placa_Interna..*151*990*Placa Interna:*1*1+1**1*6,
t.Placa_Rodaje..*101*7*Placa Rodaje:*1*1+2,
t.Id_TipoCombustible..*111*1*Combustible:*1*1+3,
t.Id_TipoOctanaje..*111*2*Octanaje:*1*1+4,
t.Id_TipoDocumento..*111*3*Documento:**2+9,
t.Nro_Documento..*101*13*Nro Documento:**2+10,
t.Fec_Documento..*102*14*Fecha Documento:**2+11,
t.Nro_OrdenComision..*101*15*Nro Ord Comisión:**2+14,
t.Fec_OrdenComision..*102*16*Fecha Ord Comisión:**2+15,
t.CapacidadTanque..*101*17*Capacidad Tanque:**2+12,
t.RxGln..*101*18*Nro Galones:**2+13,
t.Fec_InicioComision..*102*19*Fecha Inicio Comisión:**2+16,
t.Fec_TerminoComision..*102*20*Fecha Termino Comisión:**2+17,
t.Motivo_Comision..*101*21*Motivo Comisión:**2+18*3,
t.CIP_Conductor..*151*992*CIP Conductor:*1*3+23**1*3,
t.Grado_Conductor..*111*6*Grado Conductor:*1*3+24,
t.Id_UnidadSolicitante..*151*991*Unidad Solicitante:*1*2+5*3*1*6,
t.Recorrido_Ida..*101*22*Recorrido Ida (Km):**2+19,
t.Recorrido_Retorno..*101*23*Recorrido Retorno (km):**2+20,
t.Total_Gln_Ida..*101*24*Total Galones Ida (Gln):**2+21,
t.Total_Gln_Retorno..*101*25*Total Galones Retorno (Gln):**2+22',
't.dbo.prog_extraord',
@Utabla)
)
select concat((select
t.Id_ProgExtraOrd, t,
t.Id_ProgVehiculo, t,
t.Id_TipoProgramacion,t,
t.Id_Vehiculo,t,
t.Placa_Interna,t,
t.Placa_Rodaje,t,
rtrim(t.Id_TipoCombustible),t,
t.Id_TipoOctanaje,t,
t.Id_TipoDocumento,t,
t.Nro_Documento,t,
convert(varchar, t.Fec_Documento, 23), t,
t.Nro_OrdenComision,t,
convert(varchar, t.Fec_OrdenComision, 23), t,
t.CapacidadTanque,t,
t.RxGln,t,
convert(varchar, t.Fec_InicioComision, 23), t,
convert(varchar, t.Fec_TerminoComision, 23), t,
t.Motivo_Comision,t,
t.CIP_Conductor,t,
t.Grado_Conductor,t,
t.Id_UnidadSolicitante,t,
t.Recorrido_Ida,t,
t.Recorrido_Retorno,t,
t.Total_Gln_Ida,t,
t.Total_Gln_Retorno
from dbo.PROG_EXTRAORD t where t.Id_ProgExtraOrd = @data
for xml path, type).value('.','varchar(max)'),
m.dato, g.dato, t1.dato, t2.dato, t3.dato, t4.dato, t5.dato, t6.dato,
t7.dato, t8.dato, t9.dato, t10.dato, t11.dato, t12.dato, t13.dato, t14.dato)
from tmp001_sep cross apply tmp001_meta m cross apply tmp001_grupos g
cross apply dbo.udf_detalle_prog_eo_grifo(@data, @Utabla)t14
outer apply(select*from hlp_TipoCombustible where item=0) t1
outer apply(select*from hlp_TipoOctanaje where item=0) t2
outer apply(select*from hlp_TipoDocumento where item=0) t3
outer apply(select*from hlp_TipoParada where item=0) t4
outer apply(select*from hlp_TipoProgramacion where item=0) t5
outer apply(select*from hlp_placaVehiculo where item=0) t6
outer apply(select*from hlp_unidadSolicita where item=0) t7
outer apply(select*from hlp_cipConductor where item=0) t8
outer apply(select*from hlp_TipoGrado where item=0) t9
outer apply(select*from hlp_unidad where item=0) t11
outer apply(select*from hlp_grifos where item=0) t13
outer apply(select*from #lista_hlp_prog_extraOrdinaria)t10
outer apply(select*from info001_prog_ruta) t12

end try
begin catch
    select concat('error:', error_message())
end catch
end
go

exec dbo.usp_crud_prog_extraOrdinaria '0'
-- exec dbo.usp_crud_prog_extraOrdinaria 'zz|3'


return
select*from dbo.prog_ruta
select*from dbo.mastertable('dbo.prog_ruta')

-- select*from mastertable('dbo.PROG_EXTRAORD') order by column_id




-- return
-- select*from dbo.masterTablas
-- select*from dbo.masterAudit

-- return
-- select*from dbo.menu
-- select*from dbo.menuTransportes






return
set rowcount 20


select Id_TipoOctanaje, DescripcionL from dbo.TIPO_OCTANAJE
select*from dbo.TIPO_DOCUMENTO
select*from dbo.UNIDAD
select*from dbo.MasterPNP


-- select*from mastertable('dbo.PROG_VEHICULO') order by column_id
-- select*from mastertable('dbo.VEHICULO') order by column_id




-- select*from dbo.PROG_RUTA
-- select*from dbo.PROG_EO_GRIFO
-- select*from dbo.PROG_EXTRAORD
-- select Id_Grifo, NombreGrifo, Id_Ubigeo, Direccion from dbo.Grifo


-- PROG_VEHICULO
-- MasterLicencia
-- MasterPNP
