set rowcount 0

-- NOTA: SON HERRAMIENTAS DE DESARROLLO PARA HOMOLOGAR LAS TABLAS DE SISPAP Y TRANSPORTE

select top 0
cast(null as varchar(200)) name,
cast(null as int) rows,
cast(null as varchar(50)) reserved,
cast(null as varchar(50)) data,
cast(null as varchar(50)) index_size,
cast(null as varchar(50)) unused into #tmp001_sizeU


select top 0 cast(null as varchar(100)) tabla into #tmp001_tablas
declare @datos varchar(max) = (
select (select ';select distinct tabla from dbo.mastertable(''', name, ''') where name = ''Id_Vehiculo'''
from sys.tables
order by 1
for xml path, type).value('.','varchar(max)'))
insert into #tmp001_tablas exec(@datos)

select @datos = (select ';exec sp_spaceused ', tabla
from #tmp001_tablas
for xml path, type).value('.','varchar(max)')
insert into #tmp001_sizeU exec(@datos)


select @datos = (select ';select*from mastertable(''', name, ''')'
-- select @datos = (select ';alter table ', name, ' alter column Id_Vehiculo int null'
-- select @datos = (select ';update t set Id_Vehiculo = null from ', name, ' t'
from(select*from #tmp001_sizeU where rows != 0)t where name != 'VEHICULO'
for xml path, type).value('.','varchar(max)')
-- exec(@datos)

-- NOTA: QUEREMOS POBLAR EL ID DE VEHICULO QUE VIENE DE TRANSPORTE PARA ESTA LISTA DE TABLAS:
select *
from(select*from #tmp001_sizeU where rows != 0)t where name != 'VEHICULO'


-- select*from sys.tables order by 1

-- exec sys.sp_spaceused GRUPO_BIEN
-- exec transporte.sys.sp_spaceused GRUPO_BIEN
-- exec sys.sp_spaceused VEHICULO

-- select count(1) from dbo.vehiculo where isnull(Id_GrupoBien,'') != ''


-- select*from mastertable('GRUPO_BIEN')
-- select*from mastertable('CANTIDAD_VEHICULO')
-- select*from mastertable('VEHICULO')
-- select*from mastertable('ALTA_VEHICULO')
-- select*from mastertable('ASIGNAR_VEHICULO_COMANDO')
-- select*from mastertable('ASIGNAR_VEHICULO_UNIDAD')
-- select*from mastertable('OPERATIVIDAD_VEHICULO')

select*into ##tmp001_grupoBien from mastertable('GRUPO_BIEN')


select count(1) from dbo.vehiculo t, dbo.grupo_bien tt where t.Id_GrupoBien = tt.Id_GrupoBien

-- select distinct Id_GrupoBien from dbo.vehiculo
-- select Id_GrupoBien from dbo.grupo_bien
-- return

-- alter table dbo.grupo_bien add id_bien int

-- truncate table dbo.grupo_bien
-- alter table dbo.grupo_bien drop column id_bien;
-- select top 10*from dbo.grupo_bien


-- set identity_insert dbo.grupo_bien on;
-- insert into dbo.grupo_bien
-- (Id_GrupoBien,Id_TipoRubro,Nombre_Bien,Fec_Adquisicion,Id_TipoMoneda,Id_TipoProcedencia,Id_TipoDonante,Id_TipoEntidad,Precio,Id_TipoFormaAdquisicion,ResolucionDonacion,Anio_Fabricacion,Id_CatalogoBien,Id_TipoDocumento,Nro_Documento,Fec_Documento,Id_TipoAfectacion,Id_TipoCodigoBien,Id_Proveedor,Id_TipoUnidadMedida,Precio_Base,Valor_Tasado,Id_TipoPais,UsuarioI,FechaI,Estado)
-- select
-- Id_GrupoBien,Id_TipoRubro,Nombre_Bien,Fec_Adquisicion,Id_TipoMoneda,Id_TipoProcedencia,Id_TipoDonante,Id_TipoEntidad,Precio,Id_TipoFormaAdquisicion,ResolucionDonacion,Anio_Fabricacion,Id_CatalogoBien,Id_TipoDocumento,Nro_Documento,Fec_Documento,Id_TipoAfectacion,Id_TipoCodigoBien,Id_Proveedor,Id_TipoUnidadMedida,Precio_Base,Valor_Tasado,Id_TipoPais,UsuarioI,FechaI,Estado
-- from transporte.dbo.grupo_bien;
-- set identity_insert dbo.grupo_bien off;


-- select*from dbo.grupo_bien;

-- select*from dbo.VEHICULO where Id_Bien = 182767


-- select*from dbo.vehiculo t where not id_grupoBien is null
-- select*from dbo.grupo_bien tt


return
use transporte;


select top 10*from dbo.grupo_bien




-- select count(1) from dbo.vehiculo t, dbo.grupo_bien tt where t.Id_GrupoBien = tt.Id_GrupoBien
-- select*from mastertable('dbo.vehiculo')
-- select*from mastertable('dbo.grupo_bien')


return

-- select*from ##tmp001_grupoBien

select t.name, t.type, t.max_length, t.is_nullable, '-', tt.name, tt.type, tt.max_length, tt.is_nullable
-- select (select ',', t.name
from mastertable('GRUPO_BIEN') t, ##tmp001_grupoBien tt
where t.tabla = tt.tabla and t.name = tt.name
-- for xml path, type).value('.','varchar(max)')

-- select t.name, t.type, t.max_length, '---', tt.name, tt.type, tt.max_length
-- from ##tmp001_grupoBien tt outer apply(select*from mastertable('GRUPO_BIEN') t
-- where t.tabla = tt.tabla and t.name = tt.name)t where t.name is null


-- select t.name, t.type, t.max_length, '---', tt.name, tt.type, tt.max_length
-- from mastertable('GRUPO_BIEN') t outer apply(select*from ##tmp001_grupoBien tt
-- where t.tabla = tt.tabla and t.name = tt.name)tt where tt.name is null

-- insert into dbo.grupo_bien
-- (Id_GrupoBien,Id_TipoRubro,Nombre_Bien,Fec_Adquisicion,Id_TipoMoneda,Id_TipoProcedencia,Id_TipoDonante,Id_TipoEntidad,Precio,Id_TipoFormaAdquisicion,ResolucionDonacion,Anio_Fabricacion,Id_CatalogoBien,Id_TipoDocumento,Nro_Documento,Fec_Documento,Id_TipoAfectacion,Id_TipoCodigoBien,Id_Proveedor,Id_TipoUnidadMedida,Precio_Base,Valor_Tasado,Id_TipoPais,UsuarioI,FechaI,Estado)
-- select
-- Id_GrupoBien,Id_TipoRubro,Nombre_Bien,Fec_Adquisicion,Id_TipoMoneda,Id_TipoProcedencia,Id_TipoDonante,Id_TipoEntidad,Precio,Id_TipoFormaAdquisicion,ResolucionDonacion,Anio_Fabricacion,Id_CatalogoBien,Id_TipoDocumento,Nro_Documento,Fec_Documento,Id_TipoAfectacion,Id_TipoCodigoBien,Id_Proveedor,Id_TipoUnidadMedida,Precio_Base,Valor_Tasado,Id_TipoPais,UsuarioI,FechaI,Estado
-- from transporte.dbo.grupo_bien;

-- set identity_insert dbo.grupo_b
