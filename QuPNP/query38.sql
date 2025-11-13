if exists(select 1 from sys.sysobjects where id=object_id('dbo.udf_detalle_prog_eo_grifo','if'))
drop function dbo.udf_detalle_prog_eo_grifo
go
create function dbo.udf_detalle_prog_eo_grifo(
    @data varchar(max),
    @Utabla tabla_generico readonly
)returns table as return(
with tmp001_sep(t,r,i,a)as(
    select*from(values('|','~','^','*'))t(sepCampo,sepReg,sepLst,sepAux)
)
,info001_grifos as(
    select t.Id_Grifo, rtrim(t.NombreGrifo) nombre,
    rtrim(u.Departamento) depa, rtrim(u.Provincia) prov, rtrim(u.Distrito) dist
    from dbo.grifo t
    outer apply(select*from dbo.UBIGEO u where u.Id_Ubigeo =t.Id_Ubigeo)u
    where t.activo = 1 and t.estado = 1
)
,tmp001_prog_eo_grifo_meta(dato)as(
select stuff((select '+', substring(t.value, 0, charindex(a, t.value))
from dbo.udf_general_metadata02(
't.Id_EOGrifos..*,
t.Id_ProgRuta..*,
t.Id_Grifo..*,
t.Fec_Abastecimiento..*,
t.CantidadAbastecimiento..*,
t.activo..*',
't.prog_eo_grifo',
@Utabla)tt cross apply dbo.udf_split(tt.dato, default)t
for xml path, type).value('.','varchar(max)'),1,2,r)
from tmp001_sep
)
,tmp001_cab(dato)as(
select '~a1|a2|a3|a4|a5|a6|a7|a8|a9|a10|a11|GRIFO|DOTACION~\
10|10|10|10|10|10|10|10|10|10|10|450|200'
)
select concat(i, 743, m.dato, c.dato, (select m.dato, t,
t.Id_EOGrifos, t,
t.Id_ProgRuta, t,
t.Id_Grifo, t,
t.Fec_Abastecimiento, t,
t.CantidadAbastecimiento, t,
t.activo, t,
g.nombre, t,
g.depa, t,
g.prov, t,
g.dist, t,
g.nombre, t,
t.CantidadAbastecimiento
from dbo.prog_extraord tt cross apply dbo.prog_ruta ttt cross apply dbo.prog_eo_grifo t
outer apply(select*from info001_grifos g where g.Id_Grifo = t.Id_Grifo)g
where tt.Id_ProgExtraOrd = ttt.Id_ProgExtraOrd and ttt.Id_ProgRuta = t.Id_ProgRuta
and t.estado = 1 and t.activo = 1 and tt.Id_ProgExtraOrd = @data
for xml path, type).value('.', 'varchar(max)')) dato
from tmp001_sep, tmp001_prog_eo_grifo_meta m, tmp001_cab c

)
go





declare @Utabla22 tabla_generico
insert into @Utabla22
exec dbo.usp_listar_tablas 'dbo.prog_eo_grifo'

select*from dbo.udf_detalle_prog_eo_grifo(3, @Utabla22)
select*from dbo.udf_detalle_prog_eo_grifo(0, @Utabla22)
select*from dbo.udf_detalle_prog_eo_grifo('', @Utabla22)
