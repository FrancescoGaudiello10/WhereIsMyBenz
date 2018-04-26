# <img src="http://cdn.onlinewebfonts.com/svg/img_403829.png" width="70px" /> Smart Gas Station



### <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQneNR5549RqlG4fRgDc2db2jif6cqa-yUtkWf9ATx6KPePNw26oQ" width="50px" /> Funzionalità da offrire agli utenti

Il progetto consiste in una *Web Application* la quale consente ad un utente, dopo aver generato un profilo identificativo, di localizzare le stazioni di rifornimento più vicine a lui, quelle con i prezzi più convienienti o quelle che dispongono di carburanti particolari. (es: GPL, metano). 

La registrazione avviene **gratuitamente** tramite il sito ufficiale oppure tramite Facebook e consentirà all'utente di inserire le proprie informazioni e le proprie preferenze, **diventando parte integrante della piattaforma** cosicchè anche lui possa contribuire all'ampiamento e/o all'aggiornamento dell'app tramite recensioni o note particolari. (es: chiusura della stazione, esaurimento carburante) 

Attraverso le informazioni personali inserite dall'utente, l'applicazione calcolerà in anticipo il costo del pieno per la propria macchina oppure quanti litri verranno "effettivamente" immessi fornendo in input solamente la cifra che si intende spendere. (es: 10€, 20€ …). 
Tutto questo avverrà con **informazioni reali ed aggiornate ogni giorno**. 
Gli utenti possono anche ricercare le stazioni di servizio nelle vicinanze e confrontare i prezzi per trovare le più convenienti.

Le pagine delle stazioni sono aggiornate continuamente e sono provviste di interessanti e statistiche utili, ma nel caso non ci fosse la propria stazione preferita sarà possibile aggiungerne una.





### <img src="https://cdn.pixabay.com/photo/2016/03/31/19/15/gear-1294844_960_720.png" width="50px" />  Descrizione dei dati gestiti

Utilizziamo i dati prelevati dal sito del **Ministero dello sviluppo economico** (http://goo.gl/4HCrb1) che fornisce dei dataset scaricabili in formato *.csv* contenenti le informazioni relative agli impianti e ai prezzi dei carburanti nelle stazioni di servizio italiane. I dati vengono aggiornati quotidianamente alle 8 di mattina, dati che la **Smart Gas Station** preleverà ed inserirà nel *Database* in completa autonomia.

Immagazzineremo nel database i dati relativi agli utenti e alle loro interazioni con l'applicazione.







### <img src="https://d30y9cdsu7xlg0.cloudfront.net/png/25183-200.png" width="50px" />  Interazione con servizi esterni

Il primo servizio esterno con cui comunicheremo è **Facebook**, noto *Social Network* tramite il quale, attraverso oAuth 2.0, potrà essere effettuata una registrazione rapida sulla nostra piattaforma prelevando i dati personali e autocompilando i campi della registrazione.





### <img src="https://d30y9cdsu7xlg0.cloudfront.net/png/584468-200.png" width="50px" />  Ruoli previsti

I ruoli previsti sono tre:

- **Utente non registrato** - Questo ruolo permette di visualizzare solo la pagina inziale, dove sarà fornita un ampia illustrazione del servizio. l'unica operazione che può compiere è *Registrarsi*.
- **Utente registrato** - Questo ruolo è per gli utenti che si sono iscritti al servizio. Possono utilizzare ogni funzionalità a disposizione ed hanno una loro proflo personale.
- **Amministratore della Stazione** -  E' un ruolo particolare, dedicato solo ai proprietari delle stazioni di rifornimento. Tramite un CODICE ID UNIVOCO possono accedere ad alcune funzionalità extra, come l'aggiunta di note riguardanti la propria stazione (es: esaurimento carburante) o la rimozione di commenti offensivi. 