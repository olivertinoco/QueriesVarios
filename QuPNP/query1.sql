
-- alter table dbo.Unidad add UltimaUnidad varchar(2000)


select*from dbo.mastertable('dbo.VEHICULO')
select*from dbo.mastertable('dbo.ASIGNAR_VEHICULO_UNIDAD')
select*from dbo.mastertable('dbo.UNIDAD')
select*from dbo.mastertable('dbo.OPERATIVIDAD_VEHICULO')


select*from dbo.mastertable('dbo.TIPO_VEHICULO')
select*from dbo.mastertable('dbo.TIPO_MARCA')
select*from dbo.mastertable('dbo.TIPO_MODELO')
select*from dbo.mastertable('dbo.TIPO_COLOR')
select*from dbo.mastertable('dbo.TIPO_TRANSMISION')
select*from dbo.mastertable('dbo.TIPO_COMBUSTIBLE')



-- select hashbytes('sha2_256',concat(Id_Vehiculo, Placa_Interna)) id, Id_Vehiculo, Placa_Interna, Placa_Rodaje
-- from dbo.VEHICULO




-- NOTA: REFERENCIA A FOREIGN KEYS DE TABLAS
-- =========================================

-- select name, object_name(parent_object_id) u_ori, object_name(referenced_object_id) u_ref
-- from sys.foreign_keys order by 1


select
object_name(parent_object_id) u_padre,
col_name(parent_object_id, parent_column_id) campo_padre,
object_name(referenced_object_id) u_referenciada,
col_name(referenced_object_id, referenced_column_id) campo_referenciada
from sys.foreign_key_columns
where constraint_object_id = object_id('FK_ASIGNAR_VEHICULO_COMANDO_MASPOL')

select*from mastertable('dbo.ASIGNAR_VEHICULO_COMANDO')
select*from mastertable('dbo.MASPOL')
