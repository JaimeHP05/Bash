# Prácticas de Bash

Este repositorio contiene los ejercicios de Bash que voy realizando en la asignatura Programación y Administración de Sistemas. Cada carpeta representa una práctica diferente, con su respectiva descripción y ejercicios.

## Contenido

- **Prácticas:** Cada práctica está organizada en carpetas numeradas o con nombres descriptivos, para facilitar la navegación y el seguimiento de los ejercicios.
  
- **Ejercicios:** Scripts de Bash interesantes que demuestran los conceptos aprendidos en cada sesión.
  
- **Notas:** Comentarios que explican el funcionamiento de cada script y los comandos utilizados. [Forman parte de los ejercicios]

- **Ficheros Complementarios:** Algunos ejercicios requerirán de estos archivos para funcionar correctamente.

## Cómo usar este repositorio

1. **Clonarlo:**  
   Puedes clonar este repositorio en tu máquina local utilizando el siguiente comando:
   ```bash
   git clone https://github.com/JaimeHP05/Bash.git

2. **Navegar por las prácticas:**
  Revisa las carpetas o archivos de las prácticas para encontrar el ejercicio que necesites.

3. **Ejecutar los scripts:**
  Abre una terminal, navega hasta la carpeta correspondiente y ejecuta el script de Bash:
    ```bash
    cd Bash
    
    cd Bloque_X
    
    chmod u+x nombre_ejercicio.sh
    
    ./nombre_ejercicio.sh
    

## Bloque 1

- **Ejercicio 1:**
  
   Lee una carpeta que tiene un puñado de archivos con la asistencia de cada alumno a clase. A continuación, muestra cuántas personas fueron a cada clase. Este código se puede cambiar a muchas extensiones, tales como mostrar cuántas veces ha venido un estudiante a clase.
  

- **Ejercicio 2:**
  
   Copia un directorio, permitiendo elegir entre archivarlo (.tar) o comprimirlo (.tar.gz). Verifica argumentos, crea el directorio de destino si no existe, genera un nombre de archivo con fecha y usuario, y controla si se puede sobrescribir. Finalmente, realiza la operación seleccionada y guarda el archivo en el directorio indicado.


- **Ejercicio 3:**
  
   Verifica los permisos de los directorios y archivos relacionados con las claves SSH de los usuarios en un sistema. Si detecta problemas, genera un archivo de advertencia en el escritorio del usuario afectado.

- **Ejercicio 4:**

  Genera una cadena aleatoria de una longitud específica y de un tipo determinado (alfa, num o alfanum) utilizando /dev/urandom para obtener caracteres aleatorios. Verifica los argumentos de entrada y solicita el tipo si no se proporciona.

- **Ejercicio 5:**

  Recorre un directorio dado, lista todos los archivos y muestra información detallada de cada uno (nombre, ruta completa, fecha de modificación, tamaño y permisos). Finalmente, ordena los resultados por fecha de modificación en orden ascendente.

- **Ejercicio 6:**
  
  Genera un archivo index.html en un directorio, que contiene una lista en formato HTML de todos los archivos y subdirectorios dentro de ese directorio. Para los subdirectorios, crea enlaces recursivos a sus propios índices HTML. Verifica que el directorio exista antes de ejecutarse y muestra mensajes de confirmación al crear cada índice.

- **Ficheros Complementarios:**
  
  Ficheros_Ejercicio1 --> Puedes añadir todos los archivos de texto que quieras, pero deben cumplir las siguientes condiciones:
    - Cada línea sólo puede incluir un 1 o un 0
    - Todos los alumnos deben tener el mismo número de líneas (sesiones en las que ha habido esa clase)
    - El fichero que se muestra en su carpeta es sólo un ejemplo, puedes añadir todos los que quieras.

  generar_ficheros_ejercicio3.sh --> Es un programa que genera los usuarios sobre los que se va a realizar el ejercicio de la práctica. Este programa no ha sido creado por mí, formaba parte del enunciado de la tarea y había que aplicarlo de igual forma.

  
## Bloque 2

- **Ejercicio 1:**
  
   Genera un archivo index.html en un directorio dado, que contiene una lista en formato HTML de todos los archivos y subdirectorios dentro de ese directorio. Para los subdirectorios, crea enlaces recursivos a sus propios índices HTML. Verifica que el directorio exista antes de ejecutarse y muestra mensajes de confirmación al crear cada índice.
  
- **Ejercicio 2:**

  Verifica que un archivo .txt exista y sea válido. Luego, procesa su contenido utilizando sed para formatear campos como Título, Autor, Año, Precio y Género, reorganizándolos en un formato más legible.

- **Ejercicio 3:**

   Procesa un archivo de registros de acceso web, filtra las solicitudes con código HTTP 200, y extrae las direcciones IP y URLs solicitadas. Según la opción proporcionada (repite-si o repite-no), muestra todas las solicitudes o un conteo único de accesos, junto con el total de accesos.

- **Ejercicio 4:**

  Procesa el archivo `/etc/passwd` para extraer información específica de los usuarios del sistema. Muestra usuarios cuyo nombre empieza con "l", usuarios con shells válidos, UID de usuarios cuyo directorio home no está en `/home`, usuarios con GID mayor a 1000, y usuarios con una coma en su campo GECOS.

- **Ejercicio 5:**

  Analiza las interfaces de red disponibles en el sistema y muestra información como la dirección IP, broadcast, máscara de red (en bits), si el cable está conectado, y las velocidades soportadas y anunciadas. Utiliza herramientas como ifconfig y ethtool para obtener los datos.

- **Ejercicio 6:**

  Analiza los últimos 20 comandos del historial (~/.bash_history), cuenta cuántas veces se ejecutó cada comando y determina el máximo número de argumentos usados con cada uno. Utiliza archivos temporales para procesar los datos y muestra un resumen por comando antes de eliminar los archivos temporales.

- **Ficheros Complementarios:**
  
  libros.txt --> Un fichero de texto con libros escritos según el formato que lee el ejercicio, puedes crear todos los libros extras que quieras. Este archivo no ha sido creado por mí.
  
  access.log --> Es el archivo que lee el ejercicio 3 para sacar la información de los registros. Este archivo no ha sido creado por mí.
