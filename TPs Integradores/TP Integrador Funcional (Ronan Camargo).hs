data Gimnasta = CGimnasta String Float Float Float deriving(Show)  

pancho = CGimnasta "Francisco" 40.0 120.0 1.0
andres = CGimnasta "Andy" 22.0 80.0 6.0

nombre (CGimnasta suNombre _ _ _) = suNombre
edad (CGimnasta _ suEdad _ _) = suEdad
peso (CGimnasta _ _ suPeso _) = suPeso
tonificacion (CGimnasta _ _ _ suTonificacion) = suTonificacion

relax minutos gimnasta = gimnasta

--1.
saludable::Gimnasta -> Bool
saludable (CGimnasta _ _ peso tonificacion) = (not.esObeso) peso && tonificacion > 5
esObeso peso
	|peso > 100 = True
	|otherwise = False
	
--2.

quemarCalorias::Gimnasta -> Float -> Gimnasta
quemarCalorias (CGimnasta nombre edad peso tonificacion) calorias
	|esObeso peso = (CGimnasta nombre edad (calcularNuevoPeso peso (calorias/150)) tonificacion)
	|(not.esObeso) peso && edad > 30 && calorias > 200 = (CGimnasta nombre edad (peso - 1) tonificacion)
	|otherwise = (CGimnasta nombre edad (calcularNuevoPeso peso (calorias / (peso * edad))) tonificacion)
	
calcularNuevoPeso::(Num a) => a -> a -> a
calcularNuevoPeso kilos kilosBajados = kilos - kilosBajados

--3.
calcularCaloriasQuemadasEnEjercicio factor = (*factor)
nuevaTonificacion (CGimnasta nombre edad peso tonificacion) tonifica = (CGimnasta nombre edad peso (tonifica+tonificacion))
velocidadPromedio minutos = ((+6).(/10)) minutos


caminataEnCinta minutos gimnasta = quemarCalorias gimnasta (5*minutos)
caminataEnCinta' minutos gimnasta = quemarCalorias gimnasta (calcularCaloriasQuemadasEnEjercicio minutos 5)

entrenamientoEnCinta minutos gimnasta = (quemarCalorias gimnasta . calcularCaloriasQuemadasEnEjercicio minutos .velocidadPromedio) minutos

pesas kilosALevantar minutos gimnasta
	|(>10) minutos = nuevaTonificacion gimnasta (kilosALevantar/10)
	|otherwise = gimnasta

colina inclinacion minutos gimnasta = (quemarCalorias gimnasta . calcularCaloriasQuemadasEnEjercicio minutos. (*2) ) inclinacion

montania inclinacion minutos gimnasta = (flip nuevaTonificacion 1 .colina (inclinacion+3) (minutos/2) . colina inclinacion (minutos/2)) gimnasta

--4.
type Ejercicio = Float -> Gimnasta -> Gimnasta
data Rutina = CRutina String Float [Ejercicio]

rutinaEjemplo = CRutina "Todos los ejercicios" 180.0 [caminataEnCinta, entrenamientoEnCinta, pesas 50, colina 5, montania 5] 

nombreRutina (CRutina nombre _ _) = nombre
duracionTotal (CRutina _ duracion _) = duracion
listaDeEjercicios (CRutina _ _ ejercicios) = ejercicios
---a.
rutinaCompletaDeEjercicios gimnasta (CRutina _ duracion ejercicios) = hacerEjercicios ejercicios ((duracion/) (fromIntegral(length ejercicios))) gimnasta

hacerEjercicios [] minutos gimnasta = gimnasta
hacerEjercicios (ejercicio:ejercicios) minutos gimnasta  = (hacerEjercicios ejercicios minutos . ejercicio minutos) gimnasta


rutinaCompletaConFold gimnasta (CRutina _ duracion ejercicios) = foldl (\gimnasta ejercicio -> ejercicio ((duracion/) (fromIntegral(length ejercicios))) gimnasta) gimnasta ejercicios
---b.
resumenDeRutina rutina gimnasta = hacerResumen (rutinaCompletaDeEjercicios gimnasta rutina) gimnasta (nombreRutina rutina)
hacerResumen (CGimnasta _ _ pesoNuevo tonificacionNueva) (CGimnasta _ _ peso tonificacion) nombreDeRutina = (nombreDeRutina, peso - pesoNuevo, tonificacionNueva - tonificacion)

--5.
listaDeRutinas =[CRutina "Todos los ejercicios" 180.0 [caminataEnCinta, entrenamientoEnCinta, pesas 50, colina 5, montania 5],
				CRutina "rutina1" 300 [caminataEnCinta, pesas 100, colina 10, montania 15],
				CRutina "rutina2" 20 [caminataEnCinta,pesas 12],
				CRutina "rutina3" 800 [caminataEnCinta,entrenamientoEnCinta,caminataEnCinta,colina 5, montania 10,pesas 100,caminataEnCinta]
				]

gimnastaSaludableLuegoDeRutina gimnasta = (saludable.rutinaCompletaDeEjercicios gimnasta)
---a.			
rutinasSaludables gimnasta rutinas = (map nombreRutina. filter (gimnastaSaludableLuegoDeRutina gimnasta)) rutinas
---b.
comprensionRutinasSaludables gimnasta rutinas = [nombreRutina x | x <- rutinas, gimnastaSaludableLuegoDeRutina gimnasta x]


