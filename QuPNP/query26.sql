-- NOTA: CONSUMO DEL GENERICO
if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_crud_grupo_bien','p'))
drop procedure dbo.usp_crud_grupo_bien
go
create procedure dbo.usp_crud_grupo_bien
@data varchar(50) = null
as
begin
set nocount on
set language english
begin try

declare @Utabla tabla_generico
insert into @Utabla
exec dbo.usp_listar_tablas 'dbo.grupo_bien'

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~','^'))t(sepCampo,sepReg,sepLst)
)
,hlp001_tipo_registro(dato) as(
    select concat(i, 1, (select r, id_tipoRegistro, t, rtrim(DescripcionL) from dbo.tipo_registro
    where activo = 1 and estado = 1 order by DescripcionL
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp001_tipo_rubro(dato)as(
    select concat(i, 2, (select r, id_tipoRubro, t, rtrim(DescripcionL) from dbo.tipo_rubro
    where activo = 1 and estado = 1 order by DescripcionL
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp001_tipo_estado_registro(dato)as(
    select concat(i, 3, (select r, id_tipo_estadoRegistro, t, rtrim(DescripcionL) from dbo.tipo_estado_registro
    where activo = 1 and estado = 1 order by DescripcionL
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp001_tipo_entidad(dato)as(
    select concat(i, 4, (select r, id_tipoEntidad, t, rtrim(DescripcionL) from dbo.tipo_entidad
    where activo = 1 and estado = 1 order by DescripcionL
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp001_tipo_forma_adquisicion(dato)as(
    select concat(i, 5, (select r, id_tipoFormaAdquisicion, t, rtrim(DescripcionL) from dbo.tipo_forma_adquisicion
    where activo = 1 and estado = 1 order by DescripcionL
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp001_tipo_procedencia(dato)as(
    select concat(i, 6, (select r, id_tipoProcedencia, t, rtrim(DescripcionL) from dbo.tipo_procedencia
    where activo = 1 and estado = 1 order by DescripcionL
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp001_tipo_unidad_medida(dato)as(
    select concat(i, 7, (select r, id_tipoUnidadMedida, t, rtrim(DescripcionL) from dbo.tipo_unidad_medida
    where activo = 1 and estado = 1 order by DescripcionL
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp001_tipo_documento(dato)as(
    select concat(i, 8, (select r, id_tipoDocumento, t, rtrim(DescripcionL) from dbo.tipo_documento
    where activo = 1 and estado = 1 order by DescripcionL
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp001_tipo_donante(dato)as(
    select concat(i, 10, (select r, id_tipoDonante, t, rtrim(DescripcionL) from dbo.tipo_donante
    where activo = 1 and estado = 1 order by DescripcionL
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp001_tipo_grupo_bien(dato)as(
    select concat(i, 9, (select r, Id_TipoGrupoBien, t, rtrim(DescripcionL) from dbo.tipo_grupo_bien
    where estado = 1 order by DescripcionL
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp001_catalogo_bien(dato)as(
    select concat(i, 11, (select r, Id_TipoGrupoBien, t, Id_CatalogoBien, t, rtrim(Descripcion), t, Cod_Catalogo_Bien
    from dbo.catalogo_bien where estado = 1 order by Descripcion
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_meta(dato)as(
select*from dbo.udf_general_metadata(
't.Id_GrupoBien..*100,
t.Id_TipoRegistro..*111*1*Tipo Regristro:,
t.Id_TipoRubro.0.*111*2*Tipo Rubro:,
t.Id_CatalogoBien..*150*11*Seleccione Catalogo:,
t.Nombre_Bien..20*101**Nombre Bien:,
t.Cod_Catalogo_Bien..*101**Codigo Catalogo:*1,
t.Id_TipoProcedencia..*111*6*Tipo Procedencia,
t.Id_Tipo_EstadoRegistro..*111*3*Tipo Estado Registro:,
t.Id_TipoEntidad..*111*4*Tipo Entidad:,
t.CantidadTotal..*101**Cantidad Total:,
t.Id_TipoDonante..*150*10*Seleccion Tipo Donante:,
t.ResolucionDonacion..*101**Resolucion Donante:,
t.Id_TipoUnidadMedida..*150*7*Seleccion Unidad Medida:,
t.Id_TipoFormaAdquisicion..*111*5*Tipo Forma Adquisicion:,
t.Id_TipoDocumento..*150*8*Seleccion Tipo Documento:,
t.Nro_Documento..*101**Nro Documento:,
t.Fec_Documento..*102**Fecha Documento:,
t.Activo..*103**Check Activo:,
t.Estado..*103**Check Estado:',
't.dbo.grupo_bien',
@Utabla)
)
select concat(stuff((select r,
t.Id_GrupoBien, t,
t.Id_TipoRegistro, t,
t.Id_TipoRubro, t,
t.Id_CatalogoBien, t,
t.Nombre_Bien, t,
t.Cod_Catalogo_Bien, t,
t.Id_TipoProcedencia, t,
t.Id_Tipo_EstadoRegistro, t,
t.Id_TipoEntidad, t,
t.CantidadTotal, t,
t.Id_TipoDonante, t,
t.ResolucionDonacion, t,
t.Id_TipoUnidadMedida, t,
t.Id_TipoFormaAdquisicion, t,
t.Id_TipoDocumento, t,
t.Nro_Documento, t,
convert(varchar, t.Fec_Documento, 23), t,
t.Activo, t,
t.Estado
from dbo.grupo_bien t where t.Id_GrupoBien = @data
for xml path, type).value('.','varchar(max)'),1,1,''),
m.dato, t1.dato, t2.dato, t3.dato, t4.dato, t5.dato, t6.dato,
t7.dato, t8.dato, t9.dato, t10.dato, t11.dato)
from tmp001_sep, tmp001_meta m,
hlp001_tipo_registro t1,
hlp001_tipo_rubro t2,
hlp001_tipo_estado_registro t3,
hlp001_tipo_entidad t4,
hlp001_tipo_forma_adquisicion t5,
hlp001_tipo_procedencia t6,
hlp001_tipo_unidad_medida t7,
hlp001_tipo_documento t8,
hlp001_tipo_grupo_bien t9,
hlp001_tipo_donante t10,
hlp001_catalogo_bien t11

end try
begin catch
    select concat('error: ', error_message())
end catch
end
go

exec dbo.usp_crud_grupo_bien 146


declare @Utabla tabla_generico
insert into @Utabla
exec dbo.usp_listar_tablas 'dbo.grupo_bien'
select*from @Utabla


select*from mastertable('dbo.grupo_bien')

set rowcount 10
select*from dbo.grupo_bien
