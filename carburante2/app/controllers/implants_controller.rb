class ImplantsController < ApplicationController

    #autenticazione richiesta per poter effettuare la ricerca
    before_action :authenticate_user!

    def index
        @city = params[:city]
        @coord = Geocoder.coordinates(@city)

        @raggio = params[:raggio][0]
        @tipo_carburante = params[:tipo_carburante]
        # @litri_rimanenti = params[:litri_rimanenti]

        # # https://stackoverflow.com/a/34311227/1440037
        # Prendo tutti gli impianti con i relativi prezzi
        # che hanno il tipo di carburante cercato e sono vicini al punto cercato,
        # ordinati per prezzo crescente
        @implant = Implant
                       .select('Implants.*, prices.*')
                       .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto')
                       .where('descCarburante = ?',@tipo_carburante)
                       .group('Implants.Indirizzo')
                       .order('prices.prezzo ASC')
                       .limit(30)
                       .near(@coord, @raggio, :order => :distance) #magia

        get_implants_array_coord(@implant)
    end

    def new
        @implant = Implant.new
    end

    def create
        @implant = Implant.new(station_params) #Implant è una classe
        @implant.save #salva nel database, valore booleano
    end

    def show
        @id = params[:id]
        @implant = Implant
                       .select('Implants.*, prices.*')
                       .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto')
                       .where('Implants.idImpianto = ?', @id)
                       .group('prices.descCarburante')

        #https://apidock.com/rails/ActiveRecord/Calculations/pluck
        @Bandiera   = @implant.pluck(:Bandiera)[0]
        @Gestore    = @implant.pluck(:Gestore)[0]
        @Indirizzo  = @implant.pluck(:Indirizzo)[0]
        @Comune     = @implant.pluck(:Comune)[0]
        @Provincia  = @implant.pluck(:Provincia)[0]
        @carburanti = @implant.pluck(:descCarburante)
        @lat        = @implant.pluck(:latitude)[0]
        @long       = @implant.pluck(:longitude)[0]
        @prezzi     = @implant.pluck(:descCarburante,:prezzo).to_h #hash

        #Impianti vicini a quello selezionato
        get_nearby_implants_array

        #Meteo per impianto selezionato
        get_weather

    end

    def stats
        if(params.has_key?(:tipo_carburante) && params.has_key?(:order))
            @tipo_carburante = params[:tipo_carburante]
            @order = params[:order]
            @order_desc = (@order=="ASC") ? "migliore" : "peggiore"
            @prezzi = Implant
                          .select('Implants.*, prices.*')
                          .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto')
                          .where('descCarburante = ?',@tipo_carburante)
                          .group('Implants.Indirizzo')
                          .order("prices.prezzo #{@order}")
                          .limit(5)

            @coordinates_str = get_implants_array_coord(@prezzi)
        end

    end

    private

    def implant_params
        params.require(:implant).permit(:idImpianto, :Gestore, :Bandiera, :TipoImpianto, :NomeImpianto, :Indirizzo, :Comune, :Provincia, :Latitudine, :Longitudine)
    end

    #restituiscd array con le coordinate delle stazioni vicine a quella selezionata (nel raggio di 2 KM)
    def get_nearby_implants_array
        @nearby  = @implant.find(params[:id]).nearbys(2) #KM
        @coordinates_str = ""
        @nearby.each do |i|
            @coordinates_str += "#{i.latitude},#{i.longitude}|"
        end
    end

    #restituiscd array con le coordinate delle stazioni risultato della ricerca
    def get_implants_array_coord(implant)
        @coordinates_str = ""
        implant.each do |i|
            @coordinates_str += "#{i.latitude},#{i.longitude}|"
        end
        return @coordinates_str
    end

    def get_weather
        @weather = HTTParty.get(
            "http://api.openweathermap.org/data/2.5/weather?q=#{@Comune}&appid=cdcc43f188d9a63e00471c9b6b45cada&lang=it&units=metric",
            :query => {:output => 'json'}
        )
        @weather_description = @weather["weather"][0]["description"]
        @weather_icon = "http://openweathermap.org/img/w/#{@weather["weather"][0]["icon"]}.png"
        @weather_temp = @weather["main"]["temp"]
        @weather_temp_min = @weather["main"]["temp_min"]
        @weather_temp_max = @weather["main"]["temp_max"]
        @weather_sunrise = unixToHuman(@weather["sys"]["sunrise"])
        @weather_sunset = unixToHuman(@weather["sys"]["sunset"])
    end

    #converte timestamp unix in orario normale
    def unixToHuman (timestamp)
        #https://stackoverflow.com/a/3964560/1440037
        Time.at(timestamp).utc.in_time_zone(+2).strftime("%H:%M:%S")
    end

end
