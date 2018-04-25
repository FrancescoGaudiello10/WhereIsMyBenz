class ImplantsController < ApplicationController

    def index
        @city = params[:city].upcase
        @tipo_carburante = params[:tipo_carburante]
        @litri_rimanenti = params[:litri_rimanenti]
        # https://stackoverflow.com/a/34311227/1440037
        @implant = Implant
                       .select('Implants.*, prices.*')
                       .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto')
                       .where('Comune = ? AND descCarburante = ?', @city, @tipo_carburante)
                       .order('prices.prezzo asc')
                       .limit(20)
    end

    def show
        @id = params[:id]
        @implant = Implant
                       .select('Implants.*, prices.*')
                       .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto')
                       .where('Implants.idImpianto = ?', @id)
                       .group('prices.descCarburante')
    end

    private
    def implant_params
        params.require(:implant).permit(:Gestore, :Bandiera, :TipoImpianto, :NomeImpianto, :Indirizzo, :Comune, :Provincia, :Latitudine, :Longitudine)
    end
    
end
