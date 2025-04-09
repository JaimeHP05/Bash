#!/bin/bash

#Función para generar el índice
generar_indice() {
	#Está bastante feo, pero no es mi culpa que haya que usar HTML...
	DIRECTORIO="$1"
	INDICE="$DIRECTORIO/index.html"
	
	#Cosas de html (crear el archivo)
	echo "<ul>" > "$INDICE"
	
	#Recorrer todos los elementos de DIRECTORIO
	for ELEMENTO in "$DIRECTORIO"/*; do
		if [ -f "$ELEMENTO" ]; then
		#Esto se ejecuta sólo si es un archivo
			echo "<li>$(basename "$ELEMENTO")</li>" >> "$INDICE"
		elif [ -d "$ELEMENTO" ]; then
		#Esto se ejecuta sólo si es un directorio
			echo "<li><a href=\"$(basename "$ELEMENTO")/index.html\">$(basename "$ELEMENTO")</a></li>" >> "$INDICE"
			#Llamada recursiva para generar índice de subdirectorio
			generar_indice "$ELEMENTO"
		fi
	done
			
	#Cosas de html (etiqueta de cierre /ul y añadir >> en vez de sobreescribir)
	echo "</ul>" >> "$INDICE"
	echo "Se ha creado $INDICE con el contenido de $DIRECTORIO."
}

#Verificar terminal
if [ "$#" -ne 1 ]; then
	echo "Uso: $0 <ruta-directorio>"
	exit 1
fi

#Verificar si el directorio existe
if [ ! -d "$1" ]; then
	echo "Error: El directorio '$1' no existe."
	exit 1
fi

#Llamamos a la función
generar_indice "$1"
