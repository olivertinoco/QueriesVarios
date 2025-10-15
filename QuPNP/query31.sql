if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_buscar_Grupo_bien','p'))
drop procedure dbo.usp_buscar_Grupo_bien
go
create procedure dbo.usp_buscar_Grupo_bien
@data varchar(300)
as
begin
set nocount on
set language english
begin try

select top 0
cast(null as int) Id_TipoDocumento,
cast(null as varchar(100)) Nro_Documento,
cast(null as date) f_ini,
cast(null as date) f_fin into #tmp001_params
select @data = concat('select a1,a2,a3, case a4 when '''' then a3 else a4 end from(values(''',
replace(@data, '|', ''','''), '''))t(a1,a2,a3,a4)')
insert into #tmp001_params exec(@data)

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~','^'))t(sepCampo,sepReg,sepLst)
)
,tmp001_cab(cab)as(
    select 'IdBien|Tipo Doc.|Fecha Documento|Nro. Documento~10|100|150|450'
)
select concat(c.cab, (select r,
t.Id_GrupoBien, t,
rtrim(d.DescripcionL), t,
convert(varchar, t.Fec_Documento, 23), t,
rtrim(t.Nro_Documento)
from dbo.grupo_bien t cross apply #tmp001_params tt
outer apply(select*from dbo.tipo_documento d where d.Id_TipoDocumento = t.Id_TipoDocumento)d
where t.Id_TipoDocumento = case tt.Id_TipoDocumento when 0 then t.Id_TipoDocumento else tt.Id_TipoDocumento end and
t.Nro_Documento like concat('%', tt.Nro_Documento, '%') and
(tt.f_ini = cast('' as date) or t.Fec_Documento between tt.f_ini and tt.f_fin) order by t.Fec_Documento desc
for xml path, type).value('.','varchar(max)'))
from tmp001_sep, tmp001_cab c

end try
begin catch
    select concat('error:', error_message())
end catch
end
go

declare @data varchar(200)
-- = '5|MAIR|2025-10-06|2025-10-01'
-- = '|DIV|2019-11-27|'
= '|DIV||'

exec dbo.usp_buscar_Grupo_bien @data

-- select convert(varchar, t.Fec_Documento, 23), rtrim(t.Nro_Documento)
-- from dbo.grupo_bien t where Nro_Documento like '%div%' order by Fec_Documento desc



-- set rowcount 10

-- -- update t set Id_GrupoBien = 117 from dbo.vehiculo t where id_vehiculo = 335282

-- select*from dbo.vehiculo

-- select*from dbo.grupo_bien where Id_GrupoBien = 117
