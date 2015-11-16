data Vigilante = CVigilante (String, [String], Int) deriving(Show,Eq)
data Agente= CAgente (String,String) deriving(Show)

algunosVigilantes = [CVigilante("Buho Nocturno", ["Lucha", "Inteligencia", "Fuerza"], 1939),  
					CVigilante("Rorschach", ["Perseverancia", "Deduccion", "Sigilo"], 1964),  
					CVigilante("Espectro de Seda", ["Lucha", "Sigilo", "Fuerza"], 1962),  
					CVigilante("Ozimandias", ["Inteligencia", "Mas Inteligencia Aun"], 1968), 
					CVigilante("Buho Nocturno", ["Lucha", "Ingenierismo"], 1963),  
					CVigilante("Espectro de Seda", ["Lucha", "Sigilo"], 1940) ]
--CVigilante ("El Comediante", ["Fuerza"], 1942),  
nombreVigilante (CVigilante (nombre,_,_)) = nombre
habilidades (CVigilante (_,habilidades,_)) = habilidades
aparicion (CVigilante (_,_,aparicion)) = aparicion

agentesDelGobierno = [CAgente("Jack Bauer","24"),
					CAgente("El Comediante","Watchmen"),
					CAgente("Dr. Manhattan", "Watchmen"),
					CAgente("Liam Neeson","Taken")]

nombreAgente (CAgente (nombre,_)) = nombre
serieAgente (CAgente (_,serie)) = serie

----Eventos
--a.
destruccionDeNiuShork vigilantes = (seRetira "Dr. Manhattan" .seRetira "Rorschach") vigilantes
--, seRetira nombreAgente "Dr. Manhattan" agentes)

--b.
seRetira nombre personajes = [x | x <- personajes, nombreVigilante x /= nombre]
seRetira' f nombre personajes = filter (((/=)nombre).f) personajes

--c.
guerraDeVietnam vigilantes = ((map nuevaHabilidad).esVigilanteYAgenteDelGobierno vigilantes)
-- guerraDeVietnam' (v:vs)
	-- |esVigilanteYAgenteDelGobierno v = nuevaHabilidad v:guerraDeVietnam' vs
	-- |otherwise = guerraDeVietnam' vs


esVigilanteYAgenteDelGobierno vigilantes agentes = filter (hayAlMenosUnVigilante agentes.nombreVigilante) vigilantes
hayAlMenosUnVigilante agentes vigilante = any (==vigilante) (map nombreAgente agentes)

nuevaHabilidad (CVigilante (nombre, habilidades, aparicion))= CVigilante (nombre,habilidades++["Cinismo"],aparicion)

--d.
accidenteDeLaboratorio anio vigilantes = vigilantes ++ [CVigilante ("Dr. Manhattan", ["Manipulacion de la materia a nivel atomico"], anio)]

--e.
actaDeKleene [] = []
actaDeKleene (v:vs) 
	|any (==nombreVigilante v) (map nombreVigilante vs) = actaDeKleene vs
	|otherwise = v:actaDeKleene vs
	
actaDeKleene' [] = []
actaDeKleene' (v:vs) 
	|null(filter (((==) (nombreVigilante v)). nombreVigilante) vs)  = v:actaDeKleene vs
	|otherwise = actaDeKleene vs
--(any (>aparicion v).

--vigilanteMasJoven v vis = (maximoSegun aparicion .filter ((==v).nombreVigilante)) vis

asd vigilantes v = aparicion (vigilanteMasJoven v vigilantes)



asdd [] = []
asdd (v:vs)
	|aparicion v == aparicion (vigilanteMasJoven (nombreVigilante v) vs) = (v:asdd vs)
	|otherwise = asdd vs
	
--asd (v:vs) = map ((mayorSegun aparicion (aparicion v)).aparicion) ((filter (((==) (nombreVigilante v)). nombreVigilante)vs))

actaDeKleene2 [] = []
actaDeKleene2 (v:vs)
	|(nombreVigilante (vigilanteMasJoven (nombreVigilante v) vs) == nombreVigilante v) && (aparicion v == aparicion (vigilanteMasJoven (nombreVigilante v) vs)) = v:actaDeKleene2 vs
	|otherwise = actaDeKleene2 vs

rmDup [] = []
rmDup (x:xs) = x : rmDup (filter (\y -> not(nombreVigilante x == nombreVigilante y)) xs)

maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b
	|f a >= f b = a
	|otherwise = b
	
	
-----------------1.
historia vigilantes agentes = (destruccionDeNiuShork.seRetira "El Comediante".(flip guerraDeVietnam agentes).accidenteDeLaboratorio 1959) vigilantes