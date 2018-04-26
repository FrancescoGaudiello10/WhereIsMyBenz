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
                       .limit(30)
    end

    def new
        @implant = Implant.new
    end

    def create
        @implant = Implant.new(station_params) #Station è una classe
        @implant.save #salva nel database, valore booleano
    end

    require 'httparty'
    def show
        @id = params[:id]
        @implant = Implant
                       .select('Implants.*, prices.*')
                       .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto')
                       .where('Implants.idImpianto = ?', @id)
                       .group('prices.descCarburante')

        #https://apidock.com/rails/ActiveRecord/Calculations/pluck
        @Bandiera   = @implant.pluck(:Bandiera)[0]
        @Indirizzo  = @implant.pluck(:Indirizzo)[0]
        @Comune     = @implant.pluck(:Comune)[0]
        @Provincia  = @implant.pluck(:Provincia)[0]
        @carburanti = @implant.pluck(:descCarburante)
        @lat        = @implant.pluck(:Latitudine)[0]
        @long       = @implant.pluck(:Longitudine)[0]

        @weather = HTTParty.get('http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=cdcc43f188d9a63e00471c9b6b45cada').parsed_response
    end

    private
    def implant_params
        params.require(:implant).permit(:idImpianto, :Gestore, :Bandiera, :TipoImpianto, :NomeImpianto, :Indirizzo, :Comune, :Provincia, :Latitudine, :Longitudine)
    end

end
