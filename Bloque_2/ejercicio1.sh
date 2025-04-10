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

echo -e "\n1) Años de los libros publicados entre 1950 y 2020:"
grep -o 'Año: 19[5-9][0-9]\|Año: 20[0-1][0-9]\|Año: 2020' "$FICHERO" | sed -r 's/Año: //'
#sed -r 's/patrón/reemplazo/g', si no hubiese grep habría que poner g al final

echo -e "\n2) Precios superiores a 20 euros:"
grep -o 'Precio: [2-9][0-9],99€\|Precio: [2-9][1-9],[0-9][0-9]€' "$FICHERO" | sed -r 's/Precio: //'
#grep -o Sólo coge lo especificado

echo -e "\n3) Número de libros por género:"
grep -o '\[Género: .*]' "$FICHERO" | sed -r 's/\[Género: (.*)\]/\1/' | sort | uniq -c
#| sed 's/^\([0-9]\+\) \(.*\)/\2 aparece \1 veces/'  --> Esto es si quieres ser fancy
# \[ porque o si no se confunde mucho (comandos con [ ] y tal)

echo -e "\n4) Palabras de al menos 8 caracteres que empiezan por consonante y terminan por vocal:"
grep -o '\b[^aeiouAEIOU[:space:]][a-zA-Z]\{6,\}[aeiouAEIOU]\b' "$FICHERO"
# Los \b \b indican que empieza y termina la palabra (Si no, corta palabras)
# El ^ es negador y \{6,\} es mínimo 6 y máximo ?

echo -e "\n5) Líneas de autor cuyo nombre o apellido contiene una doble 'l':"
grep -i 'Autor: .*ll' "$FICHERO" | sed -r 's/Autor: //'
# Si pusieses -o se cortaría después de ll

echo -e "\n6) Títulos de libros con más de tres palabras:"
grep -i 'Título: .* .* .*' "$FICHERO"
# | sed -r 's/Título: //'

echo -e "\n7) Títulos de libros cuyo precio termina en ',99€':"
grep -B 3 'Precio: .*99€' "$FICHERO" | grep -i 'Título: '
# | sed -r 's/Título: //'
#grep -B 3 muestra a partir de la línea 3 veces anterior a Precio hasta Precio (Título)
#Luego el grep -i hace que sólo se imprima la línea de Título

echo -e "\n8) Número de libros con año de publicación anterior a 2000:"
grep -o 'Año: [0-1][0-9][0-9][0-9]' "$FICHERO" | wc -l
#wc -l cuenta el número de líneas

echo -e "\n9) Líneas con dos o más palabras con mayúscula consecutivas:"
grep '[A-Z][a-z]\+ [A-Z][a-z]\+' "$FICHERO"
#Si quieres poner + en vez de \+ usa -E

echo -e "\n10) Géneros con una palabra compuesta:"
grep -o '\[Género: [^]]*[-][^]]*\]' "$FICHERO" | sort | uniq
# | sed -r 's/\[Género: (.*)\]/\1/'
#Si quieres que por ejemplo sean - y " ", puedes hacer [- ] en vez de [-]
#uniq -c muestra las veces que se repite, si no, simplemente ordena sin repetir
