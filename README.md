# # Istruzioni (Rails 2.3.6)

## Dopo aver clonato la repo _per la prima volta_ eseguire questi comandi

1. `bundle install`	per installare le dipendenze 
2. `rake db:migrate` per creare il database vuoto
3. `rake db:seed` per riempire il database con i dati degli impianti e dei prezzi dai .csv _(questo comando ci mette ~10 minuti perché deve importare ~86.400 righe)_
4. `rails server` per avviare il server su http://localhost:3000



### **Tutte le altre volte basta lanciare con `rails server`**