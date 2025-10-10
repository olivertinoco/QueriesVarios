if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_crud_vehiculo','p'))
drop procedure dbo.usp_crud_vehiculo
go
create procedure dbo.usp_crud_vehiculo
@data varchar(50) = null
as
begin
set nocount on
set language english
begin try

declare @Utabla tabla_generico
insert into @Utabla
exec dbo.usp_listar_tablas 'dbo.vehiculo'

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~','^'))t(sepCampo,sepReg,sepLst)
)
,tmpCab_carroceria(cab)as(
    select '~Carroceria|Descripcion~100|350'
)
,tmpCab_adquisicion(cab)as(
    select '~Obs. Adquisicion|Descripcion~100|350'
)
,tmpCab_categoria(cab)as(
    select '~Categoria|Carroceria|Descripcion~100|100|350'
)
,tmpCab_marca(cab)as(
    select '~Marca|Descripcion~100|350'
)
,tmpCab_color(cab)as(
    select '~Color|Descripcion~100|350'
)
,tmpCab_modelo(cab)as(
    select '~Modelo|Marca|Descripcion~100|100|350'
)
,hlp_tipo_vehiculo(dato)as(
    select concat(i, 1, (select r, Id_TipoVehiculo, t, DescripcionL, t, Id_ClaseVehiculo, t, Id_TipoClasificacionBien
    from dbo.tipo_vehiculo where activo = 1 and estado = 1
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp_tipo_carroceria(dato)as(
    select concat(i, 2, c.cab, (select r, rtrim(Id_TipoCarroceria), t, rtrim(DescripcionL)
    from dbo.tipo_carroceria  where activo = 1 and estado = 1
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep, tmpCab_carroceria c
)
,hlp_tipo_categoria(dato)as(
    select concat(i, 3, c.cab, (select r, rtrim(Id_TipoCategoria), t, rtrim(Id_TipoCarroceria), t, rtrim(DescripcionL)
    from dbo.tipo_categoria  where activo = 1 and estado = 1
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep, tmpCab_categoria c
)
,hlp_tipo_marca(dato)as(
    select concat(i, 4, c.cab, (select r, Id_TipoMarca, t, DescripcionL
    from dbo.tipo_marca  where activo = 1 and estado = 1
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep, tmpCab_marca c
)
,hlp_tipo_modelo(dato)as(
    select concat(i, 5, c.cab, (select r, Id_TipoModelo, t, Id_TipoMarca, t, DescripcionL
    from dbo.tipo_modelo  where activo = 1 and estado = 1
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep, tmpCab_modelo c
)
,hlp_tipo_color(dato)as(
    select concat(i, 6, c.cab, (select r, Id_TipoColor, t, rtrim(dbo.fn_LimpiarXML(DescripcionL))
    from dbo.tipo_color   where activo = 1 and estado = 1
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep, tmpCab_color c
)
,hlp_tipo_transmision(dato)as(
    select concat(i, 7, (select r, Id_TipoTransmision, t, DescripcionL
    from dbo.tipo_transmision where activo = 1 and estado = 1
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp_tipo_combustible(dato)as(
    select concat(i, 8, (select r, Id_TipoCombustible, t, DescripcionL
    from dbo.tipo_combustible where activo = 1 and estado = 1
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp_tipo_octanaje(dato)as(
    select concat(i, 9, (select r, Id_TipoOctanaje, t, DescripcionL
    from dbo.tipo_octanaje where activo = 1 and estado = 1
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp_tipo_formula_rodante(dato)as(
    select concat(i, 10, (select r, Id_FormulaRodante, t, DescripcionL
    from dbo.tipo_formula_rodante where activo = 1 and estado = 1
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp_tipo_zona_registral(dato)as(
    select concat(i, 11, (select r, Id_TipoZonaRegistral, t, DescripcionL
    from dbo.tipo_zona_registral where activo = 1 and estado = 1
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp_tipo_funcion(dato)as(
    select concat(i, 12, (select r, Id_TipoFuncion, t, DescripcionL
    from dbo.tipo_funcion where activo = 1 and estado = 1
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp_tipo_situacion_especial(dato)as(
    select concat(i, 13, (select r, Id_TipoSituacionEspecial, t, DescripcionL
    from dbo.tipo_situacion_especial where activo = 1 and estado = 1
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp_tipo_obs_adquisicion(dato)as(
    select concat(i, 14, c.cab, (select r, Id_TipoObsAdquisicion, t, DescripcionL
    from dbo.tipo_obs_adquisicion where activo = 1 and estado = 1 and Id_TipoObsAdquisicion != 0
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep, tmpCab_adquisicion c
)
,hlp_tipo_propietario(dato)as(
    select concat(i, 15, (select r, Id_TipoPropietario, t, DescripcionL
    from dbo.tipo_propietario where activo = 1 and estado = 1
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp_tipo_modalidad_ingreso(dato)as(
    select concat(i, 16, (select r, Id_Tipo_ModalidadIngreso, t, DescripcionL
    from dbo.tipo_modalidad_ingreso where estado = 1
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,hlp_tipo_documento(dato)as(
    select concat(i, 0, (select r, Id_TipoDocumento, t, rtrim(DescripcionL)
    from dbo.tipo_documento where activo = 1 and estado = 1
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_meta(dato)as(
select dato from dbo.udf_general_metadata(
't.Id_Vehiculo..*100,
t.Id_GrupoBien..*,
t.Placa_Interna..*101**Placa Interna:,
t.Placa_Rodaje..*101**Placa Rodaje:,
t.Placa_Anterior..*101**Placa Anterior:,
t.Id_TipoVehiculo..*111*1*Tipo Vehiculo:**1,
t.Id_TipoCarroceria..*111*2*Carroceria:,
t.Id_TipoCategoria..*151*3*Seleccion Categoria**1*2,
t.Id_TipoMarca..*151*4*Seleccion Marca:**1,
t.Id_TipoModelo..*151*5*Seleccion Modelo:**1*2,
t.Anio_Modelo..*101**Anno Modelo:,
t.Anio_Fabricacion..*101**Anno Fabricacion:,
t.Id_TipoColor..*151*6*Seleccion Color:**1,
t.Nro_Motor..*101**Nro. Motor:,
t.Nro_Serie..*101**Nro. Serie:,
t.Precio..*101**Precio:,
t.Id_TipoTransmision..*111*7*Transmision:,
t.Nro_Asientos..*101**Nro Asientos:,
t.Nro_Puertas..*101**Nro Puertas:,
t.Nro_Llantas..*101**Nro Llantas:,
t.Nro_Pasajeros..*101**Nro Pasajeros:,
t.Id_TipoCombustible..*111*8*Combustible:,
t.Id_TipoOctanaje..*111*9*Octanaje:,
t.Cilindrada..*101**Cilindrada:,
t.Nro_Cilindros..*101**Nro Cilindros:,
t.Nro_Ejes..*101**Nro Ejes:,
t.Version..*101**Version:,
t.Id_FormulaRodante..*111*10*Formula Rodante:,
t.Potencia..*101**Potencia:,
t.Longitud..*101**Longitud:,
t.Altura..*101**Altura:,
t.Ancho..*101**Ancho:,
t.Peso_Bruto..*101**Peso Bruto:,
t.Peso_Neto..*101**Peso Neto:,
t.CargaUtil..*101**Carga Util:,
t.NroLectorHuella..*101**Nro Lector Huella:,
t.NroSerieTablet..*101**Nro Serie Tablet:,
t.NroSerieCamaraIdentificacion..*101**Nro Serie Camara:,
t.Id_TipoZonaRegistral..*111*11*Zona Registrar:,
t.Id_TipoFuncion..*111*12*Tipo Funcion:,
t.Id_TipoSituacionEspecial..*111*13*Situacion Especial:,
t.Id_TipoObsAdquisicion..*151*14*Seleccion Obs. Adquisicion:**1,
t.Id_TipoPropietario..*111*15*Procedencia:,
t.Nro_TarjetaPropiedad..*101**Tarjeta Propiedad:,
t.Id_TipoModalidadIngreso..*111*16*Modalidad Ingreso:,
t.CUI..*101**CUI:,
t.Anio_Adquirido..*101**Anno Adquisicion:,
t.Fec_Adquisicion..*102**Fecha Adquision:,
t.Fec_Expedicion_Tarjeta..*102**Fecha Adq. Tarjeta:',
't.dbo.vehiculo',
@Utabla)
)
select concat((select
t.Id_Vehiculo, t,
t.Id_GrupoBien, t,
t.Placa_Interna, t,
t.Placa_Rodaje, t,
t.Placa_Anterior, t,
t.Id_TipoVehiculo, t,
t.Id_TipoCarroceria, t,
t.Id_TipoCategoria, t,
t.Id_TipoMarca, t,
t.Id_TipoModelo, t,
t.Anio_Modelo, t,
t.Anio_Fabricacion, t,
t.Id_TipoColor, t,
t.Nro_Motor, t,
t.Nro_Serie, t,
t.Precio, t,
t.Id_TipoTransmision, t,
t.Nro_Asientos, t,
t.Nro_Puertas, t,
t.Nro_Llantas, t,
t.Nro_Pasajeros, t,
t.Id_TipoCombustible, t,
t.Id_TipoOctanaje, t,
t.Cilindrada, t,
t.Nro_Cilindros, t,
t.Nro_Ejes, t,
t.Version, t,
t.Id_FormulaRodante, t,
t.Potencia, t,
t.Longitud, t,
t.Altura, t,
t.Ancho, t,
t.Peso_Bruto, t,
t.Peso_Neto, t,
t.CargaUtil, t,
t.NroLectorHuella, t,
t.NroSerieTablet, t,
t.NroSerieCamaraIdentificacion, t,
t.Id_TipoZonaRegistral, t,
t.Id_TipoFuncion, t,
t.Id_TipoSituacionEspecial, t,
t.Id_TipoObsAdquisicion, t,
t.Id_TipoPropietario, t,
t.Nro_TarjetaPropiedad, t,
t.Id_TipoModalidadIngreso, t,
t.CUI, t,
t.Anio_Adquirido, t,
convert(varchar, t.Fec_Adquisicion, 23), t,
convert(varchar, t.Fec_Expedicion_Tarjeta, 23)
from dbo.vehiculo t where t.Id_Vehiculo = @data
for xml path, type).value('.','varchar(max)'),
m.dato, t1.dato, t2.dato, t3.dato, t4.dato, t5.dato, t6.dato,
t7.dato, t8.dato, t9.dato, t10.dato, t11.dato, t12.dato, t13.dato,
t14.dato, t15.dato, t16.dato)
from tmp001_sep, tmp001_meta m,
hlp_tipo_vehiculo t1,
hlp_tipo_carroceria t2,
hlp_tipo_categoria t3,
hlp_tipo_marca t4,
hlp_tipo_modelo t5,
hlp_tipo_color t6,
hlp_tipo_transmision t7,
hlp_tipo_combustible t8,
hlp_tipo_octanaje t9,
hlp_tipo_formula_rodante t10,
hlp_tipo_zona_registral t11,
hlp_tipo_funcion t12,
hlp_tipo_situacion_especial t13,
hlp_tipo_obs_adquisicion t14,
hlp_tipo_propietario t15,
hlp_tipo_modalidad_ingreso t16

end try
begin catch
    select concat('error:', error_message())
end catch
end
go


declare
@data varchar(100)
= 335287

exec dbo.usp_crud_vehiculo @data

update t set Id_TipoVehiculo = null from dbo.vehiculo t where Id_Vehiculo = @data


select*from dbo.vehiculo where Id_Vehiculo = @data


-- t.IdDocumentoCambio..*,
-- t.OficinaRegistral..*,
-- t.PartidaRegistral..*,
-- t.DuaDam..*,
-- t.Titulo..*,
-- t.FechaTitulo..*,
-- t.Condicion..*,
-- t.VigenciaTemporal..*,
-- t.CodigoSunarp..*',




-- go
-- CREATE FUNCTION dbo.fn_LimpiarXML (@Texto VARCHAR(MAX))
-- RETURNS VARCHAR(MAX)
-- AS
-- BEGIN
--     DECLARE @i INT = 0
--     WHILE @i <= 31
--     BEGIN
--         IF @i NOT IN (9, 10, 13)
--             SET @Texto = REPLACE(@Texto, CHAR(@i), '')
--         SET @i += 1
--     END
--     RETURN @Texto
-- END
-- GO
