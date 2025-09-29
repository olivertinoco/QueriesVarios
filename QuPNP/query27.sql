
set rowcount 0
-- select*from sys.tables where name like 'geojson[_]%'
-- order by 1

-- select distinct geom.STGeometryType()

-- select * from dbo.geojson_redvialdepartamental

-- select*from dbo.geojson_redvialdepartamental


exec dbo.usp_listaGeometrias
return

select *from dbo.geojson_redvialdepartamental
select *from dbo.geojson_autopistas_2013
select *from dbo.geojson_concesiones
select *from dbo.geojson_corredoresalimentadores
select *from dbo.geojson_corredoreslogistico
select *from dbo.geojson_corredoreslogistico2032
select *from dbo.geojson_corredoreslogisticohidrovia
select *from dbo.geojson_ejes_peru_ecuador
select *from dbo.geojson_estingenieria
select *from dbo.geojson_estmedi
select *from dbo.geojson_estmestudio
select *from dbo.geojson_ferrocarril_bioceanico
select *from dbo.geojson_gisrvnmredvianacional
select *from dbo.geojson_hitos_referenciales_dgcf_1
select *from dbo.geojson_infraestructura
select *from dbo.geojson_itinerario_1
select *from dbo.geojson_manmmantenimiento
select *from dbo.geojson_obras_concesion
select *from dbo.geojson_obrmobra
select *from dbo.geojson_peajes
select *from dbo.geojson_puempuente
select *from dbo.geojson_puentes
select *from dbo.geojson_puentes_inventario
select *from dbo.geojson_puentes_pvn
select *from dbo.geojson_redvialnacional
select *from dbo.geojson_redvialvecinal
select *from dbo.geojson_rm_reclasificacion
select *from dbo.geojson_sinac
select *from dbo.geojson_trenes
select *from dbo.geojson_tuneltrasandino


return

select distinct geom.STGeometryType(), 1  from dbo.geo_redvialdepartamental
select distinct geom.STGeometryType(), 2  from dbo.geo_autopistas_2013
select distinct geom.STGeometryType(), 3  from dbo.geo_concesiones
select distinct geom.STGeometryType(), 4  from dbo.geo_corredoresalimentadores
select distinct geom.STGeometryType(), 5  from dbo.geo_corredoreslogistico
select distinct geom.STGeometryType(), 6  from dbo.geo_corredoreslogistico2032
select distinct geom.STGeometryType(), 7  from dbo.geo_corredoreslogisticohidrovia
select distinct geom.STGeometryType(), 8  from dbo.geo_ejes_peru_ecuador
select distinct geom.STGeometryType(), 9  from dbo.geo_estingenieria
select distinct geom.STGeometryType(), 10 from dbo.geo_estmedi
select distinct geom.STGeometryType(), 11 from dbo.geo_estmestudio
select distinct geom.STGeometryType(), 12 from dbo.geo_ferrocarril_bioceanico
select distinct geom.STGeometryType(), 13 from dbo.geo_gisrvnmredvianacional
select distinct geom.STGeometryType(), 14 from dbo.geo_hitos_referenciales_dgcf_1  POINT
select distinct geom.STGeometryType(), 15 from dbo.geo_infraestructura             POINT
select distinct geom.STGeometryType(), 16 from dbo.geo_itinerario_1                POINT
select distinct geom.STGeometryType(), 17 from dbo.geo_manmmantenimiento
select distinct geom.STGeometryType(), 18 from dbo.geo_obras_concesion
select distinct geom.STGeometryType(), 19 from dbo.geo_obrmobra
select distinct geom.STGeometryType(), 20 from dbo.geo_peajes                     POINT
select distinct geom.STGeometryType(), 21 from dbo.geo_puempuente                 POINT
select distinct geom.STGeometryType(), 22 from dbo.geo_puentes                    POINT
select distinct geom.STGeometryType(), 23 from dbo.geo_puentes_inventario         POINT
select distinct geom.STGeometryType(), 24 from dbo.geo_puentes_pvn                POINT
select distinct geom.STGeometryType(), 25 from dbo.geo_redvialnacional
select distinct geom.STGeometryType(), 26 from dbo.geo_redvialvecinal
select distinct geom.STGeometryType(), 27 from dbo.geo_rm_reclasificacion
select distinct geom.STGeometryType(), 28 from dbo.geo_sinac
select distinct geom.STGeometryType(), 29 from dbo.geo_trenes
select distinct geom.STGeometryType(), 30 from dbo.geo_tuneltrasandino





return
select*from dbo.ubigeo



DECLARE @p1 geometry = geometry::STGeomFromText('POINT(-77.05 -12.05)', 4326);
DECLARE @p2 geometry = geometry::STGeomFromText('POINT(-77.03 -12.07)', 4326);

-- Buscar el tramo más cercano a p1
SELECT TOP 1 Id, Geom, Geom.STDistance(@p1) AS Distancia
FROM RedVial
ORDER BY Geom.STDistance(@p1);

-- Buscar el tramo más cercano a p2
SELECT TOP 1 Id, Geom, Geom.STDistance(@p2) AS Distancia
FROM RedVial
ORDER BY Geom.STDistance(@p2);



-- CREATE DATABASE SISPAP
-- ON (FILENAME = 'C:\DBrestore\SISPAP2.mdf'),
--    (FILENAME = 'C:\DBrestore\SISPAP2_log.ldf')
-- FOR ATTACH;
