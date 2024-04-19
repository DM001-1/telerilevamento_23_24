#assegnare un oggetto: dare un nome ad un calcolo: la <- si chiama "assegnazione"
d <- 3+2 # d è "oggetto" 
d
a <- 7+3 
a
#utili per rendere più performante il mio progetto
d+a
#etichetta : ordine di come scrivere il codice a <- 3 + 7 _spazzi fra i caratteri!
mam <- c(2, 4, 7, 10, 15, 20) #insieme di elementi = vettore 
mam
suo <- c(100, 80, 50, 30, 10, 2) 
#plot: generic x e y 
plot(suo, mam)
plot(suo, mam, pch=19) #pch e = con un numero mi permette di cambiare la forma dei punti nel grafico
#porre attenzione che un daltonico possa vedere i colori 
#il giallo è un colore che l'occhio umano percepisce di più quindi usarlo per dove si vuole che cada l'occhio
#ATTENZIONE: prima della funzione spazio, dopo la virgola spazio, dopo la funzione nnt spazio
plot(suo, mam, pch=19, col="blue") # posso assegnare un colore blu ai puntini
plot(suo, mam, pch=19, col="blue", cex=3) #posso variare la grandezza dei punti attraverso cex
#quando esplode qualcoca noi lo uccidiamo tramite "dev.off()" #uccidi tutte le parti grafiche presenti.
#dopo rifai il plot()
