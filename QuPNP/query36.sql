declare @data varchar(max)=
'1457~32|3|2|240274|PRUEBA DE OBSERVACION DE DATOS 01|52|0|35|3|5|240267|PRUEBA DE OBSERVACION DE DATOS 04|55|0|40|3|3|228674|SALUDO|0|0|42|3|3|228674|SALUDO|0|0||3|3|239376|OLIVER PRUEBA||1|5.1|5.2|5.3|5.4|5.5|5.6|5.9|5.1|5.2|5.3|5.4|5.5|5.6|5.9|5.1|5.2|5.3|5.4|5.5|5.6|5.9|5.1|5.2|5.3|5.4|5.5|5.6|5.9|5.1|5.2|5.3|5.4|5.5|5.6|5.9'
,@param varchar(100) = ''
,@pks varchar(100)='3'
set nocount on
set language english
declare @cab varchar(300), @aux varchar(max),
@tempGlob varchar(200) = replace(convert(varchar(36), newid()), '-','_')
select @tempGlob = case @param when '' then @tempGlob else @param end

declare
@maxi int, @tablas varchar(max), @Utabla tabla_generico, @merge varchar(max),
@usuario varchar(20) = substring(@data,0, charindex('~',@data))
select @data = stuff(@data,1, charindex('~',@data), '')
create table #tmp001_param(
    orden1 int identity,
    dato varchar(1000) collate database_default
)
select @data = concat('select*from(values(''', replace(@data, '|', '''),('''), '''))t(a)')
insert into #tmp001_param exec(@data)
select @maxi = scope_identity() / 2


select @tablas = stuff((select ',', tabla
from(select distinct parsename(dato, 2) item from #tmp001_param where orden1 > @maxi)t,
dbo.masterTablas tt where t.item = tt.item
for xml path, type).value('.','varchar(max)'),1,1,'')
insert into @Utabla
exec dbo.usp_listar_tablas @tablas

select distinct @tablas = tabla from @Utabla

select t.orden1, t.name, t.is_identity, t.default_object_id, t.is_primary_key into #tmp011_dato
from(select row_number()over(partition by t.name order by tt.orden1, t.name) __item9item,
tt.orden1, t.name, t.is_identity, t.default_object_id, t.is_primary_key
from @Utabla t, #tmp001_param tt
where tt.orden1 > @maxi and concat(t.item,'.',t.column_id) = tt.dato)t
where __item9item = 1


select*into #tmp001_dato from #tmp011_dato
union all select*from(
select row_number()over(order by (select 0))+999 item,
t.name, t.is_identity, t.default_object_id, t.is_primary_key
from @Utabla t where audit = 1 order by esFecha offset 0 rows)t


select*from #tmp001_dato order by orden1


;with tmp001_dato as(
    select*from #tmp001_dato
)
,tmp001_tabla_out(dato)as(
    select concat(stuff((select ',',name, ' varchar(50)' from #tmp001_dato
    where is_primary_key = 1 order by orden1
    for xml path, type).value('.','varchar(max)'),1,1, concat(';create table ##tmp001_salida',@tempGlob,'(')),')')
)
,tmp001_output(dato) as(
    select concat(stuff((select ',inserted.',name from #tmp001_dato
    where is_primary_key = 1 order by orden1
    for xml path, type).value('.','varchar(max)'),1,1,'output '),
    ' into ##tmp001_salida', @tempGlob, ';')
)
,tmp001_merge(dato) as(
    select concat(';merge into ', @tablas,
    ' t using #tmp001_datos s on(www)when matched then update set xxx when not matched then insert(yyy)values(zzz) ')
)
,tmp001_on(dato) as(
    select stuff((select ' and t.', name, '=s.', name
    from tmp001_dato where is_primary_key = 1 order by orden1
    for xml path, type).value('.','varchar(max)'),1,5,'')
)
,tmp001_matched(dato) as(
    select stuff((select ',t.', name, '=s.', name
    from tmp001_dato where is_primary_key = 0 and is_identity = 0 order by orden1
    for xml path, type).value('.','varchar(max)'),1,1,'')
)
,tmp001_not_matched(dato) as(
    select stuff((select ',',name
    from tmp001_dato where is_identity = 0 and default_object_id = 0 order by orden1
    for xml path, type).value('.','varchar(max)'),1,1,'')
)
,tmp002_not_matched(dato) as(
    select stuff((select ',s.',name
    from tmp001_dato where is_identity = 0 and default_object_id = 0 order by orden1
    for xml path, type).value('.','varchar(max)'),1,1,'')
)
select @merge = concat(t5.dato,
replace(replace(replace(replace(t.dato, 'www', t1.dato), 'xxx', t2.dato), 'yyy', t3.dato), 'zzz', t4.dato)
,t6.dato)
from tmp001_merge t,
tmp001_on t1,
tmp001_matched t2,
tmp001_not_matched t3,
tmp002_not_matched t4,
tmp001_tabla_out t5,
tmp001_output t6

select @tablas = concat('select ', stuff((select ',', case is_identity when 1 then 'cast(null as int)' end, name
from #tmp001_dato order by orden1
for xml path, type).value('.','varchar(max)'),1,1,''), ' into #tmp001_datos from ', @tablas, ' where 1=2;')

select orden1, dato into #tmp001_data_crud from #tmp001_param where orden1 < @maxi + 1


;with tmp001_totalReg(tot)as(
    select count(1) from #tmp001_data_crud
)
,tmp001_totalCampos(camp)as(
    select count(1) nro from #tmp011_dato
)
,tmp001_registros as(
    select multiplo, max(multiplo)over() maxi
    from tmp001_totalReg cross apply tmp001_totalCampos cross apply dbo.fn_MultiplosGenericos(camp,tot)
)
,tmp001_valorMaximo as(
    select distinct maxi from tmp001_registros
)
,tmp001_cuentas as(
    select t.item
    from(select row_number()over(order by (select 1)) item from sys.fn_helpcollations())t,
    tmp001_valorMaximo tt where t.item < tt.maxi + 1
)
select*from tmp001_cuentas t
outer apply(select*from tmp001_registros tt where tt.multiplo = t.item)tt

-- ,tmp001_nombreCampos(dato)as(
--     select stuff((select ',a', orden1 from #tmp011_dato order by orden1
--     for xml path, type).value('.','varchar(max)'),1,1,'')
-- )
-- -- select @cab = dato, @aux = (
-- -- select t.dato, case when tt.multiplo is null then '|' else iif(t.orden1 = tt.maxi, '', '~') end
-- select t.*, tt.*, dense_rank()over(partition by multiplo order by orden1)
-- from #tmp001_data_crud t
-- outer apply(select*from tmp001_registros tt where tt.multiplo = t.orden1)tt
-- order by t.orden1
-- for xml path, type).value('.','varchar(max)')
-- from tmp001_nombreCampos


-- select @tablas += concat('insert into #tmp001_datos select*,''', @usuario, ''',''',
-- convert(varchar, getdate(), 121), ''' from(values(''',
-- replace(replace(@aux, '|', ''','''), '~', '''),('''), '''))t(', @cab, ')')


-- select(@tablas + @merge)

-- if @param = ''
-- select('select*from ##tmp001_salida' + @tempGlob)


-- delete dbo.prog_ruta where Id_ProgRuta > 39
-- select* from dbo.prog_ruta where Id_ProgExtraOrd = 3 order by 1
