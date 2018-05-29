#!/bin/sh
#
# Questo script scarica i dati aggiornati degli impianti e dei prezzi
# dal sito del Ministero dello Sviluppo Economico,
# applica le modifiche necessarie
# e genera il database SQLite necessario all'applicazione.
#

printf "\n> Cancello i vecchi csv...\n"
rm csv/implants.csv
rm csv/prices.csv


printf "\n> Scarico anagrafica_impianti_attivi.csv dal Ministero...\n"
wget -U "Opera" -O csv/anagrafica_impianti_attivi.csv http://www.sviluppoeconomico.gov.it/images/exportCSV/anagrafica_impianti_attivi.csv

printf "\n> Rimuovo le prime due righe da anagrafica_impianti_attivi.csv creando anagrafica-temp.csv file...\n"
sed '1,2d' csv/anagrafica_impianti_attivi.csv > csv/anagrafica-temp.csv

printf "\n> Sostituisco \" in anagrafica-temp.csv creando implants.csv...\n"
sed 's/"//g' csv/anagrafica-temp.csv  > csv/implants.csv

printf "\n> Aggiungo ; alla fine di ogni riga in implants.csv...\n"
sed -e 's/$/;/' -i csv/implants.csv

printf "\n> Cancello i file inutili...\n"
rm csv/anagrafica_impianti_attivi.csv
rm csv/anagrafica-temp.csv


printf "\n> Scarico prezzo_alle_8.csv dal Ministero...\n"
wget -U "Opera" -O csv/prezzo_alle_8.csv http://www.sviluppoeconomico.gov.it/images/exportCSV/prezzo_alle_8.csv

printf "\n> Rimuovo le prime due righe da prezzo_alle_8.csv creando prices.csv...\n"
sed '1,2d' csv/prezzo_alle_8.csv > csv/prices.csv

printf "\n> Aggiungo ; alla fine di ogni riga in prices.csv...\n"
sed -e 's/$/;/' -i csv/prices.csv

printf "\n> Cancello i file inutili...\n"
rm csv/prezzo_alle_8.csv


printf "\n> Aggiungo ; alla fine di ogni riga in prices_17_mar_18.csv...\n"
sed -e 's/$/;/' -i csv/prices_17_mar_18.csv


printf "\n> Aggiungo ; alla fine di ogni riga in regioni.csv...\n"
sed -e 's/$/;/' -i csv/regioni.csv


printf "\n> Rinomino il vecchio database per non cancellarlo...\n"
mv development.sqlite3 development-old.sqlite3

printf "\n> Creo tutte le tabelle necessarie a Rails...\n"
rails db:migrate > /dev/null 

printf "\n> Importo i .csv nel database...\n"
/usr/bin/sqlite3 development.sqlite3 < csv/create_table_from_csv.sql #> /dev/null 2>&1

printf "\n> DB PRONTO\n"
