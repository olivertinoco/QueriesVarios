-- SELECT C.placa_interna,
--        CASE
--            WHEN EXISTS (
--                SELECT 1
--                FROM ASIGNAR_VEHICULO_UNIDAD U
--                WHERE U.placa_interna = C.placa_interna
--            ) THEN 'EXISTE EN UNIDAD'
--            ELSE 'NO EXISTE EN UNIDAD'
--        END AS Estado
-- FROM ASIGNAR_VEHICULO_COMANDO C;



select *from ASIGNAR_VEHICULO_COMANDO t where t.id_vehiculo = 357220
select*from ASIGNAR_VEHICULO_UNIDAD t where t.id_vehiculo = 357220
-- where t.id_vehiculo = tt.id_vehiculo and t.id_vehiculo = 357220
