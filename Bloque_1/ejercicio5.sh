#!/bin/bash

#Verificar terminal
if [ "$#" -ne 1 ]; then
	echo "Uso: $0 <ruta-directorio>"
	exit 1
fi

DIRECTORIO=$1

#Comprobar existencia directorio
if [ ! -d "$DIRECTORIO" ]; then
	echo "El directorio no existe."
	exit 1
fi

#Recorremos archivos y mostramos información
find "$DIRECTORIO" -type f | while read -r archivo; do
	#Después de encontrar todos los archivos del fichero con el find, el | mete uno a la vez en archivo para explorarlo
	nombre=$(basename "$archivo")
	#basename es nombre archivo sin la ruta completa
	ruta=$(realpath "$archivo")
	#realpath es el real path (wow!)
	fecha_mod=$(stat -c %Y "$archivo")
	tamano=$(stat -c %s "$archivo") #Si pones ñ bash te fulmina
	permisos=$(stat -c %A "$archivo")
	echo -e "$nombre \t$ruta \t$fecha_mod \t$tamano bytes \t$permisos"
done | sort -k3n
	#El -e es para que podamos usar \t que es el tabulador

#find "$DIRECTORIO" -> Buscar dentro del directorio
#-type f -> Buscar, pero sólo archivos
#sort -k3n -< Ordena por la tercera columna (fecha modificación) en orden ascendete
