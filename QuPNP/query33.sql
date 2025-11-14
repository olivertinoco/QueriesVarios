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
declare @periodo_intervalo int = -2

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~','^'))t(sepCampo,sepReg,sepLst)
)
,tmp001_cab(cab)as(
    select
    'p1|p2|IdPrgV|IdV|IdCom|IdOct|Placa Interna|Placa Rodaje|Tipo Vehículo|Tipo Combus.|Tipo Octanaje|Marca|Modelo~\
    10|10|10|10|10|10|150|150|300|200|200|250|250'
)
,tmp001_periodo(mes, anno) as(
    select right(100 + month(dateadd(mm, @periodo_intervalo, getdate())), 2), year(dateadd(mm, @periodo_intervalo, getdate()))
)
,hlp001_marcaModelo as(
    select t.Id_Vehiculo, ltrim(tt.DescripcionL) marca, ltrim(tm.DescripcionL) modelo
    from dbo.vehiculo t
    outer apply(select*from dbo.tipo_marca tt where tt.Id_TipoMarca = t.Id_TipoMarca) tt
    outer apply(select*from dbo.tipo_modelo tm where tm.Id_TipoModelo = t.Id_TipoModelo) tm
)
select concat(c.cab, (select r,
t.Placa_Interna, t, t.Placa_Interna, t, t.Id_ProgVehiculo, t, t.id_vehiculo, t,
rtrim(t.Id_TipoCombustible), t, t.Id_TipoOctanaje, t, t.Placa_Interna, t, t.Placa_Rodaje, t,
rtrim(ti.DescripcionL), t, rtrim(tc.DescripcionL), t, rtrim(tg.DescripcionL), t, mo.marca, t, mo.modelo
from dbo.prog_vehiculo t cross apply tmp001_periodo pp cross apply hlp001_marcaModelo mo
outer apply(select*from dbo.tipo_vehiculo ti where ti.Id_TipoVehiculo = t.Id_TipoVehiculo)ti
outer apply(select*from dbo.tipo_combustible tc where tc.Id_TipoCombustible = t.Id_TipoCombustible)tc
outer apply(select*from dbo.tipo_octanaje tg where tg.Id_TipoOctanaje = t.Id_TipoOctanaje)tg
where t.Anio = pp.anno and t.mes = pp.mes and t.flag_entrega = 1 and
t.Id_Vehiculo = mo.Id_Vehiculo and
t.Placa_Interna like concat('%', rtrim(ltrim(@data)), '%')
for xml path, type).value('.','varchar(max)'))
from tmp001_sep, tmp001_cab c

end try
begin catch
    select concat('error:', error_message())
end catch
end
go

exec dbo.usp_buscar_vehiculo_programacion 'TMP-0055'
exec dbo.usp_buscar_vehiculo_programacion '333'


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
declare @item int
create table #tmp001_tabla(
    item int identity,
    dato varchar(100)
)
insert into #tmp001_tabla select*from dbo.udf_split(@data, default)

select @data = dato from #tmp001_tabla where item = 1
select @item = isnull(nullif(coalesce((select dato from #tmp001_tabla where item = 2), '1'),''), @data)

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~','^'))t(sepCampo,sepReg,sepLst)
)
,tmp001_cab(cab)as(
    select
'cod|desc|ubigeo|Dpto|Prov|Dis|descripción Unidad:|subUni 1|subUni 2|subUni 3|\
subUni 4|subUni 5|subUni 6|subUni 7|subUni 8|subUni 9|Departamento|Provincia|Distrito~\
10|10|10|10|10|10|400|550|450|450|450|450|450|450|450|450|400|400|400'
)
select concat(c.cab, (select r, ltrim(str(t.coduni, 10,0)), t, rtrim(t.descx_final), t, u.Id_Ubigeo, t,
rtrim(u.Departamento), t, rtrim(u.Provincia), t, rtrim(u.Distrito), t, rtrim(t.descx_final), t,
t.xcol1, t, t.xcol2, t, t.xcol3, t, t.xcol4, t, t.xcol5, t, t.xcol6, t, t.xcol7, t, t.xcol8, t, t.xcol9, t,
rtrim(u.Departamento), t, rtrim(u.Provincia), t, rtrim(u.Distrito)
from dbo.unidad_1 t
outer apply(select*from dbo.UBIGEO u where u.Id_Ubigeo = right(cast(1000000 + t.ubigeo as int), 6))u
where (@item != 1 or t.descx_final like concat('%', rtrim(ltrim(@data)), '%')) and (@item = 1 or t.coduni = @item)
order by t.coduni1, t.coduni2, t.cod2, t.cod3, t.cod4, t.cod5, t.cod6, t.cod7, t.cod8, t.cod9
for xml path, type).value('.','varchar(max)'))
from tmp001_sep, tmp001_cab c

end try
begin catch
    select concat('error:', error_message())
end catch
end
go

exec dbo.usp_buscar_unidad_programacion 'trujillo'
exec dbo.usp_buscar_unidad_programacion '205419|'




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
    select 'cip1|cip2|idgrado|CIP|apellidos y nombres|Grado~10|10|10|100|400|150'
)
select concat(c.cab, (select r, t.Cip, t, t.Cip, t, ltrim(str(IdGrado,5,0)), t, t.Cip, t,
rtrim(Paterno), i, rtrim(Materno), i, rtrim(Nombres), t, rtrim(DesGrado)
from dbo.masterPNP t
where cip like concat('%', rtrim(ltrim(@data)), '%') order by t.cip
for xml path, type).value('.','varchar(max)'))
from tmp001_sep, tmp001_cab c

end try
begin catch
    select concat('error:', error_message())
end catch
end
go

exec dbo.usp_buscar_CIP_programacion '30043331'

set rowcount 10

select*from dbo.prog_extraord t where t.Id_ProgExtraOrd = 3
