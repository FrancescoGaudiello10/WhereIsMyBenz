class ImplantsController < ApplicationController
    def index
        @implant = Implant.all
    end

    def show
        @city = params[:city].upcase
        @tipo_carburante = params[:tipo_carburante]
        # https://stackoverflow.com/a/34311227/1440037
        @implant = Implant
                       .select('Implants.*, prices.*')
                       .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto')
                       .where('Comune = ? AND descCarburante = ?', @city, @tipo_carburante)
                       .order('prices.prezzo asc')
    end

    private
    def implant_params
        params.require(:implant).permit(:Gestore, :Bandiera, :TipoImpianto, :NomeImpianto, :Indirizzo, :Comune, :Provincia, :Latitudine, :Longitudine)
    end
    
end
