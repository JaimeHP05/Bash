#!/bin/bash

#Verificar que se ha proporcionado un argumento
if [ "$#" -ne 1 ]; then
	echo "Uso correcto: $0 <directorio>" #$0 es el nombre del archivo "./ej.sh"
	exit 1 #1 para errores, 0 para correctos
fi

DIRECTORIO=$1 #$1 es el archivo que hayamos incluido al ejecutar el programa

# Verificar que el directorio existe
if [ ! -d "$DIRECTORIO" ]; then #! es para NO, -d es para ver si es un directorio
	echo "Error: El directorio $DIRECTORIO no existe."
	exit 1
fi

#Inicializar un array para la suma de asistencias por sesión
declare -a asistencias

#Leer los ficheros del directorio
for fichero in "$DIRECTORIO"/*; do
	# Verificar que es un fichero regular
	if [ -f "$fichero" ]; then
		i=0
		while IFS= read -r linea; do #IFS quita espacios raros, úsalo para los read
			#Control de errores [Línea debe ser 0 o 1]
			if [[ "$linea" != "0" && "$linea" != "1" ]]; then #[[ ]] es necesario cuando hay && o ||
				echo "Error: Una línea en $fichero no es ni 0 ni 1."
				exit 1
			fi
			#Aumentar el valor de asistencia
			asistencias[$i]=$((asistencias[$i] + linea)) #Se usan dos paréntesis porque son operaciones (también se aplicaría a un < >)
			i=$((i+1))
		done < "$fichero"
		
		#Verificar que todos los ficheros tienen el mismo número de líneas
		if [ -z "$num_lineas" ]; then 
		num_lineas=$i
		elif [ "$num_lineas" -ne "$i" ]; then
			echo "Error: El fichero $fichero tiene un número diferente de líneas."
			exit 1
		fi
	fi
done

#Mostrar el número de asistentes por sesión
for ((i = 0; i < num_lineas; i++)); do
    echo "Sesión $((i + 1)): ${asistencias[$i]} asistentes" #Se pone {} porque es un array
