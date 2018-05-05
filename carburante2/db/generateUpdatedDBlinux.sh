#!/bin/sh
#
# Questo script scarica i dati aggiornati alle 8 di mattina
# dal sito del ministero dello sviluppo economico
# e genera automaticamente il database SQLite necessario a Rails.
#

echo "--> Cancello i vecchi csv..."
echo " "
rm csv/*.csv


echo "--> Scarico anagrafica_impianti_attivi.csv dal Ministero..."
echo " "
wget -U "Opera" -O csv/anagrafica_impianti_attivi.csv http://www.sviluppoeconomico.gov.it/images/exportCSV/anagrafica_impianti_attivi.csv

echo "--> Rimuovo le prime due righe da anagrafica_impianti_attivi.csv creando anagrafica-temp.csv file..."
echo " "
sed '1,2d' csv/anagrafica_impianti_attivi.csv > csv/anagrafica-temp.csv

echo "--> Sostituisco \" in anagrafica-temp.csv creando implants.csv..."
echo " "
sed 's/"//g' csv/anagrafica-temp.csv  > csv/implants.csv

echo "--> Aggiungo ; alla fine di ogni riga in implants.csv..."
echo " "
sed -e 's/$/;/' -i csv/implants.csv

echo "--> Cancello i file inutili..."
rm csv/anagrafica_impianti_attivi.csv
rm csv/anagrafica-temp.csv


echo "--> Scarico prezzo_alle_8.csv dal Ministero..."
echo " "
wget -U "Opera" -O csv/prezzo_alle_8.csv http://www.sviluppoeconomico.gov.it/images/exportCSV/prezzo_alle_8.csv

echo "--> Rimuovo le prime due righe da prezzo_alle_8.csv creando prices.csv..."
echo " "
sed '1,2d' csv/prezzo_alle_8.csv > csv/prices.csv

echo "--> Aggiungo ; alla fine di ogni riga in prices.csv..."
echo " "
sed -e 's/$/;/' -i csv/prices.csv

echo "--> Cancello i file inutili..."
rm csv/prezzo_alle_8.csv


echo "--> Rinomino il vecchio database per non cancellarlo..."
echo " "
mv development.sqlite3 development-old.sqlite3

echo "--> Creo tutte le tabelle necessarie a Rails..."
rails db:migrate

echo "--> Importo i .csv nel database..."
echo " "
/usr/bin/sqlite3 development.sqlite3 < csv/create_table_from_csv.sql

