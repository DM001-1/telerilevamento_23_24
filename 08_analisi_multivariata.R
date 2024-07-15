#analisi dei componenti principali (PCA) è una tecnica per ridurre la dimensionalità 
#dei dati e migliorare l'interpretazione delle immagini satellitari

library(imageRy)
library(terra)
library(viridis)
im.list()

#importazione data
b2 <- im.import("sentinel.dolomites.b2.tif") # blue
b3 <- im.import("sentinel.dolomites.b3.tif") # green
b4 <- im.import("sentinel.dolomites.b4.tif") # red
b8 <- im.import("sentinel.dolomites.b8.tif") # nir

sentdo <- c(b2, b3, b4, b8)

im.plotRGB(sentdo, r=4, g=3, b=2)
im.plotRGB(sentdo, r=3, g=4, b=2)

pairs(sentdo)

#esercizi
sen <- brick ("delta_del_po_2024.png")
sen
ncell(sen)  # the size
plot(sen)  # the plot
#Per raggruppare le bande rimuoviamo l'ultima (è vuota)
sen2 <- stack(sen[[1]], sen[[2]], sen[[3]])
plot(sen2)
#Confronto a coppie
pairs(sen2)
#PCA (analisi delle componenti principali)
install.packages ("SampleRandom")
sample <- sampleRandom (sen2, 10000)
pca <- prcomp(sample)
#Spiegazione della varianza
summary(pca)
#La prima componente è quella con la maggiore variabilità
#Correlazione con le bande originali
pca
#Mappa pc: visualizziamo partendo dall'analisi della PCA
pci <- predict (sen2, pca, index = c(1:3)) # or c(1:2)
plot(pci)
plot(pci[[1]])
#plot 
pcid <- as.data.frame(pci[[1]], xy = T)  # forzare in un dataframe
pcid

ggplot() +
  geom_raster(pcid,
              mapping = aes(x = x, y = y, fill = PC1)) +
  scale_fill_viridis()  # direzione = -1 in caso di rampa di colore inversa
# magma
ggplot() +
  geom_raster(pcid,
              mapping = aes(x = x, y = y, fill = PC1)) +
  scale_fill_viridis(option = "magma")

# inferno 
ggplot() +
  geom_raster(pcid,
              mapping = aes(x = x,y = y, fill = PC1)) +
  scale_fill_viridis(option = "inferno")
#focus sulla deviazione standard
sd3 <- focal (pci[[1]], matrix(1/9, 3, 3), fun = sd)
sd3d <- as.data.frame(sd3, xy = T)

# Plot
ggplot() +
  geom_raster(sd3d,
              mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis()
#NB:
# velocizzare le analisi
# celle aggregate: ricampionamento
senres <- aggregate(sen, fact = 10)
# quindi ripetere l'analisi PCA
