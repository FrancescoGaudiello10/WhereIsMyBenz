# **SmartGasStation**

#### Trova la stazione di rifornimento più vicina a te.



## Esecuzione (Rails 2.3.0, LXLE-BIAR-1.4)

### 1. Installare **dipendenze**

`bundle install`



### 2. **Creare** il database **aggiornato** ad oggi tramite script automatico 

Aprire terminale in `/SmartGasStation/db` ed eseguire `./generateUpdatedDB.sh`

#### 2b. **Importare** database già **pronto**

Se il metodo 2a non funziona, aprire il terminale nella root del progetto e digitare

`cp /Documenti/development.sqlite3 SmartGasStation/db/` 



### 3. Eseguire **server**

`rails server` 

