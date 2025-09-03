use sispap
go
set rowcount 0

-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.geojson_redvialdepartamental','U'))
-- drop table dbo.geojson_redvialdepartamental
-- go
-- create table dbo.geojson_redvialdepartamental(
--     id bigint primary key not null,
--     geom varchar(max)
-- )
-- go
select*from dbo.geojson_redvialdepartamental
-- select*from dbo.geo_redvialdepartamental

-- delete dbo.geojson_redvialdepartamental
-- insert into dbo.geojson_redvialdepartamental
-- select id, concat('{"type":"FeatureCollection","features":[{"type":"Feature","p":{},"geometry":{"type":"', stuff(geom, charindex(',', geom),1,'","coordinates":[') ,']}}]}') geom
-- from(select id, replace(replace(replace(replace(replace(replace(geom,', ','],['),' ',','),'(','['),')',']'),'LINESTRING','LineString'),'MULTILINESTRING','MultiLineString') geom
-- from(select ogr_fid id, geom.STAsText() geom
-- from dbo.geo_redvialdepartamental where not geom is null)t)t










-- -- NOTA: SABER QUE TIPO DE GEOMETRIA ME TRAE LA U
-- -- ==============================================
-- select distinct substring(geom.STAsText(), 1, charindex(' ', geom.STAsText()))
-- from dbo.geo_redvialdepartamental



-- select*from dbo.geo_redvialnacional

-- select*from mastertable('dbo.aerodromos')

-- select*from sys.tables where name like 'geo_%'
-- order by 1
