--antes del amanecer, desarrollaran su plan y cuando salga el sol, el mundo conquistaran

pinky = CAnimal 10 "raton" ["licenciado"]
cerebro = CAnimal 500 "raton" ["inteligencia","conquistar el mundo","persuasividad","liderazgo","valor","ingeniero"]
dumbo = CAnimal 120 "elefante" ["fuerza","volar"]


--1.
data Animal = CAnimal Int String [String] deriving(Show)-- CI Especie Habilidades

ci (CAnimal ci _ _) = ci
especie (CAnimal _ e _) = e
habilidades (CAnimal _ _ h) = h

--2. Transformaciones
inteligenciaSuperior n (CAnimal ci especie habilidades) = CAnimal (ci + n) especie habilidades
pinkificar (CAnimal ci especie _) = CAnimal ci especie []
superpoderes (CAnimal ci especie habilidades)
	|especie == "elefante" = CAnimal ci especie ("no tenerle miedo a los ratones":habilidades)
	|especie == "raton" && ci > 100 = CAnimal ci especie ("hablar":habilidades)
	|otherwise = CAnimal ci especie habilidades
--funcion auxiliar
hacerSonidosPinkiescos (CAnimal ci especie habilidades) = CAnimal ci especie ("asd":"qwe":"zxc":habilidades)

--3. Criterios
antropomorfico (CAnimal ci _ habilidades)
	|puedeHablar habilidades && ci > 60 = True
	|otherwise = False
puedeHablar = any (=="hablar")

noTanCuerdo (CAnimal _ _ habilidades)
	|puedeHacerMasDeDosSonidosPinkiescos habilidades = True
	|otherwise = False

puedeHacerMasDeDosSonidosPinkiescos = ((>2).length.map pinkiesco)
pinkiesco = (\habilidadSonido -> habilidadSonido=="asd" || habilidadSonido=="qwe" || habilidadSonido=="zxc")

--4.
data Experimento = CExperimento ([Transformacion],Exito)
type Transformacion = (Animal -> Animal)
type Exito = (Animal -> Bool)

transformaciones (CExperimento (ts,_)) = ts
exito (CExperimento (_,ex)) = ex

exp1 = CExperimento ([inteligenciaSuperior 20, superpoderes],antropomorfico)
exp2 = CExperimento ([inteligenciaSuperior 1000, superpoderes, pinkificar],noTanCuerdo)
exp3 = CExperimento ([superpoderes],antropomorfico)
exp4 = CExperimento ([pinkificar, hacerSonidosPinkiescos],noTanCuerdo)

experimentoExitoso experimento animal = (verificarResultado (exito experimento).hacerExperimento (transformaciones experimento)) animal

hacerExperimento [] animal = animal
hacerExperimento (exp:exps) animal = (hacerExperimento exps.exp) animal

verificarResultado criterio animal = criterio animal

--Consulta
animalEjemplo = CAnimal 17 "raton" ["destruir el mundo","hacer planes desalmados"]
expEjemplo = ([pinkificar,inteligenciaSuperior 10, superpoderes],antropomorfico)

--experimentoExitoso expEjemplo animalEjemplo => False

--5.
data Reporte = CReporte [Animal] [String] Experimento

rep1 = CReporte [pinky,cerebro] ["hablar","saltar"] exp1
rep2 = CReporte [cerebro,dumbo] ["programar en Haskell","abstraer"] exp3
rep3 = CReporte [pinky,dumbo] ["fuerza","volar"] exp3

----Funciones genericas
hacerExperimentoEnTodosLosAnimales experimento animales = map (hacerExperimento (transformaciones experimento)) animales
filtrarLosAnimalesQue criterio capacidades tipoDeFiltro = filter (criterio capacidades.tipoDeFiltro)
generarListaDe tipoDeLista = map tipoDeLista

funcionTuVieja a b c d = (generarListaDe a.filtrarLosAnimalesQue b c habilidades. hacerExperimentoEnTodosLosAnimales d)

--5.1.

coeficienteDeLosAnimalesQuePoseenAlgunaHabilidadDeLaLista (CReporte animales capacidades experimento) = (generarListaDe ci.filtrarLosAnimalesQue tieneAlgunaCapacidad capacidades habilidades. hacerExperimentoEnTodosLosAnimales experimento) animales
tieneAlgunaCapacidad capacidades habilidades = (any (==True).map (\capacidad -> any (==capacidad) habilidades)) capacidades

coef (CReporte animales capacidades experimento) = funcionTuVieja ci tieneAlgunaCapacidad capacidades experimento animales

--coeficienteDeLosAnimalesQuePoseenAlgunaHabilidadDeLaLista (CReporte animales capacidades experimento) = (map ci.filter (tieneAlgunaCapacidad capacidades.habilidades). hacerExperimentoEnTodosLosAnimales experimento) animales
--tieneAlgunaCapacidad capacidades habilidades = any (\capacidad -> any (==capacidad) habilidades ) capacidades

--5.2.
especieDeLosAnimalesQuePoseenTodasLasHabilidadesDeLaLista (CReporte animales capacidades experimento) = (generarListaDe especie.filtrarLosAnimalesQue tieneTodasLasCapacidades capacidades habilidades. hacerExperimentoEnTodosLosAnimales experimento) animales
tieneTodasLasCapacidades capacidades habilidades = (all (==True).map (\capacidad -> any (==capacidad) habilidades)) capacidades

esp (CReporte animales capacidades experimento) = funcionTuVieja especie tieneTodasLasCapacidades capacidades experimento animales

--5.3

