if exists(select 1 from sys.sysobjects where id=object_id('dbo.usp_listaProgramacionVehiculo', 'p'))
drop procedure dbo.usp_listaProgramacionVehiculo
