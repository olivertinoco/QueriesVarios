

if exists(select 1 from sys.sysobjects where id = object_id('mastertable','if'))
drop function mastertable
go
create function mastertable(
    @par_nombreTabla varchar(max)
)returns table as return(
  select top 1000 convert(varchar(50), @par_nombreTabla) tabla,
  convert(varchar(60), c.name) name, c.column_id, convert(varchar(10),type_name(c.system_type_id)) type, c.max_length,
  convert(varchar,c.collation_name) collation_name, c.is_nullable, c.is_identity, c.default_object_id, i.is_primary_key
  from sys.columns c outer apply(select coalesce((
  select i.is_primary_key from sys.index_columns ic cross apply sys.indexes i
  where  i.object_id       = ic.object_id and
         i.index_id        = ic.index_id  and
         i.is_primary_key  = 1            and
         ic.object_id      = c.object_id  and
         ic.column_id      = c.column_id), 0) is_primary_key)i
  where c.object_id = object_id(@par_nombreTabla, 'U') order by c.column_id
)
go




-- restore filelistonly from 
-- disk='C:\OLIVER\BK_TRANSPORTE22072025'
-- restore headeronly from 
-- disk='C:\OLIVER\BK_TRANSPORTE22072025'




-- NOTA: RESTORE X SQL2022 -- EN EL HOST LOCAL
-- =======================
-- restore database TRANSPORTE from 
-- disk='C:\OLIVER\BK_TRANSPORTE22072025' with replace,
-- move 'TRANSPORTE' to 'C:\OLIVER\DB\TRANSPORTE_2014.mdf',
-- move 'TRANSPORTE_log' to 'C:\OLIVER\DB\TRANSPORTE_2014_log.ldf'



return
select*from sys.tables order by 1;

-- select @@version;
-- select*from sys.databases;
-- select*from sys.sysdatabases;

-- select*from sys.master_files;

-- select*from sys.procedures order by 1;


