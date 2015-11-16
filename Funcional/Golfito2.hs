bart = CJugador "Bart" "Homero" (25,60)
todd = CJugador "Todd" "Ned" (15,80)
rafa = CJugador "Rafa" "Gorgory" (10,1)
nombre (CJugador n _ _) = n
padre (CJugador _ p _) = p
habilidad (CJugador _ _ h) = h



data Jugador = CJugador String String (Int, Int) deriving(Show)
data Tiro = CTiro (Int, Int, Int) deriving(Show)
type Obstaculo = (Tiro -> Bool, Tiro -> Tiro)

tirobart = CTiro(2,2,2)

laguna largo = ((\(CTiro(v,_,a))-> v>80 && between 10 50 a),(\(CTiro(v,p,a)) -> (CTiro(v,p,(a `div` largo)))))
tunelConRampita = ((\(CTiro(_,p,a)) -> p>90 && a==0), (\(CTiro(v,_,_)) -> (CTiro(v*2,100,0))) )
hoyo = ((\(CTiro(v,p,a)) -> between 5 20 v && p>95 && a==0), (\(CTiro (_, _, _)) -> (CTiro(0,0,0))))
--between 5 20 v && p>95 && a==0 = (True,(0,0,0))

between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b
	| f a >= f b = a
	| otherwise = b

--asd _ = ((\x -> x+3),(\x -> x+3))

-----------------------------------------------------------



fuerza (CJugador _ _ (f,_)) = f
precision (CJugador _ _ (_,p)) = p
doble numero = (*2) numero
mitad numero = div numero 2


putter jugador = CTiro (10,(doble.precision) jugador,0)
madera jugador = CTiro (100,(mitad.precision) jugador,5)
hierros jugador = map (hierro jugador) [1..10]

hierro jugador numeroDePalo = CTiro (velocidadHierro numeroDePalo jugador, precisionHierro numeroDePalo jugador, alturaHierro numeroDePalo)

velocidadHierro numeroDePalo jugador = ((*numeroDePalo).fuerza) jugador
precisionHierro numeroDePalo jugador = ((flip div numeroDePalo).precision) jugador
alturaHierro numeroDePalo = (numeroDePalo*) numeroDePalo



listaPalos = (putter:madera:map (flip hierro) [1..10])

listaDeTiros jugador [] = []
listaDeTiros jugador (x:xs) = (x jugador: listaDeTiros jugador xs)

listaFuncionesDeTiros jugador [] = []
listaFuncionesDeTiros jugador (x:xs) = (x: listaFuncionesDeTiros jugador xs)

--2.
---a.
golpe jugador tipoPalo = tipoPalo jugador

--b.
puedeSuperar obstaculo tiro = (fst obstaculo) tiro
efectoAplicadoAUnTiro obstaculo tiro = (snd obstaculo) tiro

--c.
--palosUtiles jugador obstaculo = filter ((puedeSuperar obstaculo).(golpe jugador)) (listaFuncionesDeTiros jugador listaPalos)
palosUtiles jugador obstaculo = filter (unGolpePuedeSuperarUnObstaculo obstaculo jugador) listaPalos
--(listaFuncionesDeTiros jugador listaPalos)

unGolpePuedeSuperarUnObstaculo obstaculo jugador = (puedeSuperar obstaculo).(golpe jugador)

--d.
-- nombresDeLosQuePuedenSuperarTodos [] _ = []
-- nombresDeLosQuePuedenSuperarTodos _ [] = []
-- nombresDeLosQuePuedenSuperarTodos (x:xs) (y:ys) = y

--nombresDeLosQuePuedenSuperarTodos listaJugadores listaObstaculos = map nombre
-- superant listaJugadores listaObstaculos = [nombre x | x <- listaJugadores]
-- menosuno listaObstaculos jugador = (map (palosUtiles jugador) listaObstaculos)

nombresDeLosQuePuedenSuperarTodos listaJugadores listaObstaculos = [nombre x | x <- listaJugadores, pudoSuperarTodos x listaObstaculos]
pudoSuperarTodos jugador listaObstaculos = all (==True) (resultadosDeLosTirosHechos jugador listaObstaculos)

resultadosDeLosTirosHechos jugador listaObstaculos = map (hayAlMenosUnPaloUtil jugador) listaObstaculos
hayAlMenosUnPaloUtil jugador obstaculo
	|length(palosUtiles jugador obstaculo) >= 1 = True
	|otherwise = False

--3.
---a.
listaDeObstaculosSuperados::Tiro -> [Obstaculo] -> [Bool]
listaDeObstaculosSuperados tiro [] = []
listaDeObstaculosSuperados tiro (x:xs)
	|puedeSuperar x tiro == True = (True: listaDeObstaculosSuperados (efectoAplicadoAUnTiro x tiro) xs)
	|otherwise = []
	
cuantosObstaculosSupera tiro listaObstaculos = length (listaDeObstaculosSuperados tiro listaObstaculos)

asdd tiro listaObstaculos = length (supera tiro listaObstaculos)
supera tiro [] = []
supera tiro (x:xs)
	|puedeSuperar x tiro == True = (x: supera ((snd x) tiro) xs)
	|otherwise = []

f a b c d = maximoSegun(c d). filter(==snd a).map b



listaasd = [(2,3),(4,2)]
asd1 (a,_) = a