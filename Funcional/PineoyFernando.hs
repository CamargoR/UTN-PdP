--1...........................
esApropiado unNombre = esConsonante (primeraLetra unNombre) && tieneMenosDeDiezCaracteres unNombre

esConsonante unaLetra = not(esVocal unaLetra)
esVocal unaLetra = elem unaLetra "aeiouAEIOU"
primeraLetra unNombre = head unNombre
tieneMenosDeDiezCaracteres unaPalabra = length unaPalabra<=10


--2..............................
esRaro unNombre = cantidadDeConsonantes unNombre > cantidadDeVocales unNombre

cantidadDeConsonantes unNombre = length (consonantes unNombre)
cantidadDeVocales unNombre = length (vocales unNombre)

consonantes unNombre = filter esConsonante unNombre
vocales unNombre = filter esVocal unNombre

--3..............................
superinverconcat unaPalabra otraPalabra = invertir(concatenar unaPalabra otraPalabra)

concatenar unaPalabra otraPalabra = unaPalabra ++ otraPalabra

invertir [] = []
invertir (x:xs) = invertir xs ++ [x]

--4............................
esSubliminal unProducto = esApropiado (nombre unProducto) && cantidadDeCompanias unProducto <= 5
nombre (unNombre,_) = unNombre
cantidadDeCompanias (_,cantidad) = cantidad

--5............................
data Personajes = CPersonaje (String,Int)

--6............................
esPeligroso (_,nivelPeligrosidad) = nivelPeligrosidad > 14

--7............................
esVillano (nombre, nivelPeligrosidad) = esRaro nombre && not(esPeligroso (nombre,nivelPeligrosidad))

--8............................
-- esViable unShow = esAceptado unShow && esSuficientementeMalvado unShow && esSuficientementeSubliminal unShow
esAceptado unShow productos = cantidadParDePersonajes unShow && todosTienenNombreApropiado unShow 
-- longitudYPeligrosidad unShow

cantidadParDePersonajes personajes = esPar (cantidadDePersonajes personajes)

cantidadDePersonajes personajes = length (personajes) 
esPar numero = esDivisiblePorDos numero
esDivisiblePorDos numero = mod numero 2 == 0



todosTienenNombreApropiado personajes = cantidadDePersonajes personajes == cantidadDePersonajesApropiados personajes

cantidadDePersonajesApropiados personajes = length (apropiados personajes)
apropiados personajes = filter esApropiado (obtenerNombres personajes)
obtenerNombres personajes = map fst personajes

	

--b)
esSuficientementeMalvado unShow productos = (cantPersonajesPeligrosos unShow > cantPersonajesInofensivos unShow) && cantidadDeProductos productos > mitadDeLosPersonajes unShow && hayAlMenosUnVillano unShow

cantPersonajesPeligrosos personajes = length(personajesPeligrosos personajes)
personajesPeligrosos personajes = filter esPeligroso personajes

cantPersonajesInofensivos personajes = length(personajesInofensivos personajes)
personajesInofensivos personajes = filter esInofensivo personajes
esInofensivo (_,nivelPeligrosidad) = nivelPeligrosidad <=14

hayAlMenosUnVillano personajes = cantVillanos personajes >= 1
cantVillanos personajes = length(villanos personajes)
villanos personajes = filter esVillano personajes

cantidadDeProductos productos = length(productos)
mitadDeLosPersonajes personajes = div (cantidadDePersonajes personajes) 2




--map fst (filter (esVillano) [("Ronan",13),("Raad",2)])

