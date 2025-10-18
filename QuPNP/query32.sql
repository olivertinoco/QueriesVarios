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
declare @item tinyint = 0
create table #tmp001_split(
    item int identity,
    dato varchar(100)
)
select @data = concat('select*from(values(''', replace(@data, '|', '''),('''), '''))t(a)')
insert into #tmp001_split exec(@data)
select @item = 1 from #tmp001_split where item = 1 and dato = 'zz'
if @item = 1 select @data = dato from #tmp001_split where item = 2
else select @data = dato from #tmp001_split where item = 1

declare @Utabla tabla_generico
insert into @Utabla
exec dbo.usp_listar_tablas 'dbo.prog_extraord'

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~','^'))t(sepCampo,sepReg,sepLst)
)
,tmpAux_placaVehiculo(dato)as(
    select '~100.0*0****101**Placa Interna:'
)
,tmpAux_unidadSolicita(dato)as(
    select '~100.1*0****101**Unidad Destino:'
)
,tmpAux_cipConductor(dato)as(
    select '~100.6*0*1***101**CIP del Conductor:'
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
,hlp_TipoProgramacion(dato)as(
    select concat(i, 5, (select r, id, t, descr
    from(values(1, 'Programacion Ordinaria'),(2, 'Programacion ExtraOrdinaria'))t(id,descr)
    outer apply(select*from(values(1))tt(item) where tt.item = t.id)tt
    order by tt.item desc, t.descr
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp_TipoGrado(dato)as(
    select concat(i, 6, (select r, Id_TipoGrado, t, rtrim(DescripcionL)
    from dbo.tipo_grado where activo = 1 and estado = 1
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
,tmp001_meta(dato)as(
select concat(dato,
'|100.2*****101**Departamento:*1|100.3*****101**Provincia:*1|100.4*****101**Distrito:*1|100.5*****101**Nombres y Apellidos:*1')
from dbo.udf_general_metadata(
't.Id_ProgExtraOrd..*100,
t.Id_ProgVehiculo..*100,
t.Id_TipoProgramacion..*111*5*Tipo Programacion:**1,
t.Id_Vehiculo..*100,
t.Placa_Interna..*151*990*Placa Interna:*1*1*4,
t.Placa_Rodaje..*101**Placa Rodaje:*1,
t.Id_TipoCombustible..*111*1*Combustible:*1,
t.Id_TipoOctanaje..*111*2*Octanaje:*1,
t.Id_TipoDocumento..*111*3*Documento:,
t.Nro_Documento..*101**Nro Documento:,
t.Fec_Documento..*102**Fecha Documento:,
t.Nro_OrdenComision..*101**Nro Ord Comision:,
t.Fec_OrdenComision..*102**Fecha Ord Comision:,
t.CapacidadTanque..*101**Capacidad Tanque:,
t.RxGln..*101**Nro Galones:,
t.Fec_InicioComision..*102**Fecha Inicio Comision:,
t.Fec_TerminoComision..*102**Fecha Termino Comision:,
t.Motivo_Comision..*101**Motivo Comision:,
t.CIP_Conductor..*151*992*CIP Conductor:*1*1,
t.Grado_Conductor..*111*6*Grado Conductor:*1,
t.Id_UnidadSolicitante..*151*991*Unidad Solicitante:*1*1*4,
t.Recorrido_Ida..*101**Recorrido Ida:,
t.Recorrido_Retorno..*101**Recorrido Retorno:,
t.Total_Gln_Ida..*101**Total Galn Ida:,
t.Total_Gln_Retorno..*101**Total Galn Retorno:',
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
t.Id_TipoCombustible,t,
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
m.dato, t1.dato, t2.dato, t3.dato, t4.dato, t5.dato, t6.dato, t7.dato, t8.dato, t9.dato)
from tmp001_sep cross apply tmp001_meta m
outer apply(select*from hlp_TipoCombustible where @item=0) t1
outer apply(select*from hlp_TipoOctanaje where @item=0) t2
outer apply(select*from hlp_TipoDocumento where @item=0) t3
outer apply(select*from hlp_TipoParada where @item=0) t4
outer apply(select*from hlp_TipoProgramacion where @item=0) t5
outer apply(select*from hlp_placaVehiculo where @item=0) t6
outer apply(select*from hlp_unidadSolicita where @item=0) t7
outer apply(select*from hlp_cipConductor where @item=0) t8
outer apply(select*from hlp_TipoGrado where @item=0) t9

end try
begin catch
    select concat('error:', error_message())
end catch
end
go

exec dbo.usp_crud_prog_extraOrdinaria '0'

select*from dbo.PROG_EXTRAORD


select*from mastertable('dbo.PROG_EXTRAORD') order by column_id




return
select*from dbo.masterTablas
select*from dbo.masterAudit

return
select*from dbo.menu
select*from dbo.menuTransportes






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
