# **SmartGasStation**

# Istruzioni (Rails 2.3.0)



### 1. Installare **dipendenze**

`bundle install`



### 2a. **Creare** il database **aggiornato** ad oggi tramite script automatico (consigliato)

Aprire terminale in `/SmartGasStation/db` ed eseguire `./generateUpdatedDB.sh`

#### 2b. **Importare** database già **pronto**

Se il metodo 2a non funziona, aprire il terminale nella root del progetto e digitare

`cp /Documenti/development.sqlite3 SmartGasStation/db/` 



### 3. Eseguire **server**

`rails server` 

