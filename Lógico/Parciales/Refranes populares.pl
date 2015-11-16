%1.

cuchillo(juan, palo). 
cuchillo(pedro, palo). 
cuchillo(ana, metal). 
cuchillo(oscar, metal). 
 
profesion(ana, costurera). 
profesion(juan, herrero). 
profesion(pedro, carpintero). 
profesion(oscar, herrero). 


esHerrero(Persona):-profesion(Persona,herrero).
tieneCuchilloDePalo(Persona):-cuchillo(Persona,palo).
persona(Persona):-cuchillo(Persona,_).
persona(Persona):-profesion(Persona,_).

cumpleElRefran(Persona):-
	esHerrero(Persona),
	tieneCuchilloDePalo(Persona).

/*cumpleElRefran(Persona):-
	persona(Persona),
	forall(esHerrero(Persona),tieneCuchilloDePalo(Persona)).
*/
cumpleElRefran(Personas):-
	persona(Persona),
	findall(Persona, (esHerrero(Persona)),Personas),
	member(Persona,Personas),
	tieneCuchilloDePalo(Persona).

