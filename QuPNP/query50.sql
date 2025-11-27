-- if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_buscar_unidad_programacion','p'))
-- drop procedure dbo.usp_buscar_unidad_programacion
-- go
-- create procedure dbo.usp_buscar_unidad_programacion
declare
@data varchar(100)
-- as
-- begin
-- begin try
set nocount on
set language english
declare @item int
create table #tmp001_tabla(
    item int identity,
    dato varchar(100)
)
insert into #tmp001_tabla select*from dbo.udf_split(@data, default)

select @data = dato from #tmp001_tabla where item = 1
select @item = isnull(nullif(coalesce((select dato from #tmp001_tabla where item = 2), '1'),''), @data)

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~','^'))t(sepCampo,sepReg,sepLst)
)
,tmp001_cab(cab)as(
    select
'cod|desc|ubigeo|Dpto|Prov|Dis|descripción Unidad:|subUni 1|subUni 2|subUni 3|\
subUni 4|subUni 5|subUni 6|subUni 7|subUni 8|subUni 9|Departamento|Provincia|Distrito~\
10|10|10|10|10|10|400|550|450|450|450|450|450|450|450|450|400|400|400'
)
select concat(c.cab, (select r, ltrim(str(t.coduni, 10,0)), t, rtrim(t.descx_final), t, u.Id_Ubigeo, t,
rtrim(u.Departamento), t, rtrim(u.Provincia), t, rtrim(u.Distrito), t, rtrim(t.descx_final), t,
t.xcol1, t, t.xcol2, t, t.xcol3, t, t.xcol4, t, t.xcol5, t, t.xcol6, t, t.xcol7, t, t.xcol8, t, t.xcol9, t,
rtrim(u.Departamento), t, rtrim(u.Provincia), t, rtrim(u.Distrito)
from dbo.unidad_1 t
outer apply(select*from dbo.UBIGEO u where u.Id_Ubigeo = right(cast(1000000 + t.ubigeo as int), 6))u
where (@item != 1 or t.descx_final like concat('%', rtrim(ltrim(@data)), '%')) and (@item = 1 or t.coduni = @item)
order by t.coduni1, t.coduni2, t.cod2, t.cod3, t.cod4, t.cod5, t.cod6, t.cod7, t.cod8, t.cod9
for xml path, type).value('.','varchar(max)'))
from tmp001_sep, tmp001_cab c




-- end try
-- begin catch
--     select concat('error:', error_message())
-- end catch
-- end
-- go

-- exec dbo.usp_buscar_unidad_programacion 'trujillo'
-- exec dbo.usp_buscar_unidad_programacion '205419|'
--
