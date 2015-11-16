pedido(franco,explosiva).
pedido(lucas,dulceDeLecheLatte).
pedido(lucas,irishCream).
pedido(vero,frappuccinoFrutilla).
pedido(gus,mochaBlanco).
pedido(gus,irishCream).
pedido(gus,explosiva).
pedido(asd,porSuPollo).
pedido(gus,tuVieja).
pedido(palermo,manaos).
pedido(tarcano,manaos).
pedido(tarcano,explosiva).
pedido(milapizza,explosiva).

bebida(dulceDeLecheLatte,[base(cafe,100),leche(10,50)]).
bebida(frappuccinoFrutilla,[base(helado,80),jarabe(frutilla),jarabe(dulceDeLeche),leche(2,60)]).
bebida(irishCream,[base(cafe,90),jarabe(baileys),leche(3,50)]).
bebida(explosiva,[base(ron,90),base(vodka,100),jarabe(frutilla)]).
bebida(tuVieja,[jarabe(frutilla)]).
bebida(porSuPollo,[jarabe(pollo),jarabe(pollo),jarabe(pollo),jarabe(pollo),jarabe(pollo),jarabe(pollo),jarabe(pollo),jarabe(pollo),jarabe(pollo),jarabe(pollo),jarabe(pollo)]).
bebida(manaos,[veneno(xxx),veneno(sudorDePalermo)]).

tieneAlcohol(baileys).
tieneAlcohol(tiaMaria).
tieneAlcohol(vodka).
tieneAlcohol(ron).
tieneAlcohol(sudorDePalermo).


%1.
ingrediente(Bebida,Ingrediente):-
	bebida(Bebida,Ingredientes),
	member(Ingrediente,Ingredientes).
	
%2.
caloriasTotales(Bebida,CaloriasTotales):-
	bebida(Bebida,Ingredientes),
	findall(Calorias,(member(Ingrediente,Ingredientes),caloriasPorIngrediente(Ingrediente,Calorias)),ListaDeCalorias),
	sumlist(ListaDeCalorias,CaloriasTotales).

%veneno(manaos)
caloriasPorIngrediente(Ingrediente,Calorias):-
	ingrediente(_,Ingrediente),
	Ingrediente=veneno(_),
	Calorias is 0.	
%fin veneno
	
caloriasPorIngrediente(Ingrediente,Calorias):-
	ingrediente(_,Ingrediente),
	Ingrediente = base(cafe,Cantidad),
	Calorias is Cantidad*2.
	
%caloriasPorIngrediente(Ingrediente,Calorias):-
%	ingrediente(_,Ingrediente),
%	Ingrediente=base(Base,Cantidad),
%	Base\=cafe,
%	Calorias is Cantidad*10.

caloriasPorIngrediente(base(Base,Cantidad),Calorias):-
	Base\=cafe,
	Calorias is Cantidad*10.
	
%caloriasPorIngrediente(Ingrediente,Calorias):-
%	ingrediente(_,Ingrediente),
%	Ingrediente=jarabe(_),
%	Calorias is 10.

caloriasPorIngrediente(jarabe(_),Calorias):-
	Calorias is 10.

caloriasPorIngrediente(Ingrediente,Calorias):-
	ingrediente(_,Ingrediente),
	Ingrediente=leche(Grasa,Cantidad),
	Calorias is Grasa*Cantidad.

	
%3.
bebidaLight(Bebida):-
	bebida(Bebida,Ingredientes),
	caloriasTotales(Bebida,CaloriasTotales),
	CaloriasTotales<80,
	forall(member(Ingrediente,Ingredientes),(caloriasPorIngrediente(Ingrediente,Calorias),Calorias<15)).
	
	
%4.
/*bebidaAlcoholica(Bebida):-
	bebida(Bebida,Ingredientes)
	ingrediente(Bebida,base(TipoIngrediente,_)),
	tieneAlcohol(TipoIngrediente).%Devuelve 2 veces
bebidaAlcoholica(Bebida):-
	ingrediente(Bebida,jarabe(TipoIngrediente)),
	tieneAlcohol(TipoIngrediente).
	*/
%Para todo negado

bebidaAlcoholica(Bebida):-
	bebida(Bebida,Ingredientes),
	not(forall(member(base(TipoIngrediente,_),Ingredientes),not(tieneAlcohol(TipoIngrediente)))).
bebidaAlcoholica(Bebida):-
	bebida(Bebida,Ingredientes),
	not(forall(member(jarabe(TipoIngrediente),Ingredientes),not(tieneAlcohol(TipoIngrediente)))).

	
%5.
esCliente(Cliente):-pedido(Cliente,_).

tienenProblemitas(Clientes):-
	findall(Cliente,(esCliente(Cliente),tieneProblemitas(Cliente)),Clientes).
tieneProblemitas(Cliente):-
	pedido(Cliente,Bebida),
	bebida(Bebida,Ingredientes),
	length(Ingredientes,Cantidad),
	Cantidad>10,
	not(bebidaLight(Bebida)).
tieneProblemitas(Cliente):-
	esCliente(Cliente),
	forall(bebidaAlcoholica(Bebida),pedido(Cliente,Bebida)),
	not(bebidaLight(Bebida)).
	
	
%6.
redDeGustos(C1,C2):-
	pedido(C1,Bebida),
	pedido(C2,Bebida),
	C1\=C2.
redDeGustos(C1,C2):-
	redDeGustos(C1,C3),
	redDeGustos(C2,C3),
	C2\=C1.
	
%%%%%%%%%%

longitud([],0).
longitud([_|T],N):-
	longitud(T,N1),
	N is N1+1.
	
sinRepetidos([],[]).
sinRepetidos([H|T],ListaSinRepetidos):-
	member(H,T),
	sinRepetidos(T,ListaSinRepetidosAux),
	ListaSinRepetidosAux is List,
	append(ListaSinRepetidos,[],List).
sinRepetidos([H|T],ListaSinRepetidos):-
	not(member(H,T)),
	sinRepetidos(T,ListaSinRepetidosAux),
	ListaSinRepetidosAux is List,
	append([H],ListaSinRepetidos,List).
	
maximo([],0).
maximo([H|T],M):-
	maximo(T,M1),
	H>M,
	M1 is H.