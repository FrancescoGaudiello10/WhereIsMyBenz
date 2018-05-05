# Questo file riempie le tabelle del database con i dati degli impianti e dei prezzi nei file csv tramite il comando 
# rake db:seed
# NON CONSIGLIATO, troppo lento

require 'csv'

puts "Sto creando il database con tutti gli impianti, ci vorra' un po' di tempo (circa 10 minuti)..."
progressbar = ProgressBar.create(:title => "Impianti", :starting_at => 0, :total => 20937)

CSV.foreach(Rails.root.join('db/csv/implants.csv'), headers: true, :col_sep => ";") do |row|
    Implant.create!(
        :idImpianto		=> row['idImpianto'],
        :Gestore 		  => row['Gestore'],
        :Bandiera 		=> row['Bandiera'],
        :TipoImpianto	=> row['TipoImpianto'],
        :NomeImpianto	=> row['NomeImpianto'],
        :Indirizzo		=> row['Indirizzo'],
        :Comune			  => row['Comune'],
        :Provincia		=> row['Provincia'],
        :latitude		  => row['Latitudine'],
        :longitude	  => row['Longitudine']
    )
    progressbar.increment
end


puts "Sto creando il database con tutti i prezzi, ci vorra' un po' di tempo (circa 10 minuti)..."
progressbar = ProgressBar.create(:title => "Prezzi", :starting_at => 0, :total => 86432)

CSV.foreach(Rails.root.join('db/csv/prices.csv'), headers: true, :col_sep => ";") do |row|
    Price.create!(
        :idImpianto		=> row['idImpianto'],
        :descCarburante	=> row['descCarburante'],
        :prezzo			=> row['prezzo'],
        :isSelf			=> row['isSelf'],
        :dtComu			=> row['dtComu']
    )
    progressbar.increment
end
