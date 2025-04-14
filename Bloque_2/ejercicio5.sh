#!/bin/bash

#Escribe ifconfig en terminal para comprobar cómo está estructura.

#Obtener las interfaces de red disponibles
INTERFACES=$(ifconfig -a | grep -o '^[^ ]*' | tr -d ':')
#ifconfig -a lista las interfaces de red disponibles (activa e inactiva)
#grep -o coge la primera palabra de cada línea
#tr -d Elimina los :

#Iterar sobre cada interfaz
for INTERFAZ in $INTERFACES; do
	echo "Interfaz: $INTERFAZ"

	#1. Dirección IP
	IP=$(ifconfig "$INTERFAZ" | grep -o 'inet [0-9.]*' | sed 's/inet //')
	echo "-> Dirección IP: ${IP:-No disponible}"

	#2.1. Dirección de Broadcast
	BROADCAST=$(ifconfig "$INTERFAZ" | grep -o 'broadcast [0-9.]*' | sed 's/broadcast //')
	echo "-> Broadcast: ${BROADCAST:-No disponible}"
	#2.2. Máscara de red
	NETMASK=$(ifconfig "$INTERFAZ" | grep -o 'netmask [0-9.]*' | sed 's/netmask //')
	if [ -n "$NETMASK" ]; then
		BITS=0
		for octet in $(echo "$NETMASK" | tr '.' ' '); do
		#octet lo transforma en lista de octetos, y tr reemplaza puntos por espacios
			BITS=$((BITS + $(echo "obase=2; ibase=10; $octet" | bc | grep -o '1' | wc -l)))
			# echo "obase=2; ibase=10; $octet" | bc  --> Esto es la calculadora
		done
		echo "-> Máscara de red: ${BITS} bits"
		else
			echo "-> Máscara de red: No disponible"
	fi

	#3. Comprobar si el cable está conectado
	CABLE=$(ethtool "$INTERFAZ" 2>/dev/null | grep 'Link detected' | sed -E 's/.*Link detected: (yes|no).*/\1/' | sed 's/yes/sí/' | tr -d '\n')
	#El 2>/dev/null redirige los errores a un agujero negro
	echo "-> Cable conectado: ${CABLE:-No disponible}"
	#${variable:-valor} imprime valor si variable está vacía
	
	#Ejemplo de lo que imprime un ethtool:
	#Settings for eth0:
    	#Supported ports: [ TP ]
    	#Supported link modes:   10baseT/Half 10baseT/Full
    				#100baseT/Half 100baseT/Full
    				#1000baseT/Full
    	#Link detected: yes

	#4. Velocidades soportadas y anunciadas como disponibles
	SOPORTADAS=$(ethtool "$INTERFAZ" 2>/dev/null | grep -A2 'Supported link modes:' | tr -s ' ' | tr -d '\n' | sed -e 's/Supported link modes: //')
	#grep -A2 imprime además las dos siguientes líneas
	ANUNCIADAS=$(ethtool "$INTERFAZ" 2>/dev/null | grep -A2 'Advertised link modes:' | tr -s ' ' | tr -d '\n' | sed -e 's/Advertised link modes: //')
	echo "-> Velocidades soportadas: ${SOPORTADAS:-No disponible}"
	echo "-> Velocidades anunciadas como disponibles: ${ANUNCIADAS:-No disponible}"
done
