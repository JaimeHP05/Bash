#!/bin/bash

#Verificar que se ha proporcionado el archivo de acceso
if [ "$#" -ne 2 ]; then
  echo "Por favor, proporciona el archivo de acceso y la opción 'repite-si' o 'repite-no'."
  exit 1
fi

#Verificar que el archivo existe
if [ ! -f "$1" ]; then
  echo "El archivo $1 no existe."
  exit 1
fi

#Verificar que la opción es válida
if [[ "$2" != "repite-si" && "$2" != "repite-no" ]]; then
  echo "Modo no válido. Usa 'repite-si' o 'repite-no'."
  exit 1
fi

# Variables
ARCHIVO="$1"
MODO="$2"

#Ejemplo registro acceso: 
#192.168.1.1 - - [24/Mar/2025:10:00:00 +0000] "GET /index.html HTTP/1.1" 200 1024

#Filtrar líneas con código de respuesta HTTP 200
#Extraer dirección IP y URL solicitada
RESULTADO=$(grep ' 200 ' "$ARCHIVO" | sed -r 's/^([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+).*"(GET|POST) ([^ ]+) HTTP\/[0-9.]+".*/\1 \3/')
# ^([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+) --> Es la IP, números random separados por puntos
#.* Todo el hueco entre medio hasta llegar al GET o POST
#([^ ]+) --> Texto sin espacios
#HTTP\/[0-9.]+" --> Versión del HTTP (por ejemplo HTTP/1.1)
#\1 \3 Imprime la dirección IP y la URL.

#Mostrar las líneas tal cual
if [ "$MODO" == "repite-si" ]; then
  #Enumerar las líneas
  echo "$RESULTADO" | sort
  echo -e "\nNúmero total de accesos: $(echo "$RESULTADO" | wc -l)"

#Contar las ocurrencias y mostrar el formato requerido
elif [ "$MODO" == "repite-no" ]; then
  #Contar las ocurrencias de cada línea
  echo "$RESULTADO" | sort | uniq -c | sed -r 's/^[[:space:]]*([0-9]+) (.*)/\2 --> \1 veces/'
  #Para imprimirlo de forma más fancy, el sed -r sobraría xd
  echo -e "\nNúmero total de accesos únicos: $(echo "$RESULTADO" | wc -l)"
fi
