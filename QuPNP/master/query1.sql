if exists(select 1 from sys.sysobjects where id=object_id('dbo.udf_split','if'))
drop function dbo.udf_split
go
create function dbo.udf_split(
@data varchar(max),
@sep varchar(1)='|'
)returns table as return(
select tt.n.value('.','varchar(max)') value
from(select cast(concat('<x>', replace(@data, @sep, '</x><x>'),'</x>') as xml) val)t
cross apply t.val.nodes('/x')tt(n)
)
go

declare @sep varchar(1)='~', @data varchar(max)
='145|598|788|'

select t.value from dbo.udf_split(@data, default)t


declare @data2 varchar(max)
='~145~598~788~'

select t.value from dbo.udf_split(@data2, @sep)t
