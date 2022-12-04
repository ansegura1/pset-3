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

#########################################1.Regresiones#######################################################

####################################################2. Datos espaciales######################################################

## 2.1  Descargar los datos##

available_features() %>% head(100)
available_tags("amenity") %>% head(20)
opq(bbox = getbb("Armenia Colombia")) # Vamos a obtener la caja de coordenada que contiene el polÃ­gono de Armenia##
## Datos de los restaurantes en Armenia
osm = opq(bbox = getbb("Armenia Colombia")) %>%
  add_osm_feature(key="amenity" , value="restaurant") #En internet encontramos cÃ³mo encontrar los datos de los restaurantes en openstreetmap. (https://wiki.openstreetmap.org/wiki/Tag:amenity%3Drestaurant)
class(osm)
osm_sf = osm %>% osmdata_sf() ## extraer Simple Features Collection
osm_sf
restaurant = osm_sf$osm_points %>% select(osm_id,amenity)#Obtenemos el objeto 


## Parques de Armenia
parques <- opq(bbox = getbb("Armenia Colombia")) %>%
  add_osm_feature(key = "leisure", value = "park") %>%
  osmdata_sf() %>% .$osm_polygons %>% select(osm_id,name)


## 2.2 Visualizar  los datos##

#restaurantes
leaflet() %>% addTiles() %>% addCircles(data=restaurant , col="red")
#parques
leaflet() %>% addTiles() %>% addPolygons(data=parques, col="blue")


#2.3 Geocodificar direcciones## 

#Museo del oro Qumbaya
MOQ <- geocode_OSM("Museo del Oro Quimbaya, Armenia", as.sf=T) 
#Pintar el punto del museo del Oro Quimbaya
leaflet() %>% addTiles() %>% addCircleMarkers(data=MOQ , col="yellow")

#2.4 Exportar mapa##


###################################3. Web-scraping y procesamiento de texto#####################################################

library(rvest)
browseURL("https://es.wikipedia.org/wiki/Departamentos_de_Colombia") #Para el punto 3 vamos a usar la pagina de departamentos de Colombia 
vignette("rvest")

##3.1 Crear objeto html##
my_url = "https://es.wikipedia.org/wiki/Departamentos_de_Colombia" #Guardo la url de la pagina
browseURL(my_url)

my_html = read_html(my_url)#Guardo la Html
class(my_html) ## verificar que quedÃ³ guardada   como un objeto xml_document#

##3.2  extraer el tÃ­tulo de la pÃ¡gina##

my_html %>% html_nodes(xpath = '//*[@id="firstHeading"]/span') %>% #En la pag le damos inspeccionar al elemento y posteriormente le damos copiar Xpath
  html_text() #Visualizamos el elemento extraido
#3.4 Extraer los parrafos del documento (elementos con etiqueta p) y generar nube de palabras##

Parrafos<- my_html %>% html_elements("p") %>% html_text() ### Ver los textos que estan con la etiqueta p
Parrafos



