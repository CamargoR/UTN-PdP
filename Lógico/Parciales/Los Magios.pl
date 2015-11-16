persona(bart).
persona(larry).
persona(otto).
persona(marge).

%los magios son functores alMando(nombre, antiguedad), novato(nombre) y elElegido(nombre).
persona(alMando(burns,29)).
persona(alMando(clark,20)).
persona(novato(lenny)).
persona(novato(carl)).
persona(elElegido(homero)).

%Y contamos con algunos hechos en nuestra base
hijo(homero,abbe).
hijo(bart,homero).
hijo(larry,burns).

salvo(carl,lenny).
salvo(homero,larry).
salvo(otto,burns).

%Los beneficios son funtores confort(descripcion), confort(descripcion, caracteristica), 
%dispersion(descripcion), economico(descripcion, monto).
gozaBeneficio(carl, confort(sillon)).
gozaBeneficio(lenny, confort(sillon)).
gozaBeneficio(lenny, confort(estacionamiento, techado)).
gozaBeneficio(carl, confort(estacionamiento, libre)).
gozaBeneficio(clark, confort(viajeSinTrafico)).
gozaBeneficio(clark, dispersion(fiestas)).
gozaBeneficio(burns, dispersion(fiestas)).
gozaBeneficio(lenny, economico(descuento, 500)).


%Predicados auxiliares

esMagio(Persona):- persona(alMando(Persona,_)).
esMagio(Persona):- persona(novato(Persona)).
esMagio(Persona):- persona(elElegido(Persona)).

esNovato(Persona):- persona(novato(Persona)).
estaAlMando(Persona):- persona(alMando(Persona,_)).
esElElegido(Persona):- persona(elElegido(Persona)).

%1.
aspiranteMagio(Persona):-
	persona(Persona),
	esMagio(Magio),
	hijo(Persona,Magio).
aspiranteMagio(Persona):-
	persona(Persona),
	esMagio(Magio),
	salvo(Persona,Magio).
	
/*aspiranteMagio(Persona):-
	persona(Persona),
	not(esMagio(Persona)),
	esMagio(Magio),
	hijo(Persona,Magio).
aspiranteMagio(Persona):-
	persona(Persona),
	not(esMagio(Persona)),
	esMagio(Magio),
	salvo(Persona,Magio).
*/
%2.
puedeDarOrdenes(Jefe,Subordinado):-
	esElElegido(Jefe),
	esMagio(Subordinado),
	Jefe \= Subordinado.
puedeDarOrdenes(Jefe,Subordinado):-
	persona(alMando(Jefe,_)),
	persona(novato(Subordinado)).
puedeDarOrdenes(Jefe,Subordinado):-
	persona(alMando(Jefe,NumeroJ)),
	persona(alMando(Subordinado,NumeroS)),
	NumeroJ > NumeroS.

	
%3.
sienteEnvidia(Envidioso,Envidiados):-
	aspiranteMagio(Envidioso),
	findall(Persona,esMagio(Persona),Envidiados).
/*sienteEnvidia(Envidioso,Envidiados):-
	persona(Envidioso),
	not(aspiranteMagio(Envidioso)),
	not(esMagio(Envidioso)),
	findall(Magio,esMagio(Magio),Magios),
	findall(Aspirante,aspiranteMagio(Aspirante),Aspirantes),
	append(Magios,Aspirantes,Envidiados).*/
sienteEnvidia(Envidioso,Envidiados):-
	esNovato(Envidioso),
	findall(Persona,estaAlMando(Persona),Envidiados).

%esEnvidioso(Envidioso):-persona(Envidioso),Envidioso\= elElegido(_), Envidioso\= alMando(_), Envidioso\= novato(_).
%siente(Envidioso):-persona(Envidioso),	not(esElElegido(Envidioso)).

%4.

%5.
soloLoGoza(Persona,Beneficio):-
	esMagio(Persona),
	gozaBeneficio(Persona,Beneficio),
	findall(X,gozaBeneficio(X,Beneficio),Xs),
	length(Xs,N),
	N = 1.
	


%not(forall((esMagio(Magio),Magio\=Persona),gozaBeneficio(Magio,Beneficio))).	
/*findall(Magio,gozaBeneficio(Magio,Beneficio),Magios),
	Persona \= Magio,
	length(Magios,N),
	N = 0.
	*/
	
max(N1,N2,Max):-
	N1 > N2,
	Max is N1.
max(N1,N2,Max):-
	N2 > N1,
	Max is N2.
max(N1,N2,Max):-
	N1 = N2,
	Max is N1.
	
/*maximo([X|X2|Xs],M):-
	max(X,X2,M),
	maximo([X2|Xs],M).*/
	
asd([X|Xs],A,C):-
	A is X,
	C is Xs.
	
	
%------------------------------------------------------------

diosMalo(urano,[apolo],60).

diosMalo(kronos,[zeus,urano,afrodita],90).

diosMalo(hades,[kronos,apolo],400).



diosBueno(zeus,hercules,500).

diosBueno(afrodita,eneas,50).

diosBueno(apolo,creso,80).


hijoDivino(afrodita,apolo).

hijoDivino(zeus,afrodita).

hijoDivino(kronos,zeus).

hijoDivino(kronos,urano).


mortal(hercules).

mortal(eneas).

mortal(teseo).

mortal(creso).

mortal(aquiles).



adora(hercules,zeus).

adora(eneas,zeus).

adora(eneas,hades).

adora(teseo,apolo).

adora(teseo,afrodita).

adora(aquiles,urano).

adora(aquiles,kronos).



don(zeus,regalo(hacerOfrenda,placer)).
don(zeus,regalo(pensar,vino)).
don(zeus,castigo(maldecir,rayo)).
don(afrodita,regalo(enamorarse,vino)).
don(afrodita,regalo(pensar,oro)).
don(apolo,regalo(pensar,vino)).
don(apolo,regalo(construir,salud)).

don(urano,castigo(ignorar,sequia)).

accion(eneas,pensar).
accion(hercules,maldecir).
accion(teseo,maldecir).
accion(aquiles,ignorar).
accion(eneas,ignorar).
accion(hercules,construir).
	
	
puedeBendecir(Mortal1,Mortal2):-
	adora(Mortal1,DiosBueno),
	findall(NivelB,diosBueno(DiosBueno,_,NivelB),ListaNivelesB),
	adora(Mortal2,DiosMalo),
	findall(NivelM,diosMalo(DiosMalo,_,NivelM),ListaNivelesM),
	sumlist(ListaNivelesB,DivinidadBueno),
	sumlist(ListaNivelesM,DivinidadMalo),
	DivinidadBueno > DivinidadMalo,
	Mortal1 \=Mortal2.
	
esUnSanto(Mortal):-
	mortal(OtroMortal),
	puedeBendecir(Mortal,OtroMortal).
	
%5.
esDiosBueno(Dios):-diosBueno(Dios,_,_).
esDiosMalo(Dios):-diosMalo(Dios,_,_).
esAccion(Accion):-accion(_,Accion).
daRegalo(Dios,Accion):-don(Dios,regalo(Accion,_)).
daRegalo(Dios,Accion):-don(Dios,regalo(_,Accion)).
castiga(Dios,Accion):-don(Dios,castigo(Accion,_)).
castiga(Dios,Accion):-don(Dios,castigo(_,Accion)).

/*accionConveniente(Accion):-
	esAccion(Accion),
	forall(esDiosBueno(DiosBueno),daRegalo(DiosBueno,Accion)),
	esDiosMalo(DiosMalo),
	findall(DiosMalo,castiga(DiosMalo,Accion),DiosesMalos),
	DiosesMalos=[].*/

accionConveniente(Accion):-
	esAccion(Accion),
	forall(diosBueno(Dios,_,_),don(Dios,regalo(Accion,_))),
	forall(diosMalo(Dios,_,_),not(don(Dios,castigo(Accion,_)))).
/*	
accionMistica(Accion):-
	accion(_,Accion),
	findall(Accion, (diosBueno(Dios,_,_), don(Dios,regalo(Accion,_))), ListaAcciones),
	length(ListaAcciones, Cont),
	Cont = 3.
accionMistica(Accion):-
	diosBueno(_,_,NivelD),
	NivelD = 80.
accionMistica(Accion):-
	diosMalo(_,_,NivelD2),
	NivelD2 = 80.*/


count(A, B, A) :- A =< B.
count(A, B, C) :- A < B, A2 is A+1, count(A2, B, C).