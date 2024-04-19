install.packages("devtools")
library("devtools")
install_github("ducciorocchini/imageRy")
library("imageRy")
install.packages("terra")
library("terra")
im.list()
b2 <- im.import("sentinel.dolomites.b2.tif") #all'immagine importata diamo il nome b2
clg <- colorRampPalette(c("black", "grey", "light grey"))(3) 
#diamo una scala di colori chiamata clg 3 tonalita di grigi
plot1 <- plot(b2, col=clg) #crea un plot con l'immagine b2 con i colori clg
clg <- colorRampPalette(c("black", "grey", "light grey"))(100)
#diamo una scala di colori chiamata clg 100 tonalita di grigi
plot2 <- plot(b2, col=clg)
clcyan <- colorRampPalette(c("magenta", "cyan4", "cyan"))(3)
plot3 <- plot(b2, col=clcyan) #abbiamo cambiato la scala di colori
clcyan <- colorRampPalette(c("magenta", "cyan4", "cyan"))(100) 
#abbiamo aumentato le tonalita di colori da 3 a 100
plot4 <- plot(b2, col=clcyan)
clch <- colorRampPalette(c("magenta", "cyan4", "cyan", "chartreuse"))(100)
#abbiamo aggiunto una tonalità
plot5 <- plot(b2, col=clch)
#importo le bande aggiuntive
b3 <- im.import("sentinel.dolomites.b3.tif")
plot6 <- plot(b3, col=clch)
b4 <- im.import("sentinel.dolomites.b4.tif")
plot7 <- plot(b4, col=clch)
b8 <- im.import("sentinel.dolomites.b8.tif")
plot8 <- plot(b8, col=clch)
#unisco su un unica schermata i plot appena creati/importati 
par(mfrow=c(2,2))
plot(b2, col=clch)
plot(b3, col=clch)
plot(b4, col=clch)
plot(b8, col=clch)
#esercizio: tracciare i 4 plot su un unica riga
par(mfrow=c(1,4))
plot(b2, col=clch)
plot(b3, col=clch)
plot(b4, col=clch)
plot(b8, col=clch)
#creiamo un immagine satellitare
stacksent <- c(b2, b3, b4, b8)
plot9 <- plot(stacksent) #, col=clch)
plot10 <- plot(stacksent[[4]])
plot11 <- plot(stacksent[[4]], col=clch)
# im.plotRGB(stacksent, r=3, g=2, b=1)
im.plotRGB(stacksent, 3, 2, 1) 
im.plotRGB(stacksent, 4, 2, 1)
# Esercizio: crea una trama con le immagini a colori naturali e quelle a falsi colori una accanto all'altra
# Che strato è il NIR? Il NIR è rosso poiché la vegetazione è rossa
# più il rosso è scuro più la vegetazione è sana
# NIR = 1
# red = 2
# green = 3

par(mfrow=c(1,2))
im.plotRGB(stacksent, 3, 2, 1)
im.plotRGB(stacksent, 4, 2, 1)
dev.off() #per riuscire a togliere qualunque immagine
im.plotRGB(stacksent, 4, 3, 2) #sovrapporre i plot nir e rosso
#
par(mfrow=c(1,3))
im.plotRGB(stacksent, 3, 2, 1)
im.plotRGB(stacksent, 4, 2, 1)
im.plotRGB(stacksent, 4, 3, 2)

dev.off()

# nir sopra il verde
im.plotRGB(stacksent, 3, 4, 2)
# nir sopra il blu
im.plotRGB(stacksent, 3, 2, 4)
#esercizio: mettere assieme le 4 immagini 
par(mfrow=c(2,2))
im.plotRGB(stacksent, 3, 2, 1) # natural colors
im.plotRGB(stacksent, 4, 2, 1) # nir on red
im.plotRGB(stacksent, 3, 4, 2) # nir on green
im.plotRGB(stacksent, 3, 2, 4) # nir on blue
#corelazione delle 4 immagini
pairs(stacksent)
