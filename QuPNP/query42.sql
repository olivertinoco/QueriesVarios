;with hlp001_marcaModelo as(
    select t.Id_Vehiculo, tt.DescripcionL marca, tm.DescripcionL modelo
    from dbo.vehiculo t
    outer apply(select*from dbo.tipo_marca tt where tt.Id_TipoMarca = t.Id_TipoMarca) tt
    outer apply(select*from dbo.tipo_modelo tm where tm.Id_TipoModelo = t.Id_TipoModelo) tm
)
select tt.*from prog_extraord t, hlp001_marcaModelo tt
where t.Id_Vehiculo = tt.Id_Vehiculo and t.Id_ProgExtraOrd = 3
