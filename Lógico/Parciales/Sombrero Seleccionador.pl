mago(harry,mestiza,[coraje,amistad,orgullo,inteligencia]).
mago(ron,pura,[amistad,diversion,coraje]).
mago(hermione,impura,[inteligencia,coraje,responsabilidad,amistad,orgullo]).
mago(hannaAbbott,mestiza,[amistad,diversion]).
mago(draco,pura,[inteligencia,orgullo]).
mago(lunaLovegood,mestiza,[inteligencia,responsabilidad,amistad,coraje]).

odia(harry,slytherin).
odia(draco,hufflepuff).

casa(gryffindor).
casa(hufflepuff).
casa(ravenclaw).
casa(slytherin).

caracteriza(gryffindor,amistad).
caracteriza(gryffindor,coraje).
caracteriza(slytherin,orgullo).
caracteriza(slytherin,inteligencia).
caracteriza(ravenclaw,inteligencia).
caracteriza(ravenclaw,responsabilidad).
caracteriza(hufflepuff,amistad).
caracteriza(hufflepuff,diversion).


%Predicados auxiliares
esMago(Nombre):-mago(Nombre,_,_).
esImpuro(Mago):-mago(Mago,impura,_).
esAmistoso(Mago):-mago(Mago,_,CaracteristicasMago), member(amistad,CaracteristicasMago).

%1.
permiteEntrar(slytherin,Mago):-
	esMago(Mago),
	not(esImpuro(Mago)).
permiteEntrar(Casa,Mago):-
	esMago(Mago),
	casa(Casa),
	Casa \=slytherin.
	
%2.
tieneCaracter(Mago,Casa):-
	casa(Casa),
	mago(Mago,_,CaracteristicasMago),
	forall(caracteriza(Casa,CaracteristicasCasa),member(CaracteristicasCasa,CaracteristicasMago)).

%3.
casaPosible(Mago,Casa):-
	tieneCaracter(Mago,Casa),
	permiteEntrar(Casa,Mago),
	not(odia(Mago,Casa)).
	
%4.
/*podrianEstarEnLaMismaCasa([X1|X2|Xs]):-
	casa(Casa),
	esMago(X),
	esMago(Y),
	forall((member(X,[X1|X2|Xs]),member(Y,[X2|Xs])),(casaPosible(X,Casa),casaPosible(Y,Casa))).*/
	
	
/*cadenaDeAmistades(ListaDeMagos):-
	forall(member(Mago,ListaDeMagos),esAmistoso(Mago)),
	podrianEstarEnLaMismaCasa(ListaDeMagos,Magos),
	ListaDeMagos=Magos.*/
	
/*cadenaDeAmistades(ListaDeMagos):-
	forall(member(Mago,ListaDeMagos),esAmistoso(Mago)),
	nth1(Pos,ListaDeMagos,Mago),
	nth1(Pos2,ListaDeMagos,Mago2),
	Pos2 is Pos + 1,
	casaPosible(Mago,Casa),
	casaPosible(Mago2,Casa),
	Pos <N,
	Pos2 <= N,
	length(ListaDeMagos,N).*/
	
cadenaDeAmistades([]).
cadenaDeAmistades([H1|[H2|T]]:-
	esAmistoso(H1),
	esAmistoso(H2),
	casaPosible(H1),
	casaPosible(H2),
	cadenaDeAmistades([H2|[T]]).
	
	


/*podrianEstarEnLaMismaCasa([],[]).
podrianEstarEnLaMismaCasa([X1|X2|Xs],Magos):-
	casa(Casa),
	esMago(X1),
	esMago(X2),
	casaPosible(X1,Casa),
	casaPosible(X2,Casa),
	podrianEstarEnLaMismaCasa([X2|Xs],),*/
	
	
lugarProhibido(bosque,50).
lugarProhibido(seccionRestringida,10).
lugarProhibido(tercerPiso,75).

alumnoFavorito(flitwick,hermione).
alumnoFavorito(snape,draco).
alumnoOdiado(snape,harry).

hizo(ron,buenaAccion(jugarAlAjedrez,50)).
hizo(harry,fueraDeCama).
hizo(hermione,irA(tercerPiso)).
hizo(hermione,responder("Wingardium leviosa",25,flitwick)).
hizo(ron,irA(bosque)).
hizo(draco,irA(mazmorras)).

esDe(harry,gryffindor).

esLugarProhibido(Lugar):-lugarProhibido(Lugar,_).
