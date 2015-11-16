--Valor absoluto
absoluto numero
	|numero >= 0 = numero
	|numero < 0 = numeroOpuesto numero

numeroOpuesto numero = (*)(-1) numero



--Probabilidad de aprobar paradigmas
probabilidad::(Num a) => [Char] -> a
probabilidad "vago" = 10
probabilidad "inteligente" = 60
probabilidad "estudioso" = 100
probabilidad _ = 50



--Minimo
minimo::(Ord a) => a -> a -> a
minimo numero otroNumero
	|numero < otroNumero = numero
	|numero >= otroNumero =  otroNumero
	


--Cantidad de dias del año
cantidadDias::(Integral a, Num b) => a -> b
cantidadDias unAnio
	|bisiestidad unAnio == True = 366
	|otherwise = 355

bisiestidad::Integral a => a->Bool
bisiestidad unAnio
	|esDivisible unAnio 400 || (esDivisible unAnio 4 && not(esDivisible unAnio 100)) = True
	|otherwise = False

esDivisible::Integral a => a -> a -> Bool
esDivisible unNumero otroNumero
	|mod unNumero otroNumero == 0 = True
	|otherwise = False
	
	
	
--Pinos
pesoPino::(Num a, Ord a) => a -> a
pesoPino altura
	|altura <= 300 = 3*altura
	|otherwise = 2*altura

pesoUtil::(Num a, Ord a) => a -> Bool
pesoUtil peso
	|intervaloDe 400 1000 peso == True = True
	|otherwise = False
	
intervaloDe::(Num a, Ord a) => a -> a -> a -> Bool	
intervaloDe inferior superior elemento
	|elemento >= inferior && elemento <= superior = True
	|otherwise = False

sirvePino::(Num a, Ord a) => a -> Bool
sirvePino altura
	|(pesoUtil.pesoPino) altura == True = True
	|otherwise = False
	
prioridadPino::(Num a, Ord a) => a -> [Char]
prioridadPino altura
	|altura == 200 = "Alta"
	|altura <= 300 && pesoPino altura > 800 = "Media"
	|sirvePino altura == True = "Baja"
	|otherwise = "Obsoleto"
	

	
--Foringa
anioIngreso "george" = 2013 
anioIngreso "sexy99" = 2013 
anioIngreso "boca_cabj" = 2011 
anioIngreso "jroman" = 2010

antiguedad::(Num a) => [Char] -> a
antiguedad usuario = 2014 - anioIngreso usuario

puntosBase::[Char] -> Int
puntosBase usuario = length(usuario) * antiguedad usuario

nivel::[Char] -> [Char]
nivel usuario
	|antiguedad usuario < 1 = "Newbie"
	|puntosBase usuario < 50 = "Intermedio"
	|otherwise = "Avanzado"

puedeOtorgar::[Char] -> Int -> Bool
puedeOtorgar usuario puntos
	|usuario /= "admin" && puntos <= (puntosBase usuario) = True
	|otherwise = False
	
	
	
--Felices Pascuas

nombre (nom, _) = nom
huevos (_, hvs) = hvs

ingredientes(_, ing) = ing
peso (p , _) = p


data Pascuas = CPascuas [(String, [(Integer, [String])])]deriving(Show)
--(nombre,[(peso,[ingredientes])])

listaPascua = [ ("Gaston", [ (200, ["chocolate blanco", "nutella", "cereal", "chocolate amargo", "almendras"]), (100, ["chocolate amargo", "m&ms"]) ] ), ("Veronica", [ (200, ["chocolate blanco", "nutella", "almendras"]), (100, ["chocolate amargo", "m&ms"]), (150, ["chocolate", "almendras"]), (100, ["chocolate amargo", "m&ms"]) ] ), ("Nacho", [ (200, ["chocolate blanco", "nutella", "almendras"]), (100, ["chocolate amargo", "m&ms", "almendras", "dulce de leche", "moritas"]), (150, ["chocolate", "almendras"]), (100, ["chocolate amargo", "m&ms"]), (200, ["chocolate", "nutella"])] ), ("Lucas", [ (200, ["chocolate blanco", "nutella", "almendras"]), (100, ["chocolate amargo", "m&ms"]), (150, ["chocolate", "almendras", "m&ms", "chocolate blanco", "moritas"]), (150, ["chocolate blanco", "dulce de leche"])]) ]

--huevosComidos pascuas = map (length.snd)
longitud lista = length lista
se lista = (filter (mayora3).map (snd)) lista

mayora3 lista = longitud lista > 3

asd [] = []
asd (x:xs)
	|length(huevos x) > 3 = (nombre x:asd xs)
	|otherwise = asd xs