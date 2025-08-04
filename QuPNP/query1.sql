RETURN
-- alter table dbo.Unidad add UltimaUnidad varchar(2000)


select*from dbo.mastertable('dbo.VEHICULO')
select*from dbo.mastertable('dbo.ASIGNAR_VEHICULO_UNIDAD')
select*from dbo.mastertable('dbo.UNIDAD')
select*from dbo.mastertable('dbo.OPERATIVIDAD_VEHICULO')


select*from dbo.mastertable('dbo.TIPO_VEHICULO')
select*from dbo.mastertable('dbo.TIPO_MARCA')
select*from dbo.mastertable('dbo.TIPO_MODELO')
select*from dbo.mastertable('dbo.TIPO_COLOR')
select*from dbo.mastertable('dbo.TIPO_TRANSMISION')
select*from dbo.mastertable('dbo.TIPO_COMBUSTIBLE')

-- select hashbytes('sha2_256',concat(Id_Vehiculo, Placa_Interna)) id, Id_Vehiculo, Placa_Interna, Placa_Rodaje
-- from dbo.VEHICULO

-- NOTA: REFERENCIA A FOREIGN KEYS DE TABLAS
-- =========================================

-- select name, object_name(parent_object_id) u_ori, object_name(referenced_object_id) u_ref
-- from sys.foreign_keys order by 1


select
object_name(parent_object_id) u_padre,
col_name(parent_object_id, parent_column_id) campo_padre,
object_name(referenced_object_id) u_referenciada,
col_name(referenced_object_id, referenced_column_id) campo_referenciada
from sys.foreign_key_columns
where constraint_object_id = object_id('FK_ASIGNAR_VEHICULO_COMANDO_MASPOL')

select*from mastertable('dbo.ASIGNAR_VEHICULO_COMANDO')
select*from mastertable('dbo.MASPOL')


select tt.name, tt.recovery_model_desc, t.name, t.physical_name,
convert(decimal(10, 2), (size * 8.0)/ 1024)/ 1024 size_GB
from sys.master_files t, sys.databases tt
where t.database_id = tt.database_id



return
select name, type_desc,* FROM transporte.sys.database_files

-- use transporte
-- go
-- dbcc shrinkfile (TRANSPORTE_log, 1024);



-- NOTA IMPORTANTE, PARA CAMBIAR NOMBRE DE TABLA SOLO SE TIENE EN CUENTA EL NOMBRE NO EL SCHEMA
-- ============================================================================================
exec sp_rename 'certificado', '_certificado'


alter table dbo.certificado add constraint pk022_certificado primary key (IdCertificado)


OJO
-- truncate table dbo.Vehiculo
-- No se puede truncar la tabla 'dbo.Vehiculo'.
-- Una restricci¢n FOREIGN KEY hace referencia a ella.
declare @campo varchar(max)=(
select (
select ';alter table ', object_name(parent_object_id), ' drop constraint ', name
from sys.foreign_keys where referenced_object_id = object_id('dbo.Vehiculo')
for xml path, type).value('.','varchar(max)'))
select(@campo)


NOTA: ELIMINAR REFERENCIAS DE FOREIGN KEYs
declare @campo varchar(max)=(
select (
select ';alter table dbo.', object_name(parent_object_id), ' drop constraint ', object_name(constraint_object_id)
from sys.foreign_key_columns where parent_object_id = object_id('dbo.grupo_bien')
for xml path, type).value('.','varchar(max)'))
exec(@campo)



select (select ',', t.name
from dbo.mastertable('dbo.vehiculo') t
outer apply(
select*from transporte.dbo.mastertable('dbo.vehiculo')tt
where t.tabla = tt.tabla and t.name = tt.name)ttt
where not ttt.name is null
order by t.column_id
for xml path, type).value('.','varchar(max)')


NOTA: PERMITIR CAMPOS EN VALOR NULO
===================================
declare @dato varchar(max) = (
select (
select ';alter table dbo.vehiculo alter column ',  t.name, ' ', t.type,
case when patindex('%char%', t.type) > 0 then concat('(', t.max_length, ') null') else ' null' end
from dbo.mastertable('dbo.vehiculo') t
outer apply(
select*from transporte.dbo.mastertable('dbo.vehiculo')tt
where t.tabla = tt.tabla and t.name = tt.name)ttt
where not ttt.name is null and t.is_nullable = 0 and t.name != 'Id_Vehiculo'
order by t.column_id
for xml path, type).value('.','varchar(max)'))
exec(@dato)




set identity_insert dbo.VEHICULO on

insert into dbo.vehiculo(
Id_Vehiculo,Id_Bien,Placa_Interna,Placa_Rodaje,Placa_Anterior,Id_TipoVehiculo,Id_TipoCarroceria,Id_TipoCategoria,Id_TipoMarca,Id_TipoModelo,Anio_Modelo,Anio_Fabricacion,Id_TipoColor,Nro_Motor,Nro_Serie,Id_TipoTransmision,
Nro_Asientos,Nro_Puertas,Nro_Llantas,Nro_Pasajeros,Id_TipoCombustible,Id_TipoOctanaje,Cilindrada,Nro_Cilindros,Nro_Ejes,Version,Id_FormulaRodante,Potencia,Longitud,Altura,Ancho,Peso_Bruto,Peso_Neto,CargaUtil,NroLectorHuella,
NroSerieTablet,NroSerieCamaraIdentificacion,Id_TipoZonaRegistral,Id_TipoFuncion,Id_TipoSituacionEspecial,Id_TipoPropietario,UsuarioI,FechaI,Estado,Id_Persona,Fec_Expedicion_Tarjeta,IdDocumentoCambio,OficinaRegistral,
PartidaRegistral,DuaDam,Titulo,FechaTitulo,Condicion,VigenciaTemporal,CodigoSunarp,Id_Proveedor)
select
Id_Vehiculo,Id_Bien,Placa_Interna,Placa_Rodaje,Placa_Anterior,Id_TipoVehiculo,Id_TipoCarroceria,Id_TipoCategoria,Id_TipoMarca,Id_TipoModelo,Anio_Modelo,Anio_Fabricacion,Id_TipoColor,Nro_Motor,Nro_Serie,Id_TipoTransmision,
Nro_Asientos,Nro_Puertas,Nro_Llantas,Nro_Pasajeros,Id_TipoCombustible,Id_TipoOctanaje,Cilindrada,Nro_Cilindros,Nro_Ejes,Version,Id_FormulaRodante,Potencia,Longitud,Altura,Ancho,Peso_Bruto,Peso_Neto,CargaUtil,NroLectorHuella,
NroSerieTablet,NroSerieCamaraIdentificacion,Id_TipoZonaRegistral,Id_TipoFuncion,Id_TipoSituacionEspecial,Id_TipoPropietario,UsuarioI,FechaI,Estado,Id_Persona,Fec_Expedicion_Tarjeta,IdDocumentoCambio,OficinaRegistral,
PartidaRegistral,DuaDam,Titulo,FechaTitulo,Condicion,VigenciaTemporal,CodigoSunarp,Id_Proveedor
from transporte.dbo.vehiculo

set identity_insert dbo.VEHICULO off





-- select V.Id_Vehiculo, V.placa_interna, AV.Id_AltaVehiculo
-- from transporte.dbo.VEHICULO V
-- inner join transporte.dbo.ALTA_VEHICULO AV on V.Id_Vehiculo = AV.Id_Vehiculo


-- insert into dbo.ALTA_VEHICULO(Id_AltaVehiculo,Id_Vehiculo,Id_TipoDocumento,Nro_Documento,Fec_Documento,Observaciones,UsuarioI,FechaI,Estado)

select t.*from dbo.VEHICULO t, dbo.ALTA_VEHICULO tt where t.Id_Vehiculo = tt.Id_Vehiculo


-- select tt.Id_Vehiculo, t.*
-- from dbo.OPERATIVIDAD_VEHICULO t, dbo.VEHICULO tt where t.placa_interna = tt.placa_interna

-- update t set t.Id_Vehiculo = tt.Id_Vehiculo
-- from dbo.OPERATIVIDAD_VEHICULO t, dbo.VEHICULO tt where t.placa_interna = tt.placa_interna
