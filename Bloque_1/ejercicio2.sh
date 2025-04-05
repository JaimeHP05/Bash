#!/bin/bash

#Verificar que se ha proporcionado los cuatro argumentos
if [ "$#" -ne 4 ]; then
	echo "Uso correcto: $0 <directorio a copiar> <directorio almacén> <comprimir=0 / archivar=1> <sobreescribir=0 / no=1>" #$0 es el nombre del archivo "./ej.sh"
	exit 1 #1 para errores, 0 para correctos
fi

DIRECTORIO_ORIGINAL=$1
DIRECTORIO_COPIA=$2
COMPRIMIR_o_ARCHIVAR=$3
SOBREESCRIBIR=$4

#Verificar que el directorio existe, y si no, lo creamos
if [ ! -d "$DIRECTORIO_COPIA" ]; then #! es para NO, -d es para ver si es un directorio
	mkdir -p "$DIRECTORIO_COPIA"
fi

DIRECTORIO=$(basename "$DIRECTORIO_ORIGINAL") #basename coge el directorio actual y no cosas extra como de dónde viene (jaime/Escritorio/...), ni los /
USUARIO=$USER
FECHA=$(date +%Y%m%d)
#Mírate el man de date que es infinito

#Comprobar si se tiene que comprimir o archivar
if [ "$COMPRIMIR_o_ARCHIVAR" -eq 1 ]; then
	echo "Has seleccionado: Archivar"
	NOMBRE_ARCHIVO="${DIRECTORIO}_${USUARIO}_${FECHA}.tar"
	tar -cvf $NOMBRE_ARCHIVO $DIRECTORIO_ORIGINAL #c crea el nuevo archivo
else
	echo "Has seleccionado: Comprimir"
	NOMBRE_ARCHIVO="${DIRECTORIO}_${USUARIO}_${FECHA}.tar.gz"
	tar -czvf $NOMBRE_ARCHIVO $DIRECTORIO_ORIGINAL #z lo comprime con gzip
fi
RUTA_ARCHIVO="$DIRECTORIO_COPIA/$NOMBRE_ARCHIVO"

#Si queremos sobreescribir, comprobamos si el archivo ya existe, si lo hace, hacemos cuerpo tierra
if [ -f $RUTA_ARCHIVO ] && [ $SOBREESCRIBIR -eq 0 ]; then
	echo "Este archivo ya existe y no lo podemos sobreescribir."
	exit 1
fi

if [ $COMPRIMIR_o_ARCHIVAR -eq 1 ]; then
	echo "Archivando..."
	#-C cambia el directorio para no meter rutas completas
	tar -cvf "$RUTA_ARCHIVO" "$DIRECTORIO_ORIGINAL"
else
	echo "Comprimiendo..."
	tar -czvf "$RUTA_ARCHIVO" "$DIRECTORIO_ORIGINAL"
fi

echo "¡Completado!"
