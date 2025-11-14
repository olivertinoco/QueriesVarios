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
400.3****50*101*83*Nro. Orden Comisión:|400.4*****102*84*Fecha Inicio Comisión|\
400.5*****102*85*Fecha Final Comisión', t.dato)
from tmp001_sep, hlp_TipoDocumento t

end try
begin catch
    select concat('error:', error_message())
end catch
end
go

exec dbo.usp_busqueda_prog_ord_extra




select*from mastertable('dbo.prog_extraord')

return
select*from dbo.menu
select*from dbo.menuTransportes

select*from dbo.prog_extraord
select*from dbo.prog_ruta
select*from dbo.prog_eo_grifo where Id_ProgRuta = 33 and activo = 1

select*from mastertable('dbo.prog_extraord')
select*from mastertable('dbo.prog_ruta')
select*from mastertable('dbo.prog_eo_grifo')
