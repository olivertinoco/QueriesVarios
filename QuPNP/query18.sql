-- NOTA: LOCAL
-- ==========
use sispap
go
if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_listaGeometrias','p'))
drop procedure dbo.usp_listaGeometrias
go
create procedure dbo.usp_listaGeometrias
as
begin
set nocount on
begin try

;with tmp001_sep(t,r, i) as(
    select*from(values('|','~','^'))t(sepCol,sepReg,sepList)
)
,tmp001_geojson_redvialdepartamental(dato)as(
    select concat(i, '#F9E076', t, 0.75, (select r, id, t, geom
    from dbo.geojson_redvialdepartamental
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_autopistas_2013(dato)as(
    select concat(i, '#ED7014', t, 0.75, (select r, id, t, geom
    from dbo.geojson_autopistas_2013
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_concesiones(dato)as(
    select concat(i, '#680C07', t, 0.75, (select r, id, t, geom
    from dbo.geojson_concesiones
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_corredoresalimentadores(dato)as(
    select concat(i, '#D0312D', t, 0.75, (select r, id, t, geom
    from dbo.geojson_corredoresalimentadores
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_corredoreslogistico(dato)as(
    select concat(i, '#990F02', t, 0.75, (select r, id, t, geom
    from dbo.geojson_corredoreslogistico
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_corredoreslogistico2032(dato)as(
    select concat(i, '#E3242B', t, 0.75, (select r, id, t, geom
    from dbo.geojson_corredoreslogistico2032
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_corredoreslogisticohidrovia(dato)as(
    select concat(i, '#60100B', t, 0.75, (select r, id, t, geom
    from dbo.geojson_corredoreslogisticohidrovia
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_ejes_peru_ecuador(dato)as(
    select concat(i, '#541E1B', t, 0.75, (select r, id, t, geom
    from dbo.geojson_ejes_peru_ecuador
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_estingenieria(dato)as(
    select concat(i, '#610C04', t, 0.75, (select r, id, t, geom
    from dbo.geojson_estingenieria
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_estmedi(dato)as(
    select concat(i, '#B90E0A', t, 0.75, (select r, id, t, geom
    from dbo.geojson_estmedi
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_estmestudio(dato)as(
    select concat(i, '#900603', t, 0.75, (select r, id, t, geom
    from dbo.geojson_estmestudio
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_ferrocarril_bioceanico(dato)as(
    select concat(i, '#900D09', t, 0.75, (select r, id, t, geom
    from dbo.geojson_ferrocarril_bioceanico
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_gisrvnmredvianacional(dato)as(
    select concat(i, '#4E0707', t, 0.75, (select r, id, t, geom
    from dbo.geojson_gisrvnmredvianacional
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_hitos_referenciales_dgcf_1(dato)as(
    select concat(i, '#ED7014', t, 0.75, 1, (select r, id, t, geom
    from dbo.geojson_hitos_referenciales_dgcf_1
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_infraestructura(dato)as(
    select concat(i, '#FCAE1E', t, 0.75, 1, (select r, id, t, geom
    from dbo.geojson_infraestructura
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_itinerario_1(dato)as(
    select concat(i, '#3CB043', t, 0.75, 1, (select r, id, t, geom
    from dbo.geojson_itinerario_1
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_manmmantenimiento(dato)as(
    select concat(i, '#B0FC38', t, 0.75, (select r, id, t, geom
    from dbo.geojson_manmmantenimiento
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_obras_concesion(dato)as(
    select concat(i, '#3A5311', t, 0.75, (select r, id, t, geom
    from dbo.geojson_obras_concesion
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_obrmobra(dato)as(
    select concat(i, '#728C69', t, 0.75, (select r, id, t, geom
    from dbo.geojson_obrmobra
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_peajes(dato)as(
    select concat(i, '#AEF359', t, 0.75, 2, (select r, id, t, geom
    from dbo.geojson_peajes
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_puempuente(dato)as(
    select concat(i, '#5DBB63', t, 0.75, 2, (select r, id, t, geom
    from dbo.geojson_puempuente
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_puentes(dato)as(
    select concat(i, '#98BF64', t, 0.75, 2, (select r, id, t, geom
    from dbo.geojson_puentes
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_puentes_inventario(dato)as(
    select concat(i, '#028A0F', t, 0.75, 2, (select r, id, t, geom
    from dbo.geojson_puentes_inventario
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_puentes_pvn(dato)as(
    select concat(i, '#74B72E', t, 0.75, 2, (select r, id, t, geom
    from dbo.geojson_puentes_pvn
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_redvialnacional(dato)as(
    select concat(i, '#3944BC', t, 0.75, (select r, id, t, geom
    from dbo.geojson_redvialnacional
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_redvialvecinal(dato)as(
    select concat(i, '#016064', t, 0.75, (select r, id, t, geom
    from dbo.geojson_redvialvecinal
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_rm_reclasificacion(dato)as(
    select concat(i, '#022D36', t, 0.75, (select r, id, t, geom
    from dbo.geojson_rm_reclasificacion
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_sinac(dato)as(
    select concat(i, '#1520A6', t, 0.75, (select r, id, t, geom
    from dbo.geojson_sinac
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_trenes(dato)as(
    select concat(i, '#1F456E', t, 0.75, (select r, id, t, geom
    from dbo.geojson_trenes
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
,tmp001_geojson_tuneltrasandino(dato)as(
    select concat(i, '#A32CC4', t, 0.75, (select r, id, t, geom
    from dbo.geojson_tuneltrasandino
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
select concat(stuff((select r, id_ubigeo, t, departamento, t, provincia, t, distrito
from dbo.ubigeo order by id_ubigeo
for xml path, type).value('.','varchar(max)'),1,1,''),
t1.dato, t2.dato, t3.dato, t4.dato, t5.dato,
t6.dato, t7.dato, t8.dato, t9.dato, t10.dato,
t11.dato, t12.dato, t13.dato, t14.dato, t15.dato,
t16.dato, t17.dato, t18.dato, t19.dato, t20.dato,
t21.dato, t22.dato, t23.dato, t24.dato, t25.dato,
t26.dato, t27.dato, t28.dato, t29.dato, t30.dato
)
from tmp001_sep,
tmp001_geojson_redvialdepartamental t1,
tmp001_geojson_autopistas_2013 t2,
tmp001_geojson_concesiones t3,
tmp001_geojson_corredoresalimentadores t4,
tmp001_geojson_corredoreslogistico t5,
tmp001_geojson_corredoreslogistico2032 t6,
tmp001_geojson_corredoreslogisticohidrovia t7,
tmp001_geojson_ejes_peru_ecuador t8,
tmp001_geojson_estingenieria t9,
tmp001_geojson_estmedi t10,
tmp001_geojson_estmestudio t11,
tmp001_geojson_ferrocarril_bioceanico t12,
tmp001_geojson_gisrvnmredvianacional t13,
tmp001_geojson_hitos_referenciales_dgcf_1 t14,
tmp001_geojson_infraestructura t15,
tmp001_geojson_itinerario_1 t16,
tmp001_geojson_manmmantenimiento t17,
tmp001_geojson_obras_concesion t18,
tmp001_geojson_obrmobra t19,
tmp001_geojson_peajes t20,
tmp001_geojson_puempuente t21,
tmp001_geojson_puentes t22,
tmp001_geojson_puentes_inventario t23,
tmp001_geojson_puentes_pvn t24,
tmp001_geojson_redvialnacional t25,
tmp001_geojson_redvialvecinal t26,
tmp001_geojson_rm_reclasificacion t27,
tmp001_geojson_sinac t28,
tmp001_geojson_trenes t29,
tmp001_geojson_tuneltrasandino t30

end try
begin catch
    select concat('error:', error_message())
end catch
end
go

exec dbo.usp_listaGeometrias
