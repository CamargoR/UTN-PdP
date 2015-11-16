type Material = (String, Int) --(nombre del material, valor)
type Edificio = (String, [Material]) --(nombre del edificio, materiales)
type Aldea = (Int, [Material], [Edificio]) --(poblacion, materiales disponibles, edificios)


aldea1 = (50,[("Acero",15),("Piedra",5)],[("Barracas",[("Acero",20)])])
--1.
---a.
esDeCalidad (_,valor) = valor > 20
---b.
disponibles::String -> Aldea -> Int
disponibles material (_, materiales,_) = length (filter ((==material).fst) materiales)
--c.
valorTotal unaAldea = valorTotalMateriales unaAldea + valorTotalMaterialesEdificiosDeAldea unaAldea

valorTotalMateriales (_,m,_) = (sum.map snd) m
valorTotalMaterialesEdificiosDeAldea (_,_,edificios) = (