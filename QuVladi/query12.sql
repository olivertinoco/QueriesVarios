-- if exists(select 1 from sys.objects where object_id=object_id('dbo.udf_corrEpp', 'if'))
-- drop function dbo.udf_corrEpp
-- go
-- create function dbo.udf_corrEpp(
-- @item int
-- )returns table as return(
-- select datediff_big(millisecond,'19700101',dateadd(hour,(-5),getutcdate())) + @item [22_22]
-- )
-- go


-- insert dev.A00_Usuarios(USER_Usuario)values('40545510')




-- select *
-- from(select top 10 row_number()over(order by(select 1)) item 
-- from sys.fn_helpcollations())t cross apply dbo.udf_corrEpp(item)

-- update t set PosEPP_Sec = '' from dbo.prueba99 t


-- insert into dev.RH10_PosEPPs(Pos_Id, PosEPP_Sec, EPP_Id, PosEPP_Talla)

-- select *, isnull(nullif(PosEPP_Sec, 0), tt.[22_22]) PosEPP_Sec
-- from(select row_number()over(order by (select 1)) [11_11], 
-- Pos_Id, PosEPP_Sec, EPP_Id, PosEPP_Talla
-- from dbo.prueba99)t cross apply dbo.udf_corrEpp([11_11])tt




-- select Pos_Id, PosEPP_Sec, EPP_Id, PosEPP_Talla -- into dbo.prueba99
-- from dev.RH10_PosEPPs where Pos_Id = 52



-- delete dev.RH10_PosEPPs where Pos_Id = 52

-- select*from sys.schemas
--  (datediff_big(millisecond,'19700101',dateadd(hour,(-5),getutcdate())))

-- -- NOTA: DDL - RH10_Postulantes
-- -- ============================
-- alter table dev.RH10_Postulantes 
-- add constraint pk_dev_RH10_Postulantes primary key (Pos_Id);

-- -- NOTA: DDL - RH10_PosDirecciones
-- -- ============================
-- alter table dev.RH10_PosDirecciones
-- add constraint pk_dev_RH10_PosDirecciones primary key (Pos_Id, Dir_Sec);

-- alter table dev.RH10_PosDirecciones
-- add constraint def_dev_RH10_PosDirecciones default ((datediff_big(millisecond,'19700101',dateadd(hour,(-5),getutcdate()))))
-- for Dir_Sec;

-- -- NOTA: DDL - RH10_PosEPPs
-- -- ============================
-- alter table dev.RH10_PosEPPs
-- add constraint pk_dev_RH10_PosEPPs primary key (Pos_Id, PosEPP_Sec);

-- alter table dev.RH10_PosEPPs
-- add constraint def_dev_RH10_PosEPPs default ((datediff_big(millisecond,'19700101',dateadd(hour,(-5),getutcdate()))))
-- for PosEPP_Sec;

-- -- NOTA: DDL - A00_Usuarios
-- -- ============================
-- alter table dev.A00_Usuarios 
-- add constraint pk_dev_A00_Usuarios primary key (User_Id);

-- alter table dev.A00_Usuarios
-- add constraint def_dev_A00_Usuarios default (dbo.udf_dev_pkusuario())
-- for User_Id;
set rowcount 20

select*from dbo.A00_Usuarios where USER_Usuario ='varrieta'
select*from dev.A00_Usuarios where USER_Usuario ='varrieta'






-- set identity_insert dev.RH10_Postulantes on
-- disable trigger tr_Dev_Usuarios_GeneraClave on dev.A00_Usuarios;

-- insert into dev.RH10_Postulantes 
-- (Pos_Id,Pos_Codigo,Pos_ApPat,Pos_ApMat,Pos_Nombres,Pos_Sexo,Pos_DocTipoId,Pos_DocNumero,Pos_DocEmision,Pos_DocVencimiento,Pos_Email,Pos_Cel1,Pos_Cel2,EstCiv_Id,GradIns_Id,Pos_NacFecha,Pos_NacPais,Pos_UbigeoId,Pos_Comunidad_Id,Pos_FotoUrl,Pos_VaListaNegra,Pos_NotasListaNegra,Pos_GrupoSanguineo,Pos_Talla,Pues_id,Pos_Notas,Pos_PretencionSalarial,Pos_FechaIngreso,Pos_AFP,Pos_CUSP,Pos_EMER_Nombre,Pos_EMER_Parentesco,Pos_EMER_Numero,Pos_telfMensajeria,Pos_CurriculumUrl,Proy_id,Pos_FirmaUrl,Pos_ExperienciaAnios,Pos_ExperienciaPuesto,PosEst_Proceso,PosEst_Id,Pos_SeCreoUsuario,Pos_EmbarqueId,Pos_Etiqueta,CreaId,CreaFecha,ModiId,ModiFecha)
-- select*from dbo.RH10_Postulantes
-- insert into dev.RH10_PosDirecciones select*from dbo.RH10_PosDirecciones
-- insert into dev.RH10_PosEPPs select*from dbo.RH10_PosEPPs
-- insert into dev.A00_Usuarios select*from dbo.A00_Usuarios

-- enable trigger tr_Dev_Usuarios_GeneraClave on dev.A00_Usuarios;
-- set identity_insert dev.RH10_Postulantes off



-- truncate table dev.RH10_Postulantes
-- truncate table dev.RH10_PosDirecciones
-- truncate table dev.RH10_PosEPPs
-- truncate table dev.A00_Usuarios

-- select*from mastertable('dev.RH10_Postulantes')
-- select*from mastertable('dev.RH10_PosDirecciones')
-- select*from mastertable('dev.RH10_PosEPPs')
-- select*from mastertable('dev.A00_Usuarios')

return

-- select text from sys.syscomments where id=object_id('dbo.udf_dev_pkusuario','fn')


-- select definition from sys.default_constraints 
-- where parent_object_id = object_id('dbo.RH10_PosEPPs', 'U')
-- return

select*from sys.default_constraints;

return
-- CreaId,CreaFecha,ModiId,ModiFecha




-- select definition from sys.default_constraints where parent_object_id = object_id('dev.A00_Usuarios')
-- select text from sys.syscomments where id=object_id('udf_dev_pkusuario')


-- select isnull(max(User_Id), 0) +1 codUsu from dev.A00_Usuarios
-- select*from dev.A00_Usuarios where User_Id = 0


-- select*from sys.triggers where parent_id=object_id('dev.A00_Usuarios')
-- select text from sys.syscomments where id=object_id('dev.tr_Dev_Usuarios_GeneraClave', 'tr')


-- select*into dev.RH10_Postulantes from dbo.RH10_Postulantes
-- select*into dev.RH10_PosDirecciones from dbo.RH10_PosDirecciones
-- select*into dev.RH10_PosEPPs from dbo.RH10_PosEPPs
-- select*into dev.A00_Usuarios from dbo.A00_Usuarios


-- drop table dev.RH10_Postulantes
-- drop table dev.RH10_PosDirecciones
-- drop table dev.RH10_PosEPPs
-- drop table dev.A00_Usuarios


-- select definition from sys.default_constraints 
-- where parent_object_id = object_id('dbo.RH10_PosDirecciones','U')
return





-- select*from dbo.udf_getpk('dbo.RH10_Postulantes')
-- select*from dbo.udf_getpk('dbo.RH10_PosDirecciones')
-- select*from dbo.udf_getpk('dbo.RH10_PosEPPs')
-- select*from dbo.udf_getpk('dbo.A00_Usuarios')

select*from dbo.udf_lisTablas(default) -- cross apply dbo.udf_getpk(tabla)


delete t from dev.A00_Usuarios t where USER_Usuario = '40545510'





-- alter table dbo.RH10_Postulantes add constraint def_001_dbo_RH10_Postulantes
-- default (getdate()) for CreaFecha;
-- alter table dbo.RH10_Postulantes add constraint def_002_dbo_RH10_Postulantes
-- default (getdate()) for ModiFecha;
-- alter table dbo.RH10_Postulantes add constraint def_003_dbo_RH10_Postulantes
-- default (99) for CreaId;
-- alter table dbo.RH10_Postulantes add constraint def_004_dbo_RH10_Postulantes
-- default (99) for ModiId;


-- alter table dbo.RH10_PosDirecciones add constraint def_001_dbo_RH10_PosDirecciones
-- default (getdate()) for CreaFecha;
-- alter table dbo.RH10_PosDirecciones add constraint def_002_dbo_RH10_PosDirecciones
-- default (getdate()) for ModiFecha;
-- alter table dbo.RH10_PosDirecciones add constraint def_003_dbo_RH10_PosDirecciones
-- default (99) for CreaId;
-- alter table dbo.RH10_PosDirecciones add constraint def_004_dbo_RH10_PosDirecciones
-- default (99) for ModiId;


-- alter table dbo.RH10_PosEPPs add constraint def_001_dbo_RH10_PosEPPs
-- default (getdate()) for CreaFecha;
-- alter table dbo.RH10_PosEPPs add constraint def_002_dbo_RH10_PosEPPs
-- default (getdate()) for ModiFecha;
-- alter table dbo.RH10_PosEPPs add constraint def_003_dbo_RH10_PosEPPs
-- default (99) for CreaId;
-- alter table dbo.RH10_PosEPPs add constraint def_004_dbo_RH10_PosEPPs
-- default (99) for ModiId;


-- alter table dbo.A00_Usuarios add constraint def_001_dbo_A00_Usuarios
-- default (getdate()) for CreaFecha;
-- alter table dbo.A00_Usuarios add constraint def_002_dbo_A00_Usuarios
-- default (getdate()) for ModiFecha;
-- alter table dbo.A00_Usuarios add constraint def_003_dbo_A00_Usuarios
-- default (99) for CreaId;
-- alter table dbo.A00_Usuarios add constraint def_004_dbo_A00_Usuarios
-- default (99) for ModiId;
