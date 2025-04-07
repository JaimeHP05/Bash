#!/bin/bash

#Comprobar la terminal
if [[ "$#" -ne 2 && "$#" -ne 1 ]]; then
	echo "Uso: $0 <longitud cadena> (tipo de cadena)"
	echo "Tipo de cadena: alfa - num - alfanum"
	exit 1
fi

TIPO=$2
LONGITUD=$1

#Comprobar si se ha incluido el tipo
if [ "$#" -eq 1 ]; then
	echo "Introduzca el tipo de cadena: "
	read TIPO
	if [[ "$TIPO" != "alfa" || "$TIPO" != "num" || "$TIPO" != "alfanum" ]]; then
		echo "Tipo inválido. Tipo de cadena: alfa - num - alfanum"
		exit 1
	fi
fi

#Tipo de cadena -> alfa
if [ "$TIPO" == "alfa" ]; then
	echo "Cadena generada: $(cat /dev/urandom | tr -dc 'a-zA-Z' | head -c "$LONGITUD")"
#Tipo de cadena -> num
elif [ "$TIPO" == "num" ]; then
	echo "Cadena generada: $(cat /dev/urandom | tr -dc '0-9' | head -c "$LONGITUD")"
#Tipo de cadena -> alfanum
elif [ "$TIPO" == "alfanum" ]; then
	echo "Cadena generada: $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c "$LONGITUD")"
#Tipo de cadena -> ?????
else
	echo "Tipo inválido. Tipo de cadena: alfa - num - alfanum"
	exit 1
fi

#/dev/urandom genera números aleatorios
#tr -dc filtra los caracteres de /dev/urandom para que sólo tengan los indicados
#head -c limita la cabeza (el máximo), osea, la longitud
