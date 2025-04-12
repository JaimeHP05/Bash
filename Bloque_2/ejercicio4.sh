#!/bin/bash

#Escribe cat /etc/passwd en terminal para comprobar
#Ejemplo --> daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
#	     user:contraseña:UID:GID:GECOS:Directorio_Home:shell

echo "1. Usuarios cuyo nombre empieza con la letra 'l':"
grep '^l' /etc/passwd | sed -r 's/:.*//'
#^ es el primer campo, el s/:.* quita lo que hay después de Usuario:fkdjhfjkah

echo -e "\n2. Usuarios con shell válido:" #Diferente de /bin/false o /usr/bin/nologin
grep -vE ':(/bin/false|/usr/bin/nologin)$' /etc/passwd | sed -r 's/:.*//'
#grep -v Muestra lo que no coincide

echo -e "\n3. UID de los usuarios cuyo directorio home no está en /home:"
grep -vE ':/home/' /etc/passwd | sed -r 's/^[^:]*:[^:]*:([^:]*):[^:]*:[^:]*:[^:]*:.*/\1/'
#El \1 coge el ([^:]*) que es el UID

echo -e "\n4. Usuarios con GID mayor que 1000:"
sed -nr '/^[^:]*:[^:]*:[^:]*:([1-9][0-9]{3,}):/s/^([^:]*):.*/\1/p' /etc/passwd
#sed -n hace que sólo imprima lo dicho en p

echo -e "\n5. Usuarios y su UID con una ',' en su campo gecos:"
sed -nr '/^[^:]*:[^:]*:[^:]*:[^:]*:.*,.*/s/^([^:]*):[^:]*:([^:]*):[^:]*:.*/\1 \2/p' /etc/passwd
#xd
#Ver este código es como el mono de Toy Store, sólo me activo cuando veo que hay un paréntesis.