# <img src="http://cdn.onlinewebfonts.com/svg/img_403829.png" width="70px" /> Smart Gas Station



### <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQneNR5549RqlG4fRgDc2db2jif6cqa-yUtkWf9ATx6KPePNw26oQ" width="50px" /> Funzionalità da offrire agli utenti

Il progetto consiste in una *Web Application* che consente ad un utente, dopo essersi registrato, di localizzare le **stazioni di rifornimento più economiche** **vicine a lui** che dispongono di determinati carburanti. (es: GPL, metano, diesel). 

La **registrazione**, che può avvenire in **locale** oppure tramite **Facebook/Twitter**, consente all'utente di inserire le proprie informazioni e le proprie preferenze, diventando parte integrante della piattaforma. L'utente normale può usare la maggior parte delle funzioni del sito come la ricerca, la visualizzazione di statistiche e l'aggiunta di recensioni. Se un utente si registra come **Gestore** può contribuire all'ampiamento e/o all'aggiornamento dell'app aggiungendo nuove stazioni di rifornimento, rimuovendo comment offensivi o tramite note particolari (es: chiusura della stazione, esaurimento carburante). 

L'utente registrato può effettuare una ricerca inserendo un indirizzo in modo da visualizzare un **elenco di stazioni di rifornimento** vicine ordinate per prezzo crescente ed una mappa con tutti i risultati. Una volta selezionata una stazione, l'utente può vedere i **dettagli** come i tipi di carburante disponibili, i vari prezzi, una mappa normale, una *street view*, e il meteo attuale in quel posto. Inoltre tramite un apposito pulsante l'utente può scegliere di **andare** in una specifica stazione che verrà salvata nel database.

Attraverso le informazioni personali inserite dall'utente, l'applicazione può calcolare il **costo** del pieno per la propria macchina (in base ai litri del serbatoio e ai litri rimanenti) oppure quanti litri verranno *effettivamente* immessi fornendo in input la cifra che si intende spendere. (es: 10€, 20€ …). 

È infine disponibile una sezione **statistiche** dove viene mostrata una classifica delle stazioni di rifornimento con i prezzi migliori e i prezzi peggiori in Italia.



### <img src="https://cdn.pixabay.com/photo/2016/03/31/19/15/gear-1294844_960_720.png" width="50px" />  Descrizione dei dati gestiti

Utilizziamo i dataset messi a disposizione dal [**Ministero dello sviluppo economico**](http://www.sviluppoeconomico.gov.it/index.php/it/open-data/elenco-dataset/2032336-carburanti-prezzi-praticati-e-anagrafica-degli-impianti1) contenenti le informazioni relative agli **Impianti** e ai **prezzi** dei carburanti nelle stazioni di servizio italiane. Sono forniti in formato *.csv* e vengono aggiunti nel database SQlite in automatico dalla nostra applicazione.

Immagazziniamo inoltre i dati relativi ai vari ruoli, agli utenti e alle loro interazioni con l'applicazione, i dati delle stazioni di rifornimento aggiunte dagli utenti gestori con le relative recensioni e commenti, i dati delle stazioni visitate da ciascuno utente e i dati di impianti e prezzi per ogni stazione di rifornimento.



### <img src="https://d30y9cdsu7xlg0.cloudfront.net/png/25183-200.png" width="50px" />  Interazione con servizi esterni

Utilizziamo **Facebook** e **Twitter** tramite i quali, attraverso oAuth 2.0, può essere effettuata una registrazione rapida sulla nostra piattaforma prelevando i dati personali e autocompilando i campi della registrazione.

Vengono utilizzate le API di [**OpenWeatherMap**](https://openweathermap.org/current) per ottenere in tempo reale le informazioni meteo di un determinato impianto di rifornimento.

Inoltre vengono utilizzate le API di **Google Maps** per trovare i distributori più vicini al luogo cercato. In particolare, grazie a [Google Maps Javascript API](https://developers.google.com/maps/documentation/javascript/examples/places-autocomplete), vengono suggeriti i luoghi nella barra di ricerca. L'indirizzo cercato viene poi convertito in coordinate (latidutine,longidutine) tramite [Google Maps Geocoding API](https://developers.google.com/maps/documentation/geocoding/start?hl=it) e le stazioni di rifornimento vicine vengono mostrate tramite [Google Maps Embed API](https://developers.google.com/maps/documentation/embed/?hl=it). Infine viene mostrata la mappa Street view della stazione selezionata.



### <img src="https://d30y9cdsu7xlg0.cloudfront.net/png/584468-200.png" width="50px" />  Ruoli previsti

I ruoli previsti sono tre:

- **Utente non registrato** - Questo ruolo permette di visualizzare solo la pagina inziale, dove sarà fornita un ampia illustrazione del servizio. l'unica operazione che può compiere è *Registrarsi*.
- **Utente registrato** - Questo ruolo è per gli utenti che si sono iscritti al servizio. Possono utilizzare la maggior parte delle funzionalità a disposizione ed hanno una loro proflo personale.
- **Gestore della Stazione** (*Admin*) -  E' un ruolo particolare, dedicato solo ai proprietari delle stazioni di rifornimento. Possono accedere ad alcune funzionalità extra, come l'aggiunta di nuove stazioni di rifornimento, l'aggiunta di note riguardanti la propria stazione (es: esaurimento carburante o chiusura della stazione) o la rimozione di commenti offensivi.