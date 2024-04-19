#CLASSIFICAZIONE DEI DATI REMOTOSENSIBILI
install.packages("ggplot2")
install.packages("patchwork")
library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)
library(raster) 
# per importare immagine dalla cartella
# my <- break(nome immagine raster .jpg - prima rendere la cartella di lavoro diretta)
# sun <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
# plotRGB(sun, 1, 2, 3, stretch = "lin")
# plotRGB(sun, 1, 2, 3, stretch = "hist")
# sun
im.list()
#immagini del sole
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
#classifica l'immagine
sunc <- im.classify(sun, num_clusters=3) #classificazione dell'immagine in tre colori
# importo Mato grosso imagine
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# classifico imagine in due colori
m1992c <- im.classify(m1992, num_clusters=2)

# 1992
# class 1 = human
# class 2 = forest

m2006c <- im.classify(m2006, num_clusters=2)

# 2006
# class 1 = human
# class 2 = forest

#frequenza dell'immagine classificata
f1992 <- freq(m1992c)
f2006 <- freq(m2006c)

#faccio una proporzione
tot1992 <- ncell(m1992c) #il totale di 1992 è il numero di celle dellimmagine classificata
prop1992 = f1992 / tot1992 #la proporzione è la frequenza diviso il totale
#trovo la percentuale
perc1992 = prop1992 * 100
perc1992
# 17% human, 83% forest

#stesa cosa si ripete per m2006
tot2006 <- ncell(m2006c)
prop2006 = f2006 / tot2006
prop2006
perc2006 = prop2006 * 100
perc2006
# 45% umani e 54% foresta

#creiamo un dataframe
class <- c("forest", "human")
p1992 <- c(83, 17)
p2006 <- c(45, 55)
tabout <- data.frame(class, p1992, p2006)
tabout
#creiamo un plot, uno per periodo
ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white")
ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white")
#inseriamo le patchwork
p1 <- ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white")
p1 + p2
#aggiungo ylim(c(0, 100)) per variare scala hai grafici
p1 <- ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2


#otteniamo valore immagine del sole
sun <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
plotRGB(sun, 1, 2, 3, stretch = "lin")
plotRGB(sun, 1, 2, 3, stretch = "hist")
sun
#restituisce tutti i valori per un numero di righe di un oggetto Raster
single_nr <- getValues(sun)
single_nr
#dall'immagine vengono estratti i vari strati con i var valori 
# della riflettanza di ogni strato

#classificazione
k_cluster <- kmeans(single_nr, centers = 3) #center = al numero di classi/cluster
k_cluster
# clustering, Significa = centroide di un cluster di pixel_Risposta:
#Within cluster sum of squares by cluster:
#[1]  833403941  845269568 1012061965
#(between_SS / total_SS =  84.7 %)
#Available components:
#[1] "cluster"      "centers"      "totss"        "withinss"    
#[5] "tot.withinss" "betweenss"    "size"         "iter"        
#[9] "ifault"

# Imposta i valori su un raster sulla base dell'immagine del sole
sun_class <- setValues(sun[[1]], k_cluster$cluster) #assegnare nuovi valori a un oggetto raster
# dai dati continui a un oggetto raster
# utilizzando il primo strato dell'immagine del sole e il componente cluster di kmeans
# il primo strato è come una scatola da riempire
# Traccia utilizzando una tavolozza di colori
cl <- colorRampPalette(c("yellow", "black", "red"))(100)
plot(sun_class, col = cl)
# classe 1: livello energetico più alto
# classe 2: livello energetico medio
# classe 3: livello energetico più basso

#calcolare la frequenza dei pixel del raster
frequencies <- freq(sun_class)
frequencies
#funzione per calcolare il numero di celle/pixel presenti
tot <- ncell(sun_class)
tot
percentages <- round((frequencies*100)/tot, digits = 5)
percentages
#la colonna "count" sono le frequenze percentuali delle diverse classi

#immagine del gran Canyon
grand_canyon <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
grand_canyon
# red = 1 green = 2 blue = 3
plotRGB(grand_canyon, 1, 2, 3, stretch = "lin")
#Cambia l'allungamento "the stretch" in allungamento dell'istogramma
plotRGB(grand_canyon, 1, 2, 3, stretch = "hist")
#L'immagine è abbastanza grande; ritagliamola!
gc_crop <- crop(grand_canyon, drawExtent(show = TRUE, col ="red"))
#bisogna puntare su immagine
plotRGB(gc_crop, 1, 2, 3, stretch = "lin")

ncell(grand_canyon)
ncell(gc_crop)
#classificazione 
#restituisce tutti i valori per un numero di righe di un oggetto Raster
singlenr1 <- getValues(gc_crop)
singlenr1
kcluster1 <- kmeans(singlenr1, centers = 3) #numero di claster
kcluster1
gcclass <- setValues(gc_crop[[1]], kcluster1$cluster) #assegnamo nuovo valore al raster
cl2 <- colorRampPalette(c('yellow','black','red'))(100)
plot(gcclass, col=cl2) #assegnamo una palet
# class 1: volcanic rocks
# class 2: sandstone
# class 3: conglomerates
frequencies1 <- freq(gcclass)
frequencies1
tot1 <- ncell(gcclass)
percentages1 = frequencies * 100 /  tot
percentages1
#esercizio: classifica nella mappa 4 classi
singlenr_2 <- getValues(gc_crop)
singlenr_2
kcluster_2 <- kmeans(singlenr_2, centers = 4)
kcluster_2
gcclass_2 <- setValues(gc_crop[[1]], kcluster_2$cluster)
cl <- colorRampPalette(c('yellow','black','red', 'blue'))(100)
plot(gcclass_2, col=cl)
frequencies <- freq(gcclass_2)
frequencies
tot <- ncell(gcclass_2)
percentages = frequencies * 100 /  tot
percentages
