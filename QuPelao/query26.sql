-- NOTA: BASE DE DATOS DE LA POLICIA
use SIAVEP
go

select*from sys.tables order by 1
-- select*from sys.procedures order by 1

-- select object_name(parent_object_id),name, definition
-- from sys.default_constraints order by 1
--
-- INSERT INTO __EFMigrationsHistory (MigrationId, ProductVersion)
-- VALUES ('20250510174734_InitialIdentity', '6.0.35');

select*from __EFMigrationsHistory
