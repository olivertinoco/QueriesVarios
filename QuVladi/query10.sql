-- NOTA: PRUEBAS ...
declare @data varchar(max)
-- ='52|1655419281410|32|2|52|4||54|52|7||7|1.1.1|1.1.36|1.1.25|1.1.29|2.3.1|2.3.3|2.3.2|2.3.4|3.3.1|3.3.3|3.3.2|3.3.4'
='|2025-06-05|1655419281410|52|3|F|1978-05-26|876543210|CA|elisa.milagros.ortega@gmail.com|oliver suarez tinoco|13|984474025|16|10|50|2|||la noria Emanuel Kant #387|130101||1||e||2||12||4||45||7||33|40545510|1.1.1|1.1.9|1.1.36|1.1.25|1.1.19|1.1.6|1.1.16|1.1.12|1.1.14|1.1.11|1.1.31|1.1.32|1.1.33|1.1.15|1.1.38|1.1.39|1.1.29|1.2.1|1.2.2|1.2.4|1.2.9|0.3.1|0.3.3|0.3.2|0.3.4|1.3.1|1.3.3|1.3.2|1.3.4|2.3.1|2.3.3|2.3.2|2.3.4|3.3.1|3.3.3|3.3.2|3.3.4|1.4.4'


set nocount on

create table #tmp001_tabla_iterar(
    item int identity,
    obj int
)
select top 0
cast(null as int) item,
cast(null as int) maxi,
cast(null as int) grupo,
cast(null as int) tblOne,
cast(null as varchar(100)) tabla,
cast(null as varchar(100)) campo,
cast(null as varchar(100)) dato into #tmp001_splitCadena
exec dbo.usp_splitCadena @data

update t set grupo = g
from(select*,dense_rank()over(partition by tabla order by grupo) g from #tmp001_splitCadena)t

declare @newid varchar(36), @salida varchar(max), @merge varchar(max),
@tmpTabla varchar(max), @tot int, @obj int, @item int = 1

select @newid = replace(convert(varchar(36), newid()), '-','_')
exec('select top 0 cast(null as int) [12_12] into ##tmp001_'+ @newid)

-- temporal
declare @tabla varchar(max)

insert into #tmp001_tabla_iterar
select distinct id from dbo.udf_lisTablas(default)t cross apply #tmp001_splitCadena tt
where t.tabla = tt.tabla order by id

select @tot = count(1) +1 from #tmp001_tabla_iterar

set tran isolation level read uncommitted
begin try
begin tran

-- NOTA: Aqui seleccionamos U con la que se trabajara.
-- ==================================================
while @item < @tot begin
select @obj = obj from #tmp001_tabla_iterar where item = @item

select @salida = (select top 1 case itty when 1 then
concat('output inserted.Pos_Id into ##tmp001_', @newid,'([12_12]);') else ';' end
from dbo.udf_lisTablas(@obj) cross apply dbo.udf_getpk(tabla)
order by itty desc)


select @data = concat(
stuff((select ',', case campo when 'Pos_Id'
then 'cast(null as int) Pos_Id' else campo end
from #tmp001_splitCadena
where tabla = tbl and grupo = 1 order by item
for xml path, type).value('.','varchar(max)'),1,1, 'select '),
' into #', stuff(tbl, 1, 4, ''), ' from ', tbl, ' where 1=2')
from (select tabla tbl from dbo.udf_lisTablas(@obj))UU


select @data += (select distinct datos from(select
datos = concat(';insert into #', stuff(tbl,1,4,''),
stuff((select ',''', dato, ''''
from #tmp001_splitCadena t
where t.tabla = tbl and t.tabla = tt.tabla and t.grupo = tt.grupo
order by t.grupo, t.item
for xml path, type).value('.','varchar(max)'),1,1, ' select '))
from #tmp001_splitCadena tt
cross apply (select tabla tbl from dbo.udf_lisTablas(@obj))UU
cross apply (select top 1 pk from dbo.udf_getpk(tbl) order by def)P
where tt.tabla = tbl
order by tt.grupo, tt.item offset 0 rows)t
for xml path, type).value('.','varchar(max)')


select top 1 @data +=
concat(';update t set Pos_id = [12_12] from #', stuff(tbl,1,4,''),
' t, ##tmp001_', @newid, ' tt')
from #tmp001_splitCadena tt
cross apply (select tabla tbl from dbo.udf_lisTablas(@obj))UU
where tt.tabla = tbl
order by tt.grupo, tt.item

-- temporal
select @item ITEM
select @tabla = (select stuff(tabla,1,4,'') from dbo.udf_lisTablas(@obj))
exec(@data + ' select*from #' + @tabla)



select @merge = concat(stuff((select
case when gCorr = 1 then concat(' and t.', campo, '=s.', campo)
when gCorr = 2 and item = 1 then concat(') when matched then update set t.', campo, '=s.', campo)
when gCorr = 2 and item > 1 then concat(',t.', campo, '=s.', campo)
when gCorr = 3 and item = 1 then concat(',ModiId=default,ModiFecha=default when not matched then insert(', campo)
when gCorr = 3 and item > 1 then concat(',', campo)
when gCorr = 4 and item = 1 then concat(')values(s.', campo)
when gCorr = 4 and item > 1 and item < maxi then concat(',s.', campo)
when gCorr = 4 and item = maxi then concat(',s.', campo) end
from(select gCorr, item, tabla, campo,
maxi = max(item)over(partition by gCorr)
from(select gCorr, item, maxi, tabla, campo
from(select tt.gCorr, grupo, pk, tabla, campo, maxi, itty, def,
item = row_number()over(partition by tt.gCorr order by item)
from(select t.pk, tt.tabla, tt.campo, tt.item, tt.maxi, tt.grupo, t.itty, t.def, t.req
from #tmp001_splitCadena tt
cross apply (select tabla tbl from dbo.udf_lisTablas(@obj)) u
outer apply(select*from dbo.udf_getpk(u.tbl)t where t.pk = tt.campo)t
where tt.tabla = u.tbl)t,(values(1),(2),(3),(4))tt(gCorr)
where t.grupo = 1 and
not (tt.gCorr = 1 and t.pk is null) and
not (tt.gCorr = 2 and not t.pk is null) and
not (tt.gCorr = 3 and not t.pk is null and (t.itty = 1 or (t.def != 0 and t.req = 0))) and
not (tt.gCorr = 4 and not t.pk is null and (t.itty = 1 or (t.def != 0 and t.req = 0)))
order by tt.gCorr, t.item offset 0 rows)t
order by t.gCorr,  t.item offset 0 rows)t
order by t.gCorr,  t.item offset 0 rows)t
order by t.gCorr,  t.item
for xml path, type).value('.','varchar(max)'),1,5,
concat(';merge into ', tbl, ' t using [999-999] s on(')), ')', @salida)
from (select tabla tbl from dbo.udf_lisTablas(@obj))UU

select @tmpTabla = isnull(stuff((select ',',
case isnull(ttt.def, 0) when 0 then t.campo
else concat('isnull(nullif(', t.campo, ',0), tt.[22_22]) ', t.campo) end,
case t.tblOne when t.maxi then
concat(stuff(t.tabla,1,4,' from(select row_number()over(order by (select 1)) [11_11],*from #'),
')t cross apply dbo.udf_corrEpp([11_11])tt)') end
from #tmp001_splitCadena t cross apply dbo.udf_lisTablas(@obj)tt
outer apply(select*from dbo.udf_getpk(t.tabla)ttt where ttt.pk = t.campo)ttt
where t.tabla = tt.tabla and t.grupo = 1 and @obj = 3
order by t.item
for xml path, type).value('.', 'varchar(max)'),1,1, '(select '), stuff(U.tabla,1,4,'#'))
from dbo.udf_lisTablas(@obj)U

select @merge = replace(@merge, '[999-999]', @tmpTabla)


exec(@data + @merge)
-- select(@data)
-- select(@merge)

select @item +=1
end

commit tran;
end try
begin catch
rollback tran;
select 'error:' + error_message()
end catch


select top 0 cast(null as int) id into #tmp001_pos_id
insert into #tmp001_pos_id exec('select*from ##tmp001_' + @newid)


select*from dev.RH10_Postulantes, #tmp001_pos_id where pos_id = id
select*from dev.RH10_PosDirecciones, #tmp001_pos_id where pos_id = id
select*from dev.RH10_PosEPPs, #tmp001_pos_id where pos_id = id
select*from dev.A00_Usuarios, #tmp001_pos_id where pos_id = id
