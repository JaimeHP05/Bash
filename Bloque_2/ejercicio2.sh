#!/bin/bash

#Verificar que se ha proporcionado un argumento
if [ "$#" -ne 1 ]; then
	echo "Uso correcto: $0 <nombre_fichero>" #$0 es el nombre del archivo "./ej.sh"
	exit 1 #1 para errores, 0 para correctos
fi

FICHERO=$1

if [ ! -f "$FICHERO" ]; then
	echo "El fichero '$FICHERO' no existe."
	exit 1
fi

if [[ "$FICHERO" != *.txt ]]; then
	echo "Se esperaba un fichero de tipo .txt"
	exit 1
fi

# Procesar el archivo

# Si quieres quitarle los espacios y tal:
# /^[[:space:]]*$/d;                 # Eliminar líneas vacías (^ Inicio)($ Final)
sed -r 's/^Título: (.*)/Título: \1/; s/^Autor: (.*)/|->Autor: \1/; s/^Año: (.*)/|->Año: \1/; s/^Precio: (.*)/|->Precio: \1/; s/^\[Género: (.*)\]/|->Género: \1/;' "$FICHERO"
# | tee peliculas_formateadas.txt --> Es un error del enunciado y en verdad no lo pide.
#Aquí reemplaza el (.*) con el \1, porque s/.../.../ sustituye uno con otro
