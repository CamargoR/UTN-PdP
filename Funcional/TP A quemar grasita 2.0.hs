data Gimnasta = CGimnasta String Float Float Float deriving(Show)

nombre (CGimnasta nombre _ _ _ ) = nombre
edad (CGimnasta  _ edad _ _ ) = edad
peso (CGimnasta _ _ peso _ ) = peso
tonificacion (CGimnasta _ _ _ tonificacion) = tonificacion


pancho = CGimnasta "Francisco" 40.0 120.0 1.0
andres = CGimnasta "Andy" 22.0 80.0 6.0

--1)

saludable gimnasta = (not.esObeso) gimnasta && ((>5).tonificacion) gimnasta
esObeso gimnasta = ((>100).peso) gimnasta

--2) 

quemarCalorias gimnasta caloriasQuemadas
	|esObeso gimnasta = bajarPeso gimnasta ((/150) caloriasQuemadas)
	|(not.esObeso) gimnasta && ((>30).(edad)) gimnasta && (>200) caloriasQuemadas = bajarPeso gimnasta 1
	|otherwise = bajarPeso gimnasta ( ((caloriasQuemadas/).((edad gimnasta)*)) (peso gimnasta) )

bajarPeso (CGimnasta nom eda pes ton) caloriasQuemadas = (CGimnasta nom eda ((pes-) caloriasQuemadas) ton)

--3)

caminataEnCinta tiempo gimnasta = quemarCalorias gimnasta ((5*) tiempo)

entrenamientoEnCinta tiempo gimnasta = quemarCalorias gimnasta ( ((tiempo*).(/2).(12+).(/5)) tiempo )

pesas kilos tiempo gimnasta
	|tiempo > 10 = tonificar gimnasta ((/10) kilos)
	|otherwise = gimnasta

tonificar (CGimnasta nom eda pes ton) tonificacionAumentada = (CGimnasta nom eda pes ((tonificacionAumentada+) ton))

colina inclinacion tiempo gimnasta =  quemarCalorias gimnasta ( ((2*).(inclinacion*)) tiempo )

montania inclinacion tiempo gimnasta = tonificar (quemarCalorias gimnasta (calculoMontaña inclinacion tiempo)) 1

calculoMontaña inclinacion tiempo = (+) ( ((2*).(inclinacion*)) ((/2) tiempo) ) ( ((2*).(((3+) inclinacion)*)) ((/2) tiempo) )

--4)
--	A
data Rutina = CRutina String Float [(String, Float)] deriving(Show)

nombreRutina (CRutina nombreRutina _ _ ) = nombreRutina
listaEjercicios (CRutina _ _ listaEjercicios) = listaEjercicios
duracion (CRutina _ duracion _) = duracion 

duracionEjercicio (CRutina _ duracion lista) = (duracion) / fromIntegral (length lista)

rutinaCompleta = CRutina "rutina completa" 100 [("caminataEnCinta",0),("entrenamientoEnCinta",0), ("pesas", 50), ("colina",5), ("montania",5)]
simple = CRutina "rutina completa" 500 [("caminataEnCinta",0),("entrenamientoEnCinta",0)]


hacerRutina rutina gimnasta = calculoRutina (listaEjercicios rutina) gimnasta (duracionEjercicio rutina)

calculoRutina [] gimnasta tiempo = gimnasta
calculoRutina (x:xs) gimnasta tiempo
	|fst x == "caminataEnCinta" = calculoRutina xs ( caminataEnCinta tiempo gimnasta ) tiempo
	|fst x == "entrenamientoEnCinta" = calculoRutina xs ( entrenamientoEnCinta tiempo gimnasta ) tiempo
	|fst x == "pesas" = calculoRutina xs ( pesas (snd x) tiempo gimnasta ) tiempo
	|fst x == "colina" = calculoRutina xs ( colina (snd x) tiempo gimnasta ) tiempo
	|fst x == "montania" = calculoRutina xs ( montania (snd x) tiempo gimnasta ) tiempo
	
--FALTA EL FOLD
--hacerRutinaFold rutina gimnasta = foldl (calculoRutinaFold) gimnasta rutina

--calculoRutinaFold 

--	B

resumenRutina rutina gimnasta = calculoResumen (nombreRutina rutina) (hacerRutina rutina gimnasta) gimnasta

calculoResumen nombre gimnastaEntrenado gimnasta = (nombre, ((peso gimnasta) - (peso gimnastaEntrenado) ), ( (tonificacion gimnastaEntrenado)-(tonificacion gimnasta) ) )

-- 5)

resumenSaludable gimnasta rutina = map nombreRutina (filter ( saludable.(flip (hacerRutina) gimnasta) ) rutina)

--FALTA EL DE LISTAS POR COMPRENSION 

--resumenSaludable' gimnasta rutina = [ x | x <- rutina , x <- (hacerRutina x gimnasta), x <- (saludable x)]

--resumenSaludable' gimnasta rutina =  map nombreRutina [x | x <- rutina, (saludable.(hacerRutina x gimnasta))]





