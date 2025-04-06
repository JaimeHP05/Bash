#!/bin/bash

#Comprobar datos de terminal
if [ -z "$1" ]; then
    echo "Uso correcto: $0 <ruta base de los usuarios>"
    exit 1
fi

#Asignar ruta base de usuarios
BASE_DIR=$1

#Recorrer todos los usuarios del sistema
for usuario in $(ls "$BASE_DIR"); do #Cada elemento de $BASE_DIR se almacena en usuario y termina cuando no queden mas (ls lista los elementos)
    home_dir="$BASE_DIR/$usuario"
    ssh_dir="$home_dir/.ssh" #.ssh es el directorio que tiene las claves
    clave_privada="$ssh_dir/id_rsa" #Clave pública
    escritorio="$home_dir/Desktop" #Es Desktop porque se crea automáticamente, no es mi Escritorio
    archivo_advertencia="$escritorio/advertencia_permisos.txt"

    #Verificar si el directorio .ssh y el archivo id_rsa existen
    if [ -d "$ssh_dir" ] && [ -f "$clave_privada" ]; then #-d directorio / -f fichero
        advertencia_creada=false

        #Verificar los permisos del directorio home del usuario
        if [ "$(stat -c "%a" "$home_dir")" -ne 755 ]; then
        #Propietario -> Lectura - Escritura - Ejecución
        #Grupo/Usuarios -> Lectura - Ejecución
            echo "El directorio home de $usuario no tiene los permisos correctos."
            echo "El directorio home de $usuario no tiene los permisos correctos." > "$archivo_advertencia"
            advertencia_creada=true
        fi

        #Verificar los permisos del directorio .ssh
        if [ "$(stat -c "%a" "$ssh_dir")" -ne 700 ]; then
        #Propietario -> Lectura - Escritura - Ejecución
        #Grupo/Usuarios -> Nada
            echo "El directorio .ssh de $usuario no tiene los permisos correctos."
            if [ "$advertencia_creada" = true ]; then
                echo "El directorio .ssh de $usuario no tiene los permisos correctos." >> "$archivo_advertencia"
            else
                echo "El directorio .ssh de $usuario no tiene los permisos correctos." > "$archivo_advertencia"
                advertencia_creada=true
            fi
        fi

        #Verificar los permisos del archivo id_rsa
        if [ "$(stat -c "%a" "$clave_privada")" -ne 600 ]; then
        #Propietario -> Lectura - Escritura
        #Grupo/Usuarios -> Nada
            echo "El archivo id_rsa de $usuario no tiene los permisos correctos."
            if [ "$advertencia_creada" = true ]; then
                echo "El archivo id_rsa de $usuario no tiene los permisos correctos." >> "$archivo_advertencia"
            else
                echo "El archivo id_rsa de $usuario no tiene los permisos correctos." > "$archivo_advertencia"
                advertencia_creada=true
            fi
        fi

        #Mostrar mensaje si se ha creado la advertencia
        if [ "$advertencia_creada" = true ]; then
            echo "Se ha creado un archivo de advertencia en el escritorio de $usuario."
        fi
    fi
done
