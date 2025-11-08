if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_listar_prog_rutas','p'))
drop procedure dbo.usp_listar_prog_rutas
go
create procedure dbo.usp_listar_prog_rutas
@data varchar(100),
@pks varchar(100) = ''
as
begin
begin try
set nocount on
set language english
declare @Utabla tabla_generico
insert into @Utabla
exec dbo.usp_listar_tablas 'dbo.prog_ruta'

;with tmp001_sep(t,r,i,a)as(
    select*from(values('|','~','^','*'))t(sepCampo,sepReg,sepLst,sepAux)
)
,tmp001_cab_prog_ruta(dato)as(
select '~dato|a1|a2|a3|a4|a5|a6|a7|a8|a9|a10|UNIDAD|MOVIMIENTO|OBSERVACION~10|10|10|10|10|10|10|10|10|10|10|600|200|300'
)
,tmp001_prog_ruta(dato)as(
select stuff((select '+', substring(t.value, 0, charindex(a, t.value))
from dbo.udf_general_metadata(
'tt.Id_ProgRuta..*,
tt.Id_ProgExtraOrd..*,
tt.Id_TipoParada..*,
tt.Id_Unidad..*,
tt.Observaciones..*,
tt.Dias_Permanencia..*,
tt.activo..*',
'tt.dbo.prog_ruta',
@Utabla)tt cross apply dbo.udf_split(dato, default)t
for xml path, type).value('.','varchar(max)'),1,2,r)
from tmp001_sep
)
,info001_prog_ruta(dato)as(
    select concat(i, 741, r.dato, c.dato, (select r.dato, t,
    t.Id_ProgRuta, t,
    t.Id_ProgExtraOrd, t,
    t.Id_TipoParada, t,
    t.Id_Unidad, t,
    rtrim(t.Observaciones), t,
    t.Dias_Permanencia, t,
    t.activo, t,
    rtrim(u.Departamento), t, rtrim(u.Provincia), t, rtrim(u.Distrito), t,
    rtrim(tt.descx_final), t, rtrim(ttt.DescripcionL), t, rtrim(t.Observaciones)
    from dbo.prog_ruta t, dbo.unidad_1 tt, dbo.ubigeo u, dbo.tipo_parada ttt
    where t.Id_Unidad = tt.coduni and right(cast(1000000 + tt.ubigeo as int), 6) = u.Id_Ubigeo
    and t.id_tipoParada = ttt.id_tipoParada and t.activo = 1 and t.estado = 1
    and t.Id_ProgExtraOrd = @data order by t.Id_ProgRuta
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep, tmp001_cab_prog_ruta c, tmp001_prog_ruta r
)
select concat(@pks, dato) from info001_prog_ruta

end try
begin catch
    select concat('error:', error_message())
end catch
end
go


declare @data varchar(100) = 3
exec dbo.usp_listar_prog_rutas @data
