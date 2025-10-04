-- NOTA: CONSUMO DEL GENERICO
if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_crud_search_grupo_bien','p'))
drop procedure dbo.usp_crud_search_grupo_bien
go
create procedure dbo.usp_crud_search_grupo_bien
@data varchar(50)
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
,tmp001_meta(dato)as(
select dato from dbo.udf_general_metadata(
't.Id_GrupoBien..*100,
t.Id_TipoRegistro..*,
t.Id_TipoRubro..*,
t.Id_CatalogoBien..*,
t.Nombre_Bien..*,
t.Cod_Catalogo_Bien..*,
t.Id_TipoProcedencia..*,
t.Id_Tipo_EstadoRegistro..*,
t.Id_TipoEntidad..*,
t.CantidadTotal..*,
t.Id_TipoDonante..*,
t.ResolucionDonacion..*,
t.Id_TipoUnidadMedida..*,
t.Id_TipoFormaAdquisicion..*,
t.Id_TipoDocumento..*,
t.Nro_Documento..*,
t.Fec_Documento..*,
t.Activo..*,
t.Estado..*',
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
for xml path, type).value('.','varchar(max)'),1,1,''),m.dato)
from tmp001_sep, tmp001_meta m

end try
begin catch
    select concat('error: ', error_message())
end catch
end
go

exec dbo.usp_crud_search_grupo_bien 162

select*from dbo.grupo_bien where Id_GrupoBien = 146
