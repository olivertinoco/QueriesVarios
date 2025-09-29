-- -- NOTA: LOCAL
-- -- ==========
-- use sispap
-- go
-- set rowcount 0

-- -- select*from dbo.geojson_puentes

-- -- select name
-- -- from sys.tables where name like 'geo_%'
-- -- order by 1

-- -- select distinct geom.STGeometryType()
-- -- from dbo.geo_tuneltrasandino

-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_redvialdepartamental','U'))
-- drop table dbo.geojson_redvialdepartamental
-- go
-- create table dbo.geojson_redvialdepartamental(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_redvialdepartamental;
-- insert into dbo.geojson_redvialdepartamental
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_redvialdepartamental where not geom is null)t)t


-- -- select*from dbo.geojson_redvialdepartamental



-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_autopistas_2013','U'))
-- drop table dbo.geojson_autopistas_2013
-- go
-- create table dbo.geojson_autopistas_2013(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_autopistas_2013;
-- insert into dbo.geojson_autopistas_2013
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_autopistas_2013 where not geom is null)t)t


-- -- select*from dbo.geojson_autopistas_2013




-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_concesiones','U'))
-- drop table dbo.geojson_concesiones
-- go
-- create table dbo.geojson_concesiones(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_concesiones;
-- insert into dbo.geojson_concesiones
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinageojson_concesionestes":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_concesiones where not geom is null)t)t


-- -- select*from dbo.geojson_concesiones



-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_corredoresalimentadores','U'))
-- drop table dbo.geojson_corredoresalimentadores
-- go
-- create table dbo.geojson_corredoresalimentadores(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_corredoresalimentadores;
-- insert into dbo.geojson_corredoresalimentadores
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_corredoresalimentadores where not geom is null)t)t


-- -- select*from dbo.geojson_corredoresalimentadores


-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_corredoreslogistico','U'))
-- drop table dbo.geojson_corredoreslogistico
-- go
-- create table dbo.geojson_corredoreslogistico(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_corredoreslogistico;
-- insert into dbo.geojson_corredoreslogistico
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_corredoreslogistico where not geom is null)t)t

-- -- select*from dbo.geojson_corredoreslogistico



-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_corredoreslogistico2032','U'))
-- drop table dbo.geojson_corredoreslogistico2032
-- go
-- create table dbo.geojson_corredoreslogistico2032(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_corredoreslogistico2032;
-- insert into dbo.geojson_corredoreslogistico2032
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_corredoreslogistico2032 where not geom is null)t)t


-- -- select*from dbo.geojson_corredoreslogistico2032



-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_corredoreslogisticohidrovia','U'))
-- drop table dbo.geojson_corredoreslogisticohidrovia
-- go
-- create table dbo.geojson_corredoreslogisticohidrovia(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_corredoreslogisticohidrovia;
-- insert into dbo.geojson_corredoreslogisticohidrovia
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_corredoreslogisticohidrovia where not geom is null)t)t


-- -- select*from dbo.geojson_corredoreslogisticohidrovia





-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_ejes_peru_ecuador','U'))
-- drop table dbo.geojson_ejes_peru_ecuador
-- go
-- create table dbo.geojson_ejes_peru_ecuador(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_ejes_peru_ecuador;
-- insert into dbo.geojson_ejes_peru_ecuador
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_ejes_peru_ecuador where not geom is null)t)t



-- -- select*from dbo.geojson_ejes_peru_ecuador



-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_estingenieria','U'))
-- drop table dbo.geojson_estingenieria
-- go
-- create table dbo.geojson_estingenieria(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_estingenieria;
-- insert into dbo.geojson_estingenieria
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_estingenieria where not geom is null)t)t


-- -- select*from dbo.geojson_estingenieria



-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_estmedi','U'))
-- drop table dbo.geojson_estmedi
-- go
-- create table dbo.geojson_estmedi(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_estmedi;
-- insert into dbo.geojson_estmedi
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_estmedi where not geom is null)t)t


-- -- select*from dbo.geojson_estmedi



-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_estmestudio','U'))
-- drop table dbo.geojson_estmestudio
-- go
-- create table dbo.geojson_estmestudio(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_estmestudio;
-- insert into dbo.geojson_estmestudio
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_estmestudio where not geom is null)t)t


-- -- select*from dbo.geojson_estmestudio



-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_ferrocarril_bioceanico','U'))
-- drop table dbo.geojson_ferrocarril_bioceanico
-- go
-- create table dbo.geojson_ferrocarril_bioceanico(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_ferrocarril_bioceanico;
-- insert into dbo.geojson_ferrocarril_bioceanico
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_ferrocarril_bioceanico where not geom is null)t)t


-- -- select*from dbo.geojson_ferrocarril_bioceanico





-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_gisrvnmredvianacional','U'))
-- drop table dbo.geojson_gigeojson_gisrvnmredvianacionalspfis_1
-- go
-- create table dbo.geojson_gisrvnmredvianacional(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_gisrvnmredvianacional;
-- insert into dbo.geojson_gisrvnmredvianacional
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_gisrvnmredvianacional where not geom is null)t)t


-- -- select*from dbo.geojson_gisrvnmredvianacional



-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_hitos_referenciales_dgcf_1','U'))
-- drop table dbo.geojson_hitos_referenciales_dgcf_1
-- go
-- create table dbo.geojson_hitos_referenciales_dgcf_1(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_hitos_referenciales_dgcf_1;
-- insert into dbo.geojson_hitos_referenciales_dgcf_1
-- select id, concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"', stuff(geom, charindex(',', geom),1,'","coordinates":'), '}}]}') geom
-- from(select ogr_fid id, replace(replace(replace(replace(replace(geom.Reduce(0.0005).STAsText(),', ','],['),' ',','),'(','['),')',']'),'POINT','Point') geom
-- from dbo.geo_hitos_referenciales_dgcf_1 where not geom is null)t

-- -- NOTA: SON POINTS
-- -- select*from dbo.geojson_gisrvnmredvianacional



-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_infraestructura','U'))
-- drop table dbo.geojson_infraestructura
-- go
-- create table dbo.geojson_infraestructura(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_infraestructura;
-- insert into dbo.geojson_infraestructura
-- select id, concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"', stuff(geom, charindex(',', geom),1,'","coordinates":'), '}}]}') geom
-- from(select ogr_fid id, replace(replace(replace(replace(replace(geom.Reduce(0.0005).STAsText(),', ','],['),' ',','),'(','['),')',']'),'POINT','Point') geom
-- from dbo.geo_infraestructura where not geom is null)t


-- -- -- NOTA: SON POINTS
-- -- select*from dbo.geojson_infraestructura



-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_itinerario_1','U'))
-- drop table dbo.geojson_itinerario_1
-- go
-- create table dbo.geojson_itinerario_1(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_itinerario_1;
-- insert into dbo.geojson_itinerario_1
-- select id, concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"', stuff(geom, charindex(',', geom),1,'","coordinates":'), '}}]}') geom
-- from(select ogr_fid id, replace(replace(replace(replace(replace(geom.Reduce(0.0005).STAsText(),', ','],['),' ',','),'(','['),')',']'),'POINT','Point') geom
-- from dbo.geo_itinerario_1 where not geom is null)t


-- -- -- NOTA: SON POINTS
-- -- select*from dbo.geojson_itinerario_1



-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_manmmantenimiento','U'))
-- drop table dbo.geojson_manmmantenimiento
-- go
-- create table dbo.geojson_manmmantenimiento(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_manmmantenimiento;
-- insert into dbo.geojson_manmmantenimiento
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_manmmantenimiento where not geom is null)t)t


-- -- select*from dbo.geojson_manmmantenimiento


-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_obras_concesion','U'))
-- drop table dbo.geojson_obras_concesion
-- go
-- create table dbo.geojson_obras_concesion(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_obras_concesion;
-- insert into dbo.geojson_obras_concesion
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_obras_concesion where not geom is null)t)t


-- -- select*from dbo.geojson_obras_concesion


-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_obrmobra','U'))
-- drop table dbo.geojson_obrmobra
-- go
-- create table dbo.geojson_obrmobra(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_obrmobra;
-- insert into dbo.geojson_obrmobra
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_obrmobra where not geom is null)t)t

-- -- select*from dbo.geojson_obrmobra


-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_peajes','U'))
-- drop table dbo.geojson_peajes
-- go
-- create table dbo.geojson_peajes(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_peajes;
-- insert into dbo.geojson_peajes
-- select id, concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"', stuff(geom, charindex(',', geom),1,'","coordinates":'), '}}]}') geom
-- from(select ogr_fid id, replace(replace(replace(replace(replace(geom.Reduce(0.0005).STAsText(),', ','],['),' ',','),'(','['),')',']'),'POINT','Point') geom
-- from dbo.geo_peajes where not geom is null)t

-- -- -- NOTA: SON POINTS
-- -- select*from dbo.geojson_peajes




-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_puempuente','U'))
-- drop table dbo.geojson_puempuente
-- go
-- create table dbo.geojson_puempuente(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_puempuente;
-- insert into dbo.geojson_puempuente
-- select id, concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"', stuff(geom, charindex(',', geom),1,'","coordinates":'), '}}]}') geom
-- from(select ogr_fid id, replace(replace(replace(replace(replace(geom.Reduce(0.0005).STAsText(),', ','],['),' ',','),'(','['),')',']'),'POINT','Point') geom
-- from dbo.geo_puempuente where not geom is null)t

-- -- -- NOTA: SON POINTS
-- -- select*from dbo.geojson_puempuente


-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_puentes','U'))
-- drop table dbo.geojson_puentes
-- go
-- create table dbo.geojson_puentes(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_puentes;
-- insert into dbo.geojson_puentes
-- select id, concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"', stuff(geom, charindex(',', geom),1,'","coordinates":'), '}}]}') geom
-- from(select ogr_fid id, replace(replace(replace(replace(replace(geom.Reduce(0.0005).STAsText(),', ','],['),' ',','),'(','['),')',']'),'POINT','Point') geom
-- from dbo.geo_puentes where not geom is null)t


-- -- -- NOTA: SON POINTS
-- -- select*from dbo.geojson_puentes



-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_puentes_inventario','U'))
-- drop table dbo.geojson_puentes_inventario
-- go
-- create table dbo.geojson_puentes_inventario(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_puentes_inventario;
-- insert into dbo.geojson_puentes_inventario
-- select id, concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"', stuff(geom, charindex(',', geom),1,'","coordinates":'), '}}]}') geom
-- from(select ogr_fid id, replace(replace(replace(replace(replace(geom.Reduce(0.0005).STAsText(),', ','],['),' ',','),'(','['),')',']'),'POINT','Point') geom
-- from dbo.geo_puentes_inventario where not geom is null)t

-- -- -- NOTA: SON POINTS
-- -- select*from dbo.geojson_puentes_inventario


-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_puentes_pvn','U'))
-- drop table dbo.geojson_puentes_pvn
-- go
-- create table dbo.geojson_puentes_pvn(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_puentes_pvn;
-- insert into dbo.geojson_puentes_pvn
-- select id, concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"', stuff(geom, charindex(',', geom),1,'","coordinates":'), '}}]}') geom
-- from(select ogr_fid id, replace(replace(replace(replace(replace(geom.Reduce(0.0005).STAsText(),', ','],['),' ',','),'(','['),')',']'),'POINT','Point') geom
-- from dbo.geo_puentes_pvn where not geom is null)t


-- -- -- NOTA: SON POINTS
-- -- select*from dbo.geojson_puentes_pvn



-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_redvialnacional','U'))
-- drop table dbo.geojson_redvialnacional
-- go
-- create table dbo.geojson_redvialnacional(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_redvialnacional;
-- insert into dbo.geojson_redvialnacional
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_redvialnacional where not geom is null)t)t


-- -- select*from dbo.geojson_redvialnacional



-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_redvialvecinal','U'))
-- drop table dbo.geojson_redvialvecinal
-- go
-- create table dbo.geojson_redvialvecinal(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_redvialvecinal;
-- insert into dbo.geojson_redvialvecinal
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_redvialvecinal where not geom is null)t)t

-- -- select*from dbo.geojson_redvialvecinal


-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_rm_reclasificacion','U'))
-- drop table dbo.geojson_rm_reclasificacion
-- go
-- create table dbo.geojson_rm_reclasificacion(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_rm_reclasificacion;
-- insert into dbo.geojson_rm_reclasificacion
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_rm_reclasificacion where not geom is null)t)t

-- -- select*from dbo.geojson_rm_reclasificacion


-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_sinac','U'))
-- drop table dbo.geojson_sinac
-- go
-- create table dbo.geojson_sinac(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_sinac;
-- insert into dbo.geojson_sinac
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_sinac where not geom is null)t)t

-- -- select*from dbo.geojson_sinac


-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_trenes','U'))
-- drop table dbo.geojson_trenes
-- go
-- create table dbo.geojson_trenes(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_trenes;
-- insert into dbo.geojson_trenes
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_trenes where not geom is null)t)t


-- -- select*from dbo.geojson_trenes



-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_tuneltrasandino','U'))
-- drop table dbo.geojson_tuneltrasandino
-- go
-- create table dbo.geojson_tuneltrasandino(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
-- delete dbo.geojson_tuneltrasandino;
-- insert into dbo.geojson_tuneltrasandino
-- select id,
-- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- from dbo.geo_tuneltrasandino where not geom is null)t)t


-- -- select*from dbo.geojson_tuneltrasandino


-- ========================================================================
-- ========================================================================
-- ========================================================================

-- NOTA: DESDE AQUI HACIA DELANTE NO EXISTEN SUS TABLAS ESPACIALES BASES

-- ========================================================================
-- ========================================================================
-- ========================================================================




-- -- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_cnsmconnivservicios','U'))
-- -- drop table dbo.geojson_cnsmconnivservicios
-- -- go
-- -- create table dbo.geojson_cnsmconnivservicios(
-- --     id bigint primary key not null,
-- --     geom varchar(max)
-- -- )
-- -- go
-- -- delete dbo.geojson_cnsmconnivservicios;
-- -- insert into dbo.geojson_cnsmconnivservicios
-- -- select id,
-- -- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- -- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- -- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- -- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- -- from dbo.geo_cnsmconnivservicios where not geom is null)t)t


-- -- select*from dbo.geojson_cnsmconnivservicios


-- -- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_comisasrias01','U'))
-- -- drop table dbo.geojson_comisasrias01
-- -- go
-- -- create table dbo.geojson_comisasrias01(
-- --     id bigint primary key not null,
-- --     geom varchar(max)
-- -- )
-- -- go
-- -- delete dbo.geojson_comisasrias01;
-- -- insert into dbo.geojson_comisasrias01
-- -- select id, concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"', stuff(geom, charindex(',', geom),1,'","coordinates": ['), ']}}]}') geom
-- -- from(select id, replace(replace(replace(replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'POLYGON','Polygon'),'MULTIPOLYGON','MultiPolygon'),'LINESTRING','LineString'),'GEOMETRYCOLLECTION','GeometryCollection'),'POINT','MultiPoint') geom
-- -- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- -- from dbo.geo_comisasrias01 where not geom is null
-- -- and ogr_fid in (select ogr_fid from dbo.geo_comisasrias01 where not geom is null and geom.STIsValid() = 1)
-- -- )t)t


-- -- select*from dbo.geojson_comisasrias01

-- -- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_gispfis_1','U'))
-- -- drop table dbo.geojson_gispfis_1
-- -- go
-- -- create table dbo.geojson_gispfis_1(
-- --     id bigint primary key not null,
-- --     geom varchar(max)
-- -- )
-- -- go
-- -- delete dbo.geojson_gispfis_1;
-- -- insert into dbo.geojson_gispfis_1
-- -- select id,
-- -- concat('{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"',
-- -- stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- -- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- -- from(select ogr_fid id, geom.Reduce(0.0005).STAsText() geom
-- -- from dbo.geo_gispfis_1 where not geom is null)t)t


-- -- select*from dbo.geojson_gispfis_1















-- -- select* into #tmp001_prueba from dbo.geo_redvialdepartamental
-- -- alter table #tmp001_prueba drop column geom
-- -- select*from #tmp001_prueba

-- -- select ogr_fid id, geom.Reduce(0.0005).STAsText() from dbo.geo_redvialdepartamental

-- -- select
-- -- departamen,provincia ,trayectori,iddpto,jerarq,codruta,superfic,longitud,estado_l,superfic_l,ruta,tipo,estado,superficie, shape_leng
-- -- from dbo.geo_redvialdepartamental


-- -- -- NOTA: SABER QUE TIPO DE GEOMETRIA ME TRAE LA U
-- -- -- ==============================================
-- -- select distinct substring(geom.STAsText(), 1, charindex(' ', geom.STAsText()))
-- -- from dbo.geo_redvialdepartamental

-- -- select distinct geom.STGeometryType()
-- -- from dbo.geo_estmestudio


-- -- select*from sys.tables where name like 'geo_%'
-- -- order by 1
