data Propuesta = CPropuesta (String,String,[String],Int,Int) deriving(Show)
data Mentor = CMentor (String,[String],Criterio)

type Criterio = Propuesta -> Int 

propuestasGHC = [CPropuesta ("franco", "detectorDeParcialesCopiados", ["definicionDeLenguajes", "parsing", "compiladores"],3,2),CPropuesta ("adriel", "entornoDeProgramacionHechoEnHaskell", ["programacionFuncional", "monadas", "tiposDeDatosPropios"],2,2)]

mentoresGHC = [CMentor	("carlono", ["detectorDeParcialesCopiados","mejorarPerformanceDelMotor"], (\propuesta -> (length.skills) propuesta + (aniosDeExperiencia propuesta))),CMentor ("nicolas",["entornoDeProgramacionHechoEnHaskell", "extensionesDelLenguaje"],((3+).aniosDeExperiencia))]

aniosDeExperiencia (CPropuesta(_,_,_,anios,_)) = anios
skills (CPropuesta(_,_,sks,_,_)) = sks

nombreAlumno(CPropuesta (nombre,_,_,_,_)) = nombre
nombreProyecto (CPropuesta (_,proyecto,_,_,_)) = proyecto

nombreMentor (CMentor (nombre,_,_)) = nombre
intereses (CMentor (_,intereses,_)) = intereses
criterio ((CMentor (_,_,criterio))) = criterio

fst3 (f,_,_) = f
snd3 (_,s,_) = s
trd (_,_,t) = t

maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b
	|f a >= f b = a
	|otherwise = b

--1.
puntosSegun::Propuesta -> Mentor -> Int
puntosSegun propuesta mentor
	|leInteresaLaPropuesta mentor propuesta = ((+1).criterio mentor) propuesta
	|otherwise = (criterio mentor) propuesta
	
leInteresaLaPropuesta::Mentor -> Propuesta -> Bool
leInteresaLaPropuesta mentor propuesta = any (==nombreProyecto propuesta) (intereses mentor)

--2.
puntajeTotal::Propuesta -> [Mentor] -> Int
puntajeTotal propuesta mentores = sum (puntosOtorgadosCadaMentor propuesta mentores)
puntosOtorgadosCadaMentor::Propuesta -> [Mentor] -> [Int]
puntosOtorgadosCadaMentor propuesta = map (puntosSegun propuesta)

--3.
propuestasConChances::[Propuesta] -> [Propuesta]
propuestasConChances propuestas = filter (tieneMasDeTresSkills) propuestas
tieneMasDeTresSkills::Propuesta -> Bool
tieneMasDeTresSkills = ((>=3).length.skills)

--4.
ranking::[Mentor] -> [Propuesta] -> [(String,String,Int)]
ranking mentores propuestas = map (resultadoDeLaPropuesta mentores) propuestas
resultadoDeLaPropuesta:: [Mentor] -> Propuesta -> (String,String,Int)
resultadoDeLaPropuesta mentores propuesta = (nombreAlumno propuesta, nombreProyecto propuesta,puntajeTotal propuesta mentores)

--5.
propuestasDeInteres::Mentor -> [Propuesta] -> [Propuesta]
propuestasDeInteres mentor propuestas = filter (leInteresaLaPropuesta mentor) propuestas

--6.
resultadoConMasVotos::[Mentor] -> [Propuesta] -> (String,String,Int)
resultadoConMasVotos mentores propuestas = maximoSegun trd (ranking mentores propuestas)

--7.
nombreMentorMasInteresadoEn::Propuesta -> [Mentor] -> String
nombreMentorMasInteresadoEn propuesta mentores = (snd.maximoSegun fst) (listaDeMentoresYSuPuntajeOtorgado propuesta mentores)

listaDeMentoresYSuPuntajeOtorgado::Propuesta -> [Mentor] -> [(Int,String)]
listaDeMentoresYSuPuntajeOtorgado propuesta = map (puntosQueOtorgoElMentor propuesta)
puntosQueOtorgoElMentor::Propuesta -> Mentor -> (Int,String)
puntosQueOtorgoElMentor propuesta mentor = (puntosSegun propuesta mentor, nombreMentor mentor)

--8.
proyectosElegidos::[Mentor] -> [Propuesta] -> [(String,String,String)]
proyectosElegidos mentores propuestas = map (generarTripla mentores) (propuestasConMasDeDocePuntos mentores propuestas)
generarTripla::[Mentor] -> Propuesta -> (String,String,String)
generarTripla mentores propuesta = (nombreAlumno propuesta,nombreMentorMasInteresadoEn propuesta mentores,nombreProyecto propuesta)

propuestasConMasDeDocePuntos::[Mentor] -> [Propuesta] -> [Propuesta]
propuestasConMasDeDocePuntos mentores propuestas = filter (laPropuestaTieneMasDeDocePuntos mentores) propuestas

laPropuestaTieneMasDeDocePuntos::[Mentor] -> Propuesta -> Bool
laPropuestaTieneMasDeDocePuntos mentores = ((>12).trd.resultadoDeLaPropuesta mentores)

propuestasConMasDeDocePuntos' mentores propuestas = filter (\p -> ((>12).trd.resultadoDeLaPropuesta mentores) p) propuestas
