if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_busqueda_prog_ord_extra','p'))
drop procedure dbo.usp_busqueda_prog_ord_extra
go
create procedure dbo.usp_busqueda_prog_ord_extra
as
begin
begin try
set nocount on
set language english

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~','^'))t(sepCampo,sepReg,sepLst)
)
,hlp_TipoDocumento(dato)as(
    select concat(i, 81, (select r, Id_TipoDocumento, t, rtrim(DescripcionL)
    from dbo.TIPO_DOCUMENTO where activo = 1 and estado = 1 order by 2
    for xml path, type).value('.','varchar(max)'))
    from tmp001_sep
)
select concat(r, '400.1*****111*81*Tipo Documento :|400.2****20*101*82*Nro. Documento :|\
400.3****50*101*83*Nro. Orden Comisión:|400.4*****102*84*Orden Comisión inicio|\
400.5*****102*85*Orden Comisión final', t.dato)
from tmp001_sep, hlp_TipoDocumento t

end try
begin catch
    select concat('error:', error_message())
end catch
end
go

exec dbo.usp_busqueda_prog_ord_extra


if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_busqueda_list_prog_extraord','p'))
drop procedure dbo.usp_busqueda_list_prog_extraord
go
create procedure dbo.usp_busqueda_list_prog_extraord
@data varchar(max)
as
begin
begin try
set nocount on
set language english

select Id_TipoDocumento, Nro_Documento, Nro_OrdenComision, Fec_InicioComision, Fec_TerminoComision
into #tmp001_param from dbo.prog_extraord where 1 = 2
select @data = dato from dbo.udf_splice(@data, default, default)
insert into #tmp001_param exec(@data)

if exists(select 1 from #tmp001_param where Fec_InicioComision != cast('' as date))
update t set Fec_TerminoComision =
case Fec_TerminoComision when cast('' as date) then getdate() else  Fec_TerminoComision end
from #tmp001_param t

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~','^'))t(sepCmp, sepRg, sepLs)
)
,tmp001_cab(dato)as(
select 'a1|PLACA INTERNA|PLACA RODAJE|TIPO COMBUSTIBLE|TIPO DOCUMENTO|NRO DOCUMENTO|NRO ORDEN COM.|\
FEC. ORDEN COM~10|200|200|350|450|450|300|300'
)
select concat(c.dato, (
select r, t.Id_ProgExtraOrd, t, t.Placa_Interna, t, t.Placa_Rodaje, t, rtrim(ttt.DescripcionL), t,
rtrim(tt.DescripcionL), t, t.Nro_Documento, t, t.Nro_OrdenComision, t,
convert(varchar, t.Fec_OrdenComision, 23)
from dbo.prog_extraord t cross apply #tmp001_param p
outer apply(select*from dbo.tipo_documento tt where tt.Id_TipoDocumento = t.Id_TipoDocumento)tt
outer apply(select*from dbo.tipo_combustible ttt where ttt.Id_TipoCombustible = t.Id_TipoCombustible)ttt
where (p.Id_TipoDocumento = 0 or t.Id_TipoDocumento = p.Id_TipoDocumento) and
(t.Nro_Documento like concat('%', p.Nro_Documento, '%')) and
(t.Nro_OrdenComision like concat('%', p.Nro_OrdenComision, '%')) and
(p.Fec_InicioComision = cast('' as date) or
t.Fec_OrdenComision between p.Fec_InicioComision and p.Fec_TerminoComision) and
t.activo = 1 and t.estado = 1
for xml path, type).value('.', 'varchar(max)'))
from tmp001_sep, tmp001_cab c

end try
begin catch
    select concat('error:', error_message())
end catch
end
go

dbo.usp_busqueda_list_prog_extraord '|SD|||'

select*from dbo.prog_extraord
