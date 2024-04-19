library(imageRy)
library(terra)
#visualizza elenco di file
im.list()
#importa immagine e nominala m1992
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
# Che strato è il NIR? Il NIR è rosso poiché la vegetazione è rossa
# più il rosso è scuro più la vegetazione è sana
# band 1 = nir = R
# band 2 = red = G
# band 3 = green = B
im.plotRGB(m1992, 1, 2, 3)
#esercizio: metti nir sopra G
im.plotRGB(m1992, 2, 1, 3) #prima posizione = prima banda da utilizzare
#metti nir sopra componente B
im.plotRGB(m1992, 2, 3, 1)
#importa immagine 
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
#metti nir (infrarosso) sopra il componente verde della componente RGB
im.plotRGB(m2006, 2, 1, 3)
#metti nir (infrarosso) sopra il componente blu della componente RGB
im.plotRGB(m2006, 2, 3, 1)
# multiframe
par(mfrow=c(2,3))
im.plotRGB(m1992, 1, 2, 3) # nir on R 1992
im.plotRGB(m1992, 2, 1, 3) # nir on G 1992
im.plotRGB(m1992, 2, 3, 1) # nir on B 1992
im.plotRGB(m2006, 1, 2, 3) # nir on R 2006
im.plotRGB(m2006, 2, 1, 3) # nir on G 2006
im.plotRGB(m2006, 2, 3, 1) # nir on B 2006

#calcolo del DVI (differenza vegetazionale) -> NIR - rosso
dvi1992 = m1992[[1]] - m1992[[2]] 
#alternativa:
# dvi1992 = m1992$matogrosso~2219_lrg_1 - m1992$matogrosso~2219_lrg_2
# creare plot del DVI 
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi1992, col=cl)
#più il rosso è scuro più la vegetazione è sana
#la riflettanza è compresa tra 0 e 255
#quindi l'intervallo dell'immagine DVI è compreso 
#tra -255 e 255, poiché il rosso è compreso tra 0 e 255
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
dvi2006 = m2006[[1]] - m2006[[2]] 
plot(dvi2006, col=cl)
#mettere i plot DVI uno accanto all'altro
par(mfrow=c(1,2))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
dev.off()
dvi_dif = dvi1992 - dvi2006 #errore di estensione diversa
ext(dvi1992)
ext(dvi2006)

cld <- colorRampPalette(c("blue", "white", "red"))(100)
plot(dvi_dif, col = cld)
# maggiore è la differenza, maggiore è la deforestazione
# se la differenza è negativa si ha un aumento della copertura forestale

#comparazione
# Range DVI dvi1992 (8 bit): -255 a 255
# Range NDVI dvi1992 (8 bit): -1 a 1

# Range DVI dvi2006 (16 bit): -65535 a 65535
# Range NDVI dvi2006 (16 bit): -1 a 1

# Pertanto, l’NDVI può essere utilizzato per confrontare 
# immagini con una diversa risoluzione radiometrica


# NDVI ----
# NDVI = Indice di vegetazione della differenza normalizzata

#Calcolare NDVI per dvi1992
ndvi1992 = dvi1992 / (m1992[[1]] + m1992[[2]])  # standardizazione
plot(ndvi1992, col = cl) 
#calcolo NDVI per dvi2006
ndvi2006 = dvi2006 / (m2006[[1]] + m2006[[2]])
plot(ndvi2006, col = cl)

#calcolo la differenza di NDVI 
ndvi_dif = ndvi1992 - ndvi2006
plot(ndvi_dif, col = cld)

#comparazione dei NDVI
par(mfrow = c(1,2))
plot(ndvi1992, col = cl, main = "1992")
plot(ndvi2006, col = cl, main = "2006")
#Dove la differenza è positiva, l’NDVI è diminuito
