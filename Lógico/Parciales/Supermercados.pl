%primeraMarca(Marca)
primeraMarca(laSerenisima).
primeraMarca(gallo).
primeraMarca(vienisima).

%precioUnitario(Producto,Precio)
%donde Producto puede ser arroz(Marca), lacteo(Marca,TipoDeLacteo), salchichas(Marca,Cantidad)
precioUnitario(arroz(gallo),25.10).
precioUnitario(lacteo(laSerenisima,leche),6.00).
precioUnitario(lacteo(laSerenisima,crema),4.00).
precioUnitario(lacteo(gandara,queso(gouda)),13.00).
precioUnitario(lacteo(vacalin,queso(mozzarella)),12.50).
precioUnitario(salchichas(vienisima,12),9.80).
precioUnitario(salchichas(vienisima, 6),5.80).
precioUnitario(salchichas(granjaDelSol, 8),5.10).


%compro(Cliente,Producto,Cantidad)
compro(juan,lacteo(laSerenisima,crema),2).


%1.
/*Desarrollar la lógica para agregar los siguientes descuentos 
    ­ El arroz tiene un descuento del  $1.50.   
    ­ Las salchichas tienen $0,50 de descuento si no son vienisima.  
    ­ Los lacteos tienen $2 de descuento si son leches o quesos de primera marca. (el primera marca sólo se refiere a 
los quesos). 
    ­ El producto con el mayor precio unitario tiene 5% de descuento.*/


productoSalchichas(salchichas(_)).
esVienisima(salchichas(vienisima,_)).
productoArroz(arroz(_)).
productoLacteo(lacteo(_)).

esQuesoDePrimeraMarca(lacteo(Marca,queso(_))):-	primeraMarca(Marca).

%descuento(Producto, Descuento)
descuento(lacteo(laSerenisima,leche), 0.20).
descuento(lacteo(laSerenisima,crema), 0.70).
descuento(lacteo(gandara,queso(gouda)), 0.70).
descuento(lacteo(vacalin,queso(mozzarella)), 0.05).

descuento(Producto,DescuentoNuevo):-
	precioUnitario(Producto,_),
	productoArroz(Producto),
	DescuentoNuevo is 1.50.
descuento(Producto,DescuentoNuevo):-
	precioUnitario(Producto,_),
	productoSalchichas(Producto),
	not(esVienisima(Producto)),
	DescuentoNuevo is 0.50.		
descuento(Producto,DescuentoNuevo):-
	precioUnitario(Producto,_),
	esQuesoDePrimeraMarca(Producto),
	DescuentoNuevo is 2.00.
	
%2.
/*Saber si un cliente es comprador compulsivo, lo cual sucede si compró todos los productos de primera marca que 
tuvieran descuento.*/

esCliente(Cliente):- compro(Cliente,_,_).

compradorCompulsivo(Cliente):-
	esCliente(Cliente),
	forall(compro(Cliente,Producto,_),descuento(Producto,_)).
	
%3.
/*Definir el predicado totalAPagar/2 que relaciona a un cliente con el total de su compra teniendo en cuenta que para 
cada producto comprado se debe considerar el precio con los descuentos que tenga.*/

aplicarDescuento(Precio,PrecioConDescuento,Producto):-
	precioUnitario(Producto,Precio),
	descuento(Producto,Descuento),
	PrecioConDescuento is Precio - Descuento.

precioDeVenta(Producto,Cantidad,Precio):-
	aplicarDescuento(_,PrecioUnitario,Producto),
	Precio is PrecioUnitario * Cantidad.
	

/*totalAPagar(Cliente,PrecioTotal):-
	findall(Precio,(compro(Cliente,Producto,Cantidad),precioDeVenta(Producto,Cantidad,Precio)),Precios),*/
	
