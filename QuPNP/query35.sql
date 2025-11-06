declare @data varchar(max) =
-- '1457~3|368459|4036|DFS2|4.1|4.4|4.2|4.25^1457~35|3|5|240267|PRUEBA DE OBSERVACION DE DATOS 04|55|0|5.1|5.2|5.3|5.4|5.5|5.6|5.9'
'1457~3|368459|4036|DFS2|4.1|4.4|4.2|4.25^1457~35|3|5|240267|PRUEBA DE OBSERVACION DE DATOS 04|55|0|5.1|5.2|5.3|5.4|5.5|5.6|5.9'

-- '^1457~35|3|5|240267|PRUEBA DE OBSERVACION DE DATOS 04|55|0|5.1|5.2|5.3|5.4|5.5|5.6|5.9'


declare @pks varchar(100),
@tempGlob varchar(200) = replace(convert(varchar(36), newid()), '-','_')
select top 0 cast(null as varchar(100)) collate database_default pks into #tmp001_pks
create table #tmp001_tablas(
    item int identity,
    dato varchar(max) collate database_default
)
insert into #tmp001_tablas
select*from dbo.udf_split(@data, '^')
select @data = dato from #tmp001_tablas where item = 1
exec dbo.usp_crud_generico01 @data, @tempGlob
exec ('insert into #tmp001_pks select*from ##tmp001_salida' + @tempGlob)
select @data = dato from #tmp001_tablas where item = 2
select @pks = pks from #tmp001_pks


select @pks, @data

select* from dbo.prog_ruta




-- select*from dbo.prueba_ruta
-- select*from dbo.mastertablas



-- set identity_insert dbo.prog_ruta on
-- insert into dbo.prog_ruta(Id_ProgRuta, Id_ProgExtraOrd, Id_TipoParada, Id_Unidad, Observaciones, Dias_Permanencia, UsuarioI, FechaI, Activo, Estado)
-- select*from dbo.prueba_ruta
-- set identity_insert dbo.prog_ruta off
