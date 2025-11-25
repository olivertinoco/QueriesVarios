if exists(select 1 from sys.sysobjects where id=object_id('dbo.udf_duplicado_tarjeta_multiflota','tf'))
drop function dbo.udf_duplicado_tarjeta_multiflota
go
create function dbo.udf_duplicado_tarjeta_multiflota(
    @data varchar(max),
    @Utabla tabla_generico readonly
)returns @salida table(dato int, flag char(1))
as
begin
declare @tot int, @nro_tarjeta varchar(100), @nro_tarjetaActivo varchar(1),
@aux varchar(max) = @data
declare @tmp001_tarjeta3 table(
    valor varchar(100) collate database_default,
    campo varchar(100) collate database_default
)
declare @tmp001_tarjeta2 table(
    item int identity,
    dato varchar(1000) collate database_default
)
declare @tmp001_tarjeta table(
    item int identity,
    dato varchar(1000) collate database_default
)
insert into @tmp001_tarjeta
select value from dbo.udf_split(@aux,'~')
select @aux = dato from @tmp001_tarjeta where item = 2
insert into @tmp001_tarjeta2
select value from dbo.udf_split(@aux, default)
select @tot = scope_identity() / 2

select @nro_tarjeta = t.dato
from(select*from @tmp001_tarjeta2 where item <= @tot order by item offset 0 rows)t,
(select row_number()over(order by item)item2,*from @tmp001_tarjeta2
where item > @tot order by item offset 0 rows)tt,
(select concat(item,'.', column_id) item3 from @Utabla where name = 'Nro_Tarjeta')ttt
where t.item = tt.item2 and tt.dato = ttt.item3

insert into @tmp001_tarjeta3
select t.dato, ttt.name
from(select*from @tmp001_tarjeta2 where item <= @tot order by item offset 0 rows)t,
(select row_number()over(order by item)item2,*from @tmp001_tarjeta2
where item > @tot order by item offset 0 rows)tt,
(select concat(item,'.', column_id) item3, name from @Utabla where name in('Id_Vehiculo','activo'))ttt
where t.item = tt.item2 and tt.dato = ttt.item3

select @nro_tarjetaActivo = null
if exists(select 1 from @tmp001_tarjeta3 where campo = 'activo' and valor = '1')begin
    select @nro_tarjetaActivo = nullif(t.activo,'0')
    from(select row_number()over(partition by t.Id_Vehiculo order by t.id_multiflota desc) item, t.*
    from dbo.PROG_TARJETA_MULTIFLOTA t, @tmp001_tarjeta3 tt
    where tt.campo = 'id_vehiculo' and tt.valor = t.id_vehiculo)t where item = 1
end

if @nro_tarjetaActivo is not null
insert into @salida
select @nro_tarjetaActivo, 'E'
else
insert into @salida
select coalesce((select 1 from dbo.PROG_TARJETA_MULTIFLOTA where Nro_Tarjeta = @nro_tarjeta),0), 'D'

return
end
go



declare @data varchar(max)
='1457~350352|13|C0FA0BE0_5C0E_4890_820F_4|2025-11-19|1|7.2|7.1|7.5|7.7|7.8'

declare @Utabla tabla_generico
insert into @Utabla
exec dbo.usp_listar_tablas 'dbo.PROG_TARJETA_MULTIFLOTA'


select*from dbo.udf_duplicado_tarjeta_multiflota(@data, @Utabla)
