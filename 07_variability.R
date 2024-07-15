# VARIABILITY

# Load the required packages
library(raster)
library(ggplot2)
library(patchwork)
library(viridis)
install.packages("tidyr")
library(tidyr)

# Directory in Windows
setwd("C:/lab/data")

#scarica immagine da Copernico Sentinella 2 https://browser.dataspace.copernicus.eu/?zoom=11&lat=45.36638&lng=12.49832&themeId=DEFAULT-THEME&visualizationUrl=U2FsdGVkX1%2FyB2npWJseasQuKOJH6rxes6VysldjAh30quN8IW7XapNOenRxUeXiHTMFQZWNfIAV9pbrI%2Fo261bWHk14yX8vEA6%2B%2F2oWTUJ22HzvnP2lgEBhZ0p3ofyJ&datasetId=S2_L2A_CDAS&fromTime=2023-02-07T00%3A00%3A00.000Z&toTime=2023-02-07T23%3A59%3A59.999Z&layerId=1_TRUE_COLOR&demSource3D=%22MAPZEN%22&cloudCoverage=10&dateMode=SINGLE
#delta del po

Po <- brick("delta_del_po_2020.png")
ncell(Po) #grandezza dell'immagine

#plot dell'immagine
plot(Po)
plotRGB(Po, 1, 2, 3, stretch = "Lin")

#infrarossi
plotRGB(Po, 2, 1, 3, stretch= "Lin")
#calcolare la variabilità di NIR
#Calcola i valori focali per l'intorno delle celle focali utilizzando una matrice di pesi
nir <- Po[[1]]
mean3 <- focal(nir, matrix(1/9, 3, 3), fun = mean)
plot(mean3)
sd3 <- focal(nir, matrix(1/9, 3, 3), fun = sd)
plot(sd3)
#creiamo il dataframe
sd3_d <- as.data.frame(sd3, xy = T)
#creiamo plot del dataframe appena creato
ggplot() +
  geom_raster(sd3_d,
              mapping = aes(x = x, y = y, fill = layer))
#usiamo viridis
ggplot() +
  geom_raster(sd3_d,
              mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis()
# cividis
p1 <- ggplot() +
  geom_raster(sd3_d,
              mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "cividis")
# magma 
ggplot() +
  geom_raster(sd3_d,
              mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "magma")
#inseriamo un titolo
p2 <- ggplot() +
  geom_raster(sd3_d,
              mapping = aes(x = x, y = y, fill = layer))+
  scale_fill_viridis(option = "magma") +
  ggtitle("Deviazione standard tramite la scala dei colori del magma")
#uniamo i due plot
p1 + p2

#Multiframe con patchwork
# viridis
p1 <- ggplot() +
  geom_raster(sd3_d,
              mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis() +
  ggtitle("Deviazione standard tramite la scala dei colori viridis")
# inferno
p2 <- ggplot() +
  geom_raster(sd3_d,
              mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "inferno") +
  ggtitle("Deviazione standard tramite la scala dei colori dell'inferno")
p1 + p2
