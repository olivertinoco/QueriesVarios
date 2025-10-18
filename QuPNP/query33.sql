if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_buscar_vehiculo_programacion','p'))
drop procedure dbo.usp_buscar_vehiculo_programacion
go
create procedure dbo.usp_buscar_vehiculo_programacion
@data varchar(100)
as
begin
begin try
set nocount on
set language english
declare @periodo_intervalo int = -1

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~','^'))t(sepCampo,sepReg,sepLst)
)
,tmp001_cab(cab)as(
    select
    'IdPrgV|IdV|IdCom|IdOct|Placa Interna|Placa Rodaje|Tipo Vehiculo|Tipo Combus.|Tipo Octanaje~10|10|10|10|150|150|300|100|100'
)
,tmp001_periodo(mes, anno) as(
    select right(100 + month(dateadd(mm, @periodo_intervalo, getdate())), 2), year(dateadd(mm, @periodo_intervalo, getdate()))
)
select concat(c.cab, (select r, t.Id_ProgVehiculo, t, t.id_vehiculo, t, rtrim(t.Id_TipoCombustible), t, t.Id_TipoOctanaje, t,
t.Placa_Interna, t, t.Placa_Rodaje, t, rtrim(ti.DescripcionL), t, rtrim(tc.DescripcionL), t, rtrim(tg.DescripcionL)
from dbo.prog_vehiculo t cross apply tmp001_periodo pp
outer apply(select*from dbo.tipo_vehiculo ti where ti.Id_TipoVehiculo = t.Id_TipoVehiculo)ti
outer apply(select*from dbo.tipo_combustible tc where tc.Id_TipoCombustible = t.Id_TipoCombustible)tc
outer apply(select*from dbo.tipo_octanaje tg where tg.Id_TipoOctanaje = t.Id_TipoOctanaje)tg
where t.Anio = pp.anno and t.mes = pp.mes and t.flag_entrega = 1 and
t.Placa_Interna like concat('%', @data, '%')
for xml path, type).value('.','varchar(max)'))
from tmp001_sep, tmp001_cab c

end try
begin catch
    select concat('error:', error_message())
end catch
end
go

exec dbo.usp_buscar_vehiculo_programacion 'TMP-0055'




if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_buscar_unidad_programacion','p'))
drop procedure dbo.usp_buscar_unidad_programacion
go
create procedure dbo.usp_buscar_unidad_programacion
@data varchar(100)
as
begin
begin try
set nocount on
set language english

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~','^'))t(sepCampo,sepReg,sepLst)
)
,tmp001_cab(cab)as(
    select
'cod|Dpto|Prov|Dis|descr|subUni 1|subUni 2|subUni 3|subUni 4|subUni 5|subUni 6|subUni 7|subUni 8|subUni 9~\
10|10|10|10|400|450|450|450|450|450|450|450|450|450'
)
select concat(c.cab, (select r, ltrim(str(t.coduni, 10,0)), t,
rtrim(u.Departamento), t, rtrim(u.Provincia), t, rtrim(u.Distrito), t, rtrim(t.descx_final), t,
t.xcol1, t, t.xcol2, t, t.xcol3, t, t.xcol4, t, t.xcol5, t, t.xcol6, t, t.xcol7, t, t.xcol8, t, t.xcol9
from dbo.unidad_1 t
outer apply(select*from dbo.UBIGEO u where u.Id_Ubigeo = right(cast(1000000 + t.ubigeo as int), 6))u
where t.descx_final like concat('%', @data, '%')
order by t.coduni1, t.coduni2, t.cod2, t.cod3, t.cod4, t.cod5, t.cod6, t.cod7, t.cod8, t.cod9
for xml path, type).value('.','varchar(max)'))
from tmp001_sep, tmp001_cab c


end try
begin catch
    select concat('error:', error_message())
end catch
end
go

exec dbo.usp_buscar_unidad_programacion 'la noria'




if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_buscar_CIP_programacion','p'))
drop procedure dbo.usp_buscar_CIP_programacion
go
create procedure dbo.usp_buscar_CIP_programacion
@data varchar(100)
as
begin
begin try
set nocount on
set language english

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~',' '))t(sepCampo,sepReg,sepLst)
)
,tmp001_cab(cab)as(
    select 'idgrado|CIP|apellidos y nombres|Grado~10|100|400|150'
)
select concat(c.cab, (select r, ltrim(str(IdGrado,5,0)), t, Cip, t,
rtrim(Paterno), i, rtrim(Materno), i, rtrim(Nombres), t, rtrim(DesGrado)
from dbo.masterPNP
where cip like concat('%', @data, '%') order by cip
for xml path, type).value('.','varchar(max)'))
from tmp001_sep, tmp001_cab c


end try
begin catch
    select concat('error:', error_message())
end catch
end
go

exec dbo.usp_buscar_CIP_programacion '13'
