# Istruzioni (Rails 2.3.0)



### 1. Installare **dipendenze**

`bundle install`



### 2a. **Creare** il database **aggiornato** ad oggi tramite script automatico (consigliato)

Aprire terminale in `/carburante2/db` ed eseguire `./createUpdatedDB.sh`

### ~~2b. **Importare** database già **pronto**~~

~~Aprire terminale nella root del progetto~~

~~`cp /Documenti/development.sqlite3 carburante2/db/`~~ 

### ~~2c. **Generare** database (molto più **lento**)~~ 

~~`rake db:migrate` per creare il database vuoto~~

~~`rake db:seed` per riempire il database con i dati degli impianti e dei prezzi dai .csv _(questo comando ci mette >10 minuti perché deve importare ~86.400 righe)_~~



### 3. Eseguire **server** su porta 3000

`rails server` 

