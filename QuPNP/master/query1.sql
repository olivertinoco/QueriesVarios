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

if exists(select 1 from sys.sysobjects where id=object_id('dbo.fn_LimpiarXML','fn'))
drop function dbo.fn_LimpiarXML
go
create function dbo.fn_LimpiarXML (@Texto varchar(max))
returns varchar(max)
as
begin
    DECLARE @i INT = 0
    WHILE @i <= 31
    BEGIN
        SET @Texto = REPLACE(@Texto, CHAR(@i), '')
        SET @i += 1
    END
    RETURN @Texto
end
GO


if exists(select 1 from sys.sysobjects where id=object_id('dbo.fn_MultiplosGenericos','if'))
drop function dbo.fn_MultiplosGenericos
go
create function dbo.fn_MultiplosGenericos
(
    @nroBase INT,
    @limite INT
)
RETURNS TABLE AS RETURN
(
    WITH Numeros AS
    (
        SELECT TOP (convert(int, CEILING(1.0 * @limite / @nroBase))) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
        FROM sys.objects
    )
    SELECT n * @nroBase AS Multiplo
    FROM Numeros
    WHERE n * @nroBase <= @limite
)
go

select multiplo from dbo.fn_MultiplosGenericos(6,24)


declare @sep varchar(1)='~', @data varchar(max)
='145|598|788|'

select t.value from dbo.udf_split(@data, default)t


declare @data2 varchar(max)
='~145~598~788~'

select t.value from dbo.udf_split(@data2, @sep)t
