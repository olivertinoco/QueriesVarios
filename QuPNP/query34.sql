if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_lista_hlp_prog_extraOrdinaria','p'))
drop procedure dbo.usp_lista_hlp_prog_extraOrdinaria
go
create procedure dbo.usp_lista_hlp_prog_extraOrdinaria
@data varchar(max)
as
begin
begin try
set nocount on
set language english
declare @item int, @dato varchar(100)
create table #tmp002_param(
    item int identity(990,1),
    dato varchar(max)
)
create table #tmp001_param(
    item int identity,
    dato1 varchar(100),
    dato2 varchar(100),
    dato3 varchar(100)
)
if @data is null return
select @data = concat('select*from(values(''', replace(replace(@data, '|', ''','''),'~', '''),('''), '''))t(a,b,c)')
insert into #tmp001_param exec(@data)

select @item = dato1 from #tmp001_param where item = 1
select @dato = dato1 from #tmp001_param where item = 2
if @item = 990
insert into #tmp002_param exec dbo.usp_buscar_vehiculo_programacion @dato

select @item = dato2 from #tmp001_param where item = 1
select @dato = dato2 from #tmp001_param where item = 2
if @item = 991 begin
select @dato = concat(@dato,'|')
insert into #tmp002_param exec dbo.usp_buscar_unidad_programacion @dato
end

select @item = dato3 from #tmp001_param where item = 1
select @dato = dato3 from #tmp001_param where item = 2
if @item = 992
insert into #tmp002_param exec dbo.usp_buscar_CIP_programacion @dato

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~','^'))t(sepCampo,sepReg,sepLst)
)
insert into #lista_hlp_prog_extraOrdinaria
select stuff((select i, item, r, dato  from #tmp002_param
for xml path, type).value('.','varchar(max)'),1,1,r)
from tmp001_sep

end try
begin catch
    select concat('error:', error_message())
end catch
end
go


select top 0
cast(null as varchar(max)) dato into #lista_hlp_prog_extraOrdinaria

declare @data varchar(max)
= '990|991|992~IL-24561|205419|30043331'

exec dbo.usp_lista_hlp_prog_extraOrdinaria @data

select*from #lista_hlp_prog_extraOrdinaria

select*from dbo.prog_extraord t where t.Id_ProgExtraOrd = 3
