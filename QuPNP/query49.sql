if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_buscar_prog_abastecimiento_diario_vehiculo','p'))
drop procedure dbo.usp_buscar_prog_abastecimiento_diario_vehiculo
go
create procedure dbo.usp_buscar_prog_abastecimiento_diario_vehiculo
@data varchar(100)
as
begin
begin try
set nocount on
set language english
declare @periodo_intervalo int = -2
create table #tmp001_param(
    interna varchar(50) collate database_default,
    rodajes varchar(50) collate database_default
)
select @data = dato from dbo.udf_splice(@data, default, default)
insert into #tmp001_param exec(@data)

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~','^'))t(sepCampo,sepReg,sepLst)
)
,tmp001_cab(dato)as(
    select concat(
    'a1|PLACA INTERNA|PLACA RODAJE|TARJETA MULTIFLOTA|TIPO VEHICULO|TIPO COMBUSTIBLE|GLNxDIA|GLNXMES|ID', r,
    '10|200|200|400|450|450|200|200|10')
    from tmp001_sep
)
,tmp001_periodo(mes, anno) as(
    select right(100 + month(dateadd(mm, @periodo_intervalo, getdate())), 2),
    year(dateadd(mm, @periodo_intervalo, getdate()))
)
select concat(c.dato, (select r,
t.Id_ProgVehiculo, t, t.placa_interna, t, t.placa_rodaje, t, tm.nro_tarjeta, t,
ltrim(tv.DescripcionL), t, ltrim(toc.DescripcionL), t, tt.GlnxDia, t, tt.GlnxMes, t, tm.Id_Multiflota
from dbo.prog_vehiculo t cross apply dbo.prog_dotacion tt
cross apply tmp001_periodo pp
cross apply #tmp001_param pa
outer apply(select*from dbo.tipo_vehiculo tv where tv.Id_TipoVehiculo = t.Id_TipoVehiculo) tv
outer apply(select*from dbo.tipo_combustible toc where toc.Id_TipoCombustible = t.Id_TipoCombustible) toc
outer apply(select top 1 *from dbo.prog_tarjeta_multiflota tm
where tm.id_vehiculo = t.id_vehiculo and tm.activo = 1 and tm.estado = 1)tm
where t.Id_ProgVehiculo = tt.Id_ProgVehiculo and pp.anno = t.anio and pp.mes = t.mes and
t.placa_interna like concat('%', pa.interna, '%') and t.placa_rodaje like concat('%', pa.rodajes, '%')
for xml path, type).value('.','varchar(max)'))
from tmp001_sep, tmp001_cab c


end try
begin catch
    select concat('error:', error_message())
end catch
end
go

exec dbo.usp_buscar_prog_abastecimiento_diario_vehiculo '736|'
exec dbo.usp_buscar_prog_abastecimiento_diario_vehiculo '|736'


select*from mastertable('dbo.prog_tarjeta_multiflota')
