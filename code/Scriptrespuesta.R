##################################Angela Segura Cod. 201619956   R version 4.1.3 ############################################

##Taller Pset_3####

###Crear directorio de trabajo##
dir.create("code") #Creamos carpeta llamada code, donde guardaremos el script
dir.create("output") #Creamos la carpeta output para los datos procesados
list.files() ## Revisamos con que carpetas estamos trabajando#
##El script lo guardamos manualmente en la carpeta de code con el nombre Scriptrespuesta##

###Instalar librerias##
require(pacman) 
p_load(tidyverse, rio,skimr,tmaptools, sf, leaflet, rvest, xml2, osmdata, ggsn) # Llamamos las librerias  necesarias para el taller##

