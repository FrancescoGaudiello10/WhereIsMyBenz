# Questo file riempie le tabelle del database con i dati degli impianti e dei prezzi nei file csv tramite il comando 
# rake db:seed

require 'csv'

CSV.foreach(Rails.root.join('db/csv/implants.csv'), headers: true, :col_sep => ";") do |row|
	Implant.create!(
		:idImpianto		=> row['idImpianto'],
		:Gestore 		=> row['Gestore'], 
		:Bandiera 		=> row['Bandiera'], 
		:TipoImpianto	=> row['TipoImpianto'], 
		:NomeImpianto	=> row['NomeImpianto'],
		:Indirizzo		=> row['Indirizzo'], 	
		:Comune			=> row['Comune'],
		:Provincia		=> row['Provincia'],
		:latitude		=> row['latitude'],
		:longitude		=> row['longitude']
		)
end

CSV.foreach(Rails.root.join('db/csv/prices.csv'), headers: true, :col_sep => ";") do |row|
	Price.create!(
		:idImpianto		=> row['idImpianto'], 
		:descCarburante	=> row['descCarburante'], 
		:prezzo			=> row['prezzo'], 
		:isSelf			=> row['isSelf'], 
		:dtComu			=> row['dtComu']
		)
end
