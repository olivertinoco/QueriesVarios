if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_buscar_unidad_prog_abastecimiento_diario','p'))
drop procedure dbo.usp_buscar_unidad_prog_abastecimiento_diario
go
create procedure dbo.usp_buscar_unidad_prog_abastecimiento_diario
@data varchar(100) = ''
as
begin
begin try
set nocount on
set language english

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~','^'))t(sepCampo,sepReg,sepLst)
)
,tmp001_cab(cab)as(
    select 'cod|descripción Unidad|Departamento|Provincia|Distrito|des~10|550|450|450|450|10'
)
select concat(c.cab, (select r,
ltrim(str(t.coduni, 10,0)), t, rtrim(t.descx_final), t,
rtrim(u.Departamento), t, rtrim(u.Provincia), t, rtrim(u.Distrito), t, rtrim(t.descx_final)
from dbo.unidad_1 t
outer apply(select*from dbo.UBIGEO u where u.Id_Ubigeo = right(cast(1000000 + t.ubigeo as int), 6))u
where t.descx_final like concat('%', rtrim(ltrim(@data)), '%')
order by t.coduni1, t.coduni2, t.cod2, t.cod3, t.cod4, t.cod5, t.cod6, t.cod7, t.cod8, t.cod9
for xml path, type).value('.','varchar(max)'))
from tmp001_sep, tmp001_cab c

end try
begin catch
    select concat('error:', error_message())
end catch
end
go

exec dbo.usp_buscar_unidad_prog_abastecimiento_diario 'trujillo'
