fechaDeHoy(fecha(5,7,2013)).

hombre(luis).
hombre(jose).
mujer(lucia).
mujer(andrea).
mujer(ana).

disfraz(gatubela,mujer,[comic,batman,cine,sexy]).
disfraz(batman,hombre,[comic,batman,cine]).
disfraz(superman,hombre,[comic,cine]).
disfraz(spiderman,hombre,[comic,cine]).
disfraz(mujerMaravilla,mujer,[comic,cine]).
disfraz(zombie,unisex,[comic,cine,terror]).
disfraz(slash,hombre,[rock]).
disfraz(elefanteRosado,unisex,[wtf]).
disfraz(cajaVengadora,unisex,[wtf]).
disfraz(vaquero,unisex,[western]).
disfraz(odalisca,mujer,[baile,sexy]).
disfraz(bailarina,mujer,[baile]).
disfraz(payasoIT,hombre,[terror,cine]).
disfraz(jason,hombre,[terror,cine]).
disfraz(scream,unisex,[terror,cine]).
disfraz(slenderMan,hombre,[terror,videojuego]).
disfraz(bruja,mujer,[terror]).

categoria(Disfraz,Categoria):-
	disfraz(Disfraz,_,Categorias),
	member(Categoria,Categorias).
	

fiesta(halloween(ana,2011),fecha(31,10,2011)).
fiesta(halloween(ana,2010),fecha(31,10,2010)).
fiesta(cumpleanios(lucia,10,ana),fecha(20,10,2013)).
fiesta(cumpleanios(andrea,25,andrea),fecha(10,12,2013)).


eligioDisfraz(luis,payasoIT,halloween(ana,2010)).
eligioDisfraz(ana,gatubela,halloween(ana,2010)).
eligioDisfraz(lucia,zombie,halloween(ana,2010)).
eligioDisfraz(luis,jason,halloween(ana,2011)).
eligioDisfraz(ana,bruja,halloween(ana,2011)).
eligioDisfraz(lucia,bruja,halloween(ana,2011)).
eligioDisfraz(andrea,gatubela,halloween(ana,2011)).
%Para los futuros cumpleaños el cumpleañero siempre tiene elegido el disfraz que va a usar  
eligioDisfraz(andrea,mujerMaravilla,cumpleanios(andrea,25,andrea)).
eligioDisfraz(lucia,bailarina,cumpleanios(lucia,10,ana)).



interes(lucia,baile).
interes(andrea,sexy).
interes(andrea,baile).
interes(andrea,cine).
interes(ana,terror).
interes(ana,cine).
interes(luis,comic).
interes(luis,terror).
interes(luis,wtf).
interes(jose,rock).
interes(jose,terror).



persona(Persona):-
	hombre(Persona).
persona(Persona):-
	mujer(Persona).
esDisfraz(Disfraz):-
	disfraz(Disfraz,_,_).
esFiesta(Fiesta):-
	fiesta(Fiesta,_).

	

%1.
leGusta(Persona,Disfraz):-
	interes(Persona,Categoria),
	categoria(Disfraz,Categoria).
	
%2.
tematica(Fiesta,Tema):-
	categoria(Disfraz,Tema),
	eligioDisfraz(_,Disfraz,Fiesta).
	/*fiesta(Fiesta,_),
	findall(Categoria,interes(_,Categoria),Temas),
	member(Tema,Temas),
	forall(asistioAFiestaConDisfraz(Disfraz,Fiesta),temaCorrecto(Disfraz,Tema)).*/
	
asistioAFiestaConDisfraz(Disfraz,Fiesta):-
	eligioDisfraz(_,Disfraz,Fiesta).
	
temaCorrecto(Disfraz,Tema):-
	categoria(Disfraz,Tema).

	
%3.
estaQuemado(Disfraz):-
	fueUsadoPor(Persona1,Persona2,Disfraz),
	Persona1\=Persona2.
estaQuemado(Disfraz):-
	fueUsadoEnTodasLasFiestasPasadas(Disfraz).
	
	
fueUsadoPor(Persona1,Persona2,Disfraz):-
	esFiesta(Fiesta),
	eligioDisfraz(Persona1,Disfraz,Fiesta),
	eligioDisfraz(Persona2,Disfraz,Fiesta).
	
fueUsadoEnTodasLasFiestasPasadas(Disfraz):-
	esDisfraz(Disfraz),
	forall(fiestaPasada(Fiesta),eligioDisfraz(_,Disfraz,Fiesta)).
	

fiestaPasada(Fiesta):-
	fiesta(Fiesta,Fecha),
	fechaPasada(Fecha).	
fechaPasada(fecha(_,_,A)):-
	fechaDeHoy(fecha(_,_,Ahoy)),
	A < Ahoy.
fechaPasada(fecha(_,M,A)):-
	fechaDeHoy(fecha(_,Mhoy,Ahoy)),
	A = Ahoy,
	M < Mhoy.
fechaPasada(fecha(D,M,A)):-
	fechaDeHoy(fecha(Dhoy,Mhoy,Ahoy)),
	A = Ahoy,
	M = Mhoy,
	D < Dhoy.
	

%4.
disfrazApropiado(Disfraz,Fiesta):-
	fiesta(Fiesta,_),
	esHalloween(Fiesta),
	categoria(Disfraz,terror).
	
disfrazApropiado(Disfraz,Fiesta):-
	esFiesta(Fiesta),
	disfrazCumpleaniero(Fiesta,DisfrazCumpleaniero),
	esDisfraz(Disfraz),
	not(opaca(Disfraz,DisfrazCumpleaniero)),
	disfrazEsApropiadoParaEdadDelCumpleaniero(Disfraz,Fiesta).
	
	
disfrazCumpleaniero(cumpleanios(Cumpleaniero,_,_),DisfrazCumpleaniero):-
	eligioDisfraz(Cumpleaniero,DisfrazCumpleaniero,cumpleanios(Cumpleaniero,_,_)).
	
opaca(Disfraz,DisfrazOpacado):-
	esDisfrazProvocativo(Disfraz),
	disfraz(DisfrazOpacado,_,Categorias),
	not(member(sexy,Categorias)).
opaca(elefanteRosado,_).
	
disfrazEsApropiadoParaEdadDelCumpleaniero(_,cumpleanios(_,Edad,_)):-
	rangoDeEdadAceptable(Edad).
disfrazEsApropiadoParaEdadDelCumpleaniero(Disfraz,cumpleanios(_,Edad,_)):-
	not(rangoDeEdadAceptable(Edad)),
	not(esDisfrazProvocativo(Disfraz)).

rangoDeEdadAceptable(Edad):-
	Edad >= 18,
	Edad < 50.

esDisfrazProvocativo(Disfraz):-
	categoria(Disfraz,Categoria),
	Categoria = sexy.
esHalloween(halloween(Organizador,_)):-
	persona(Organizador).
	

%5.
/*disfrazSugerido(Persona,Fiesta,Disfraz):-
	leGusta(Persona,Disfraz),
	generoCorrecto(Persona,Disfraz),
	fiestaProxima(Fiesta),
	not(usoDisfraz(Persona,Disfraz)).*/


disfrazSugerido(Persona, Fiesta, Disfraz):-
	leGusta(Persona, Disfraz),
	generoCorrecto(Persona, Disfraz),
	not(eligioDisfraz(Persona,Disfraz,Fiesta)),
	fiesta(Fiesta,_),
	disfrazApropiado(Disfraz, Fiesta).
	
generoCorrecto(Persona,Disfraz):-
	hombre(Persona),
	disfraz(Disfraz,Genero,_),
	Genero = hombre.
generoCorrecto(Persona,Disfraz):-
	mujer(Persona),
	disfraz(Disfraz,Genero,_),
	Genero = mujer.
generoCorrecto(_,Disfraz):-
	disfraz(Disfraz,Genero,_),
	Genero = unisex.
	
/*fiestaProxima(Fiesta):-
usoDisfraz(Persona,Fiesta,Disfraz):-
	eligioDisfraz(Persona,Disfraz,Fiesta)*/
	


%6.1
sinRepetidos([],[]).
sinRepetidos([X|XS], NuevoXS):-
	member(X, XS),
	sinRepetidos(XS, NuevoXS).
sinRepetidos([X|XS], [X|NuevoXS]):-
	not(member(X, XS)),
	sinRepetidos(XS, NuevoXS).


%6.2
popularidad(Disfraz,Popularidad):-
	esDisfraz(Disfraz),
	cantidadDePersonasQueLeGustaUnDisfraz(Disfraz,Cantidad),
	cantidadDeUsosDeUnDisfraz(Disfraz,CantidadDeUsos),
	Popularidad is CantidadDeUsos*Cantidad.
	
cantidadDePersonasQueLeGustaUnDisfraz(Disfraz,Cantidad):-
	findall(Persona,leGusta(Persona,Disfraz),Personas),
	sinRepetidos(Personas,SinRepetidos),
	length(SinRepetidos,Cantidad).
	
cantidadDeUsosDeUnDisfraz(Disfraz,CantidadDeUsos):-
	findall(Disfraz,(eligioDisfraz(_,Disfraz,Fiesta),fiestaPasada(Fiesta)),Disfraces),
	length(Disfraces,CantidadDeUsos).
	
%7.
buenAnfitrion(Persona):-
	fueAnfitrion(Persona),
	fiestaPasada(Fiesta),
	fueFiestaPopular(Fiesta,PopularidadTotal),
	PopularidadTotal>100.
	
	
fueAnfitrion(Persona):-
	fiesta(cumpleanios(_,_,Persona),_).
fueAnfitrion(Persona):-
	fiesta(halloween(Persona,_),_).
	

disfracesUsadosEnUnaFiesta(Disfraces,Fiesta):-
	findall(Disfraz,eligioDisfraz(_,Disfraz,Fiesta),DisfracesUsados),
	sinRepetidos(DisfracesUsados,Disfraces).

fueFiestaPopular(Fiesta,PopularidadTotal):-
	disfracesUsadosEnUnaFiesta(Disfraces,Fiesta),
	forall(member(Disfraz,Disfraces),not(estaQuemado(Disfraz))),
	findall(PopularidadDeUnDisfraz,member(Disfraz,Disfraces),popularidad(Disfraz,PopularidadDeUnDisfraz),ListaDePopularidad),
	sumlist(ListaDePopularidad,PopularidadTotal).