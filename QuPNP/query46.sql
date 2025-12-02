if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_prog_tarjeta_multiflota_carga_masivo','p'))
drop procedure dbo.usp_prog_tarjeta_multiflota_carga_masivo
go
create procedure dbo.usp_prog_tarjeta_multiflota_carga_masivo
@data varchar(max)
as
begin
begin try
set nocount on
set language english
set tran isolation level read uncommitted
begin tran
select top 0
cast(null as int) id_vehiculo,
cast(null as varchar(100)) error,
cast(null as varchar(10)) collate database_default Placa_Interna,
cast(null as varchar(10)) collate database_default Placa_Rodaje,
cast(null as varchar(30)) collate database_default Nro_Tarjeta into #tmp001_param
select top 0
cast(null as varchar(6)) collate database_default accion,
cast(null as int) id_vehiculo into #tmp001_valores

select @data = dato from dbo.udf_splice(@data, default, default)
insert into #tmp001_param(Placa_Interna, Placa_Rodaje, Nro_Tarjeta) exec(@data)

update p set p.id_vehiculo = t.id_vehiculo from #tmp001_param p
outer apply(select*from dbo.vehiculo t where t.Placa_Interna = p.Placa_Interna)t

update p set p.id_vehiculo = null, p.error = 'TARJETA EXISTENTE Y ACTIVO, NO SE REGISTRO'
from #tmp001_param p, dbo.PROG_TARJETA_MULTIFLOTA t
where rtrim(p.Nro_Tarjeta) = rtrim(t.Nro_Tarjeta) and t.activo = 1

update p set p.error = 'PLACA INTERNA NO EXISTE EN LOS REPOSITORIOS PNP'
from #tmp001_param p where p.Id_Vehiculo is null and p.error is null

;with PROG_TARJ as(
    select top 1 with ties *
    from dbo.PROG_TARJETA_MULTIFLOTA
    order by row_number()over(partition by Id_Vehiculo order by Id_Multiflota desc)
)
merge into PROG_TARJ t
using (select*from #tmp001_param where not Id_Vehiculo is null)s
on(t.Id_Vehiculo = s.Id_Vehiculo)
when matched then update set
t.Fec_cancelacion = case when nullif(t.Fec_cancelacion, cast('' as date)) is null then getdate() else t.Fec_cancelacion end,
t.activo = 1,
t.usuarioI = 'MASIVO',
t.FechaI = getdate()
when not matched then
insert(Id_Vehiculo, Placa_Interna, Placa_Rodaje, Nro_Tarjeta, Fec_Activacion, activo, usuarioI, fechaI)
values(s.Id_Vehiculo, s.Placa_Interna, s.Placa_Rodaje, s.Nro_Tarjeta, getdate(), 1, 'MASIVO', getdate())
output $action accion, inserted.Id_Vehiculo into #tmp001_valores;

;with tmp001_sep(t,r,i)as(
    select*from(values('|','~','^'))t(sepCampo,sepReg,sepLst)
)
select isnull(stuff((select r, Placa_Interna, t, Placa_Rodaje, t, Nro_Tarjeta, t, error
from #tmp001_param where Id_Vehiculo is null
order by Nro_Tarjeta, Placa_Interna
for xml path, type).value('.','varchar(max)'),1,1,''), 'ok')
from tmp001_sep

commit;
end try
begin catch
    rollback;
    select concat('error:', error_message())
end catch
end
go





declare @data varchar(max) =
'ND-xxxx|SL-3581|D57E5B6F_12E0_4233_95BC_0~ND-2077|PGV-914|A49B5B25_291B_4166_8B74_7~ND-1781|BGG-242|F1672B1C_9C61_477E_8BD1_9~ND-1501|AIL-991|13F1D246_D740_44B9_87A0_7~ND-1721||9006B84F_D86E_41CE_A1DC_4~IH-5466|ND-5466|FEED9B37_7F95_4870_93B9_0~SE-2369|RIJ-544|799AC307_6F89_43F5_9761_D~SD-1255|KQ-5160|BB65C266_EB64_4A53_B0EC_F~SE-2436|RGI-756|822B2DE0_341D_49F9_85EB_2~GC-2623|RIJ-968|1B87C768_A01C_4979_9C10_E~GC-2624|RIJ-969|B992EEE2_C136_4B19_9CDB_8~NS-1575|AGS-352|1A6612FA_742D_4088_92A2_B~NS-1089||C0FA0BE0_5C0E_4890_820F_4~NS-1433|AGS-349|781C931C_9E1F_49F5_9E03_A~NS-1856|AGS-351|4A0F97BC_AAAD_4EC6_A3DF_0~NZ-1022|BIW-368|206F11F1_D113_4A8B_B498_7~NZ-1952|EO-9896|202E52C3_0FC9_4C4A_A292_D~NC-1216|EO-4124|A9F37E12_B1BC_4ECA_948E_D~NC-1967|KQ-4886|F60F6C32_3676_4FBF_B13E_0~NC-1027|AQ-8987|7518FDBE_6253_42F0_AEB3_0~NC-1625|KO-3167|8F669B48_1751_4580_BDBE_6~NI-1774|JI-9202|E87C0720_28D6_4AA7_B0AA_F~NI-1325|JQ-2656|A76031F7_8E6B_4535_A07A_1~NI-5023||46DA1231_775D_4400_907F_9~NP-2517|RIT-881|35A5B8CF_1D46_4ABF_AA29_9~NP-2887|RIZ-998|F66CC565_02A1_49CF_9CB0_1~AA-1682||87D50E7E_10C1_4640_B2E2_2~AA-1713|RL-0946|EAC85576_0609_4AED_AA23_C~ZL-1020|EPA-589|27211AFC_F494_4782_94E1_A~CT-1336|KI-5479|B6B5DC2D_957E_47C3_ACDC_2~CS-5016|MCH-705|6ED4D061_DC0A_4C5A_93CB_D~DH-2151|PGF-122|3E24B769_7E8E_499F_9175_3~SIE-738|SIE-738|769852CB_6C98_460B_BA87_9~DH-2534|C.R.HI|7E8124F2_9617_42A3_AB83_B~DH-2214|HIDE-833|72717749_7CD2_43AD_B3FB_0~FU-2510|OO-2797|AC751BA8_C956_475C_AC97_6~IO-5364|II-5364|fdsfsdfdsf~II-5455|IO-5455|B25FA5D0_BCA2_4FF9_B1F6_E~KA-2389|RGK-426|BA354339_F85E_4391_B0B4_1~KT-3049|FKT-3736|DB81394A_5EBB_41E8_B6B9_5~KM-3603||96C1E75C_AB60_41C2_94AB_C~RM-3431|HA-3431|D90514FA_5C71_4175_AADC_5~KM-2422||77682546_804D_457B_898C_4~KM-3711|HM-3711|70B6BD74_30FC_463D_B0F5_8~KM-2227|HG-2227|016DFB7C_CCC0_4187_8115_8~KM-3221|HA-3221|4E3C875F_F974_4BB5_8405_2~PM-3772||0B1735E2_DFD8_4EE9_BDBF_C~PU-1599||51446F5A_AB6A_49EB_B172_2~KM-2393|HE-2393|EB1DF233_5848_400A_8BEF_8~KM-2236|HA-2236|3FAFBC53_30C3_4384_8BA1_2~KM-3068|HA-3068|1C14D10F_9356_4374_94DF_4~KM-3512|HA-3512|4B55CE27_D62B_44B7_A825_9~KM-3661|HA-3661|6864CD5B_488E_4C91_8413_B~JM-3716|HA-3716|14C8DBBE_69A3_4245_A435_3~IM-2215||A15328B4_0E9D_46D4_9356_C~PM-2335|HA-2335|292F8CEE_A1A8_472B_9266_0~RM-2441|HA-2441|dasdasdsa~PM-2415|HA-2415|288FF839_1969_4BC4_B243_0~PM-2431||001BF133_B163_46F7_A279_C~PM-2433||CBDF7AE0_A8E2_47B5_8551_3~HM-2350|HA-2350|B1D89450_ECEB_41A2_9F80_9~JM-2959|HA-2959|063CC0A5_2347_435A_8B3E_8~JM-5733|HA-5733|B7C925DD_DAAF_43F8_88E7_3~xx-5744|HA-5744|961CA053_3C96_4D7A_BEE7_C~PL-10543|HA-5832|E564928E_8AB5_4AD4_8A60_4~LM-5935|HA-5935|38AC935E_1C96_40BB_BFE0_9~HM-5782|HA-5782|fsfsdfsdfdf~HM-5829|HA-5829|A9354A22_53FC_44AA_88C4_C~NM-5571|HA-5571|6B08DB4C_CAE1_41DE_A065_3~HM-5019|HA-5019|16911549_DC0B_4E41_B327_C~HM-5848|HA-5848|8214EDAD_39A8_406B_AE4F_1~CY-9878|JQ-9878|A3CDE2E4_4CA2_4566_B9C5_F~CY-2431|SO-8438|86DC263F_E32B_4744_AACA_5~CY-2393|OG-2393|6202EB80_8B68_4469_AC18_2~CY-5743|MX-0163|4FBBDAB0_7FD5_485F_9C6A_6~CY-5867|MY-14797|1BAB2CBF_D922_4F6F_A8C5_F~KM-3728|HI-3728|D476BF21_B7E0_44B8_A46D_4~KM-5614|HI-5314|11790370_5AEA_4FB7_AA29_3~KM-3160|HA-3160|A0B294C2_F1B1_4A1B_9B1C_7~CM-5744|MX-01245|01C40019_9862_4CA3_8075_6~CM-2687|TI-5199|C3C33983_C515_4013_BFE2_2~KM-3144|HG-3144|1FF19454_BED1_41A4_A76B_F~NM-2683|HG-2683|1DCDE850_E03B_4C72_8B67_8~KM-1605|KU-1605|FE48BA83_22A8_4755_AD60_7~PM-10760|CR-10760|01580FA2_2FA8_44C6_83BE_2~KM-2459|HA-2459|4DA6B01D_7B66_4DF7_930F_B~IH-2060|OO-4634|4A1CE8E3_71F2_498E_987C_8~CMD-1111|OO-5133|1BAB2CBF_D922_4F6F_A8C5_F~IH-2182|RM-6348|66F8E339_1DC4_44FA_8B85_D~BL-2146|BC-2146|4D6B4091_4B40_48DA_AF78_C~TM-2426|TA-2426|4E2E25FB_0B64_487A_857E_4~TM-2310|PGY-887|55A44014_01C9_4F66_99C5_7~TM-2686|PGY-889|1F67D843_CEE1_4A67_A31B_C~MP-5458|MG-10599|625FF771_480B_47B5_B68C_A~MP-5464|MG-10600|9208312E_3849_4B33_8E6C_F~MP-5465|MG-10087|1A1996E7_28F3_40FA_8AC7_8~MP-5467|MG-10602|944FFB78_C6F4_44F3_A0F8_E~MV-5418|MG-14355|E1B11E45_E113_4965_8ADD_A~MV-5425|MG-14356|9AB7AEF0_9A6A_4FCE_B5D7_D~MV-5988|MG-14308|AC885B87_10B8_42AC_8FD4_5'


-- exec dbo.usp_prog_tarjeta_multiflota_carga_masivo @data

-- truncate table dbo.PROG_TARJETA_MULTIFLOTA
-- set identity_insert dbo.PROG_TARJETA_MULTIFLOTA on
-- insert into dbo.PROG_TARJETA_MULTIFLOTA(Id_Multiflota, Id_Vehiculo, Placa_Interna, Placa_Rodaje, Nro_Tarjeta, Fec_Activacion, Fec_cancelacion, Activo, Estado, UsuarioI, FechaI)
-- select* from dbo.PROG_TARJETA_MULTIFLOTA_PRUEBA
-- set identity_insert dbo.PROG_TARJETA_MULTIFLOTA off


return
select t.*
from dbo.PROG_TARJETA_MULTIFLOTA t
-- where Placa_Interna = 'CMD-2020'
order by Id_Multiflota desc, Id_Vehiculo
