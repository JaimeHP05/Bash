#!/bin/bash

#Archivo temporal
TEMP_FILE=$(mktemp)
TEMP_COMANDOS=$(mktemp)

#Volcar los últimos 20 comandos del historial al archivo temporal
cat ~/.bash_history | tail -n 20 > "$TEMP_FILE"

#Leer cada línea del archivo temporal
while read -r LINEA; do
	#Extraer el comando (la primera palabra de la línea)
	COMANDO=$(echo "$LINEA" | sed 's/^\([^ ]*\).*/\1/')
    
	# Si el comando está vacío, continuar con la siguiente línea
	if [ -z "$COMANDO" ]; then
		continue
	fi
	#Continue a la siguiente iteración del bucle
    
	#Extraer los argumentos (todo después del comando)
	ARGS=$(echo "$LINEA" | sed 's/^[^ ]* *//')
    
	#Contar el número de argumentos (separados por espacios)
	NUM_ARGS=$(echo "$ARGS" | wc -w)
	#wc -w cuenta el número de palabras
    
	#Guardar el comando y número de argumentos en el archivo temporal
	echo "$COMANDO $NUM_ARGS" >> "$TEMP_COMANDOS"
done < "$TEMP_FILE" #Coge el archivo para el siguiente bucle

#Mostrar los resultados
for COMANDO in $(cut -d' ' -f1 "$TEMP_COMANDOS" | sort | uniq); do
#El cut -d' ' extrae columnas de texto delimitadas por un espacio
#Como TEMP_COMANDO los muestra como "ls 1" "cd 2" "ls 3" y así, al poner f1, obtenemos sólo la primera columna, es decir, el comando.
	COUNT=$(grep -c "^$COMANDO " "$TEMP_COMANDOS")
	MAX_ARGS=$(grep "^$COMANDO " "$TEMP_COMANDOS" | cut -d' ' -f2 | sort -nr | head -n 1)
	echo "Comando: $COMANDO"
	echo "-> Veces ejecutado: $COUNT"
	echo "-> Máximo número de argumentos: $MAX_ARGS"
done

# Eliminar el archivo temporal
rm "$TEMP_FILE" "$TEMP_COMANDOS"
