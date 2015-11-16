data Gimnasta = CGimnasta String Float Float Float deriving(Show) 
pancho = CGimnasta "Francisco" 40.0 120.0 1.0 
andres = CGimnasta "Andy" 22.0 80.0 6.0
dios = CGimnasta "Dios" 40.0 90.0 5.0

nombre (CGimnasta nombre _ _ _ ) = nombre
edad (CGimnasta _ edad _ _) = edad
peso (CGimnasta  _ _ peso _ ) = peso
tonificacion (CGimnasta  _ _ _ tonificacion) = tonificacion
