class ImplantsController < ApplicationController

    #autenticazione richiesta per poter effettuare la ricerca
    before_action :authenticate_user!

    def index
        @city            = params[:city]
        @coord           = Geocoder.coordinates(@city)

        @raggio          = params[:raggio][0]
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
                       .near(@coord, @raggio, :order => :distance) #magia
                       #.limit(30)

        # carico i marker delle stazioni sulla mappa
        load_markers(@implant)
    end

    def new
        @implant = Implant.new
    end

    def create
        @implant = Implant.new(station_params) #Implant è una classe
        @implant.save #salva nel database, valore booleano
    end

    def show
        id       = params[:id]
        @implant  = Implant
                       .select('Implants.*, prices.*')
                       .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto')
                       .where('Implants.idImpianto = ?', id)
                       .group('prices.descCarburante')

        #https://apidock.com/rails/ActiveRecord/Calculations/pluck
        @Bandiera   = @implant.pluck(:Bandiera).first
        @Gestore    = @implant.pluck(:Gestore).first
        @Indirizzo  = @implant.pluck(:Indirizzo).first
        @Comune     = @implant.pluck(:Comune).first
        @Provincia  = @implant.pluck(:Provincia).first
        @carburanti = @implant.pluck(:descCarburante)
        @lat        = @implant.pluck(:latitude).first
        @long       = @implant.pluck(:longitude).first
        @prezzi     = @implant.pluck(:descCarburante,:prezzo).to_h #hash

        #Meteo per impianto selezionato
        get_weather

        @stazioniVicine = Implant.find(id).nearbys(3, :order => 'distance').limit(3)

    end

    def stats
        if(params.has_key?(:tipo_carburante) && params.has_key?(:order))
            @tipo_carburante = params[:tipo_carburante]
            @order = params[:order]
            
            if(@order == "MEDIA") ###Occhio se se fotte
            @prezzi = Implant
                                .select('avg(prices.prezzo), Implants.*, prices.*')
                                .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto')
                                .where('prices.descCarburante = ?', @tipo_carburante)
                                .group('Implants.Provincia')
                                .order('avg(prices.prezzo) desc')

            else
            @order_desc = (@order=="ASC") ? "migliore" : "peggiore"
            @prezzi = Implant
                          .select('Implants.*, prices.*')
                          .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto')
                          .where('descCarburante = ?',@tipo_carburante)
                          .group('Implants.Indirizzo')
                          .order("prices.prezzo #{@order}")
                          .limit(5)

            #@coordinates_str = get_implants_array_coord(@prezzi)
            load_markers(@prezzi)
          end
        end

    end

    private

    def implant_params
        params.require(:implant).permit(:idImpianto, :Gestore, :Bandiera, :TipoImpianto, :NomeImpianto, :Indirizzo, :Comune, :Provincia, :Latitudine, :Longitudine)
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

    #https://melvinchng.github.io/rails/GoogleMap.html#65-dynamic-map-marker
    def load_markers(implant)
         @routers_default = Gmaps4rails.build_markers(implant) do |i, marker|
          marker.lat i.latitude
          marker.lng i.longitude

          marker.picture({
            "url" => "https://cdn3.iconfinder.com/data/icons/map/500/gasstation-48.png",
            "width" => 48,
            "height" => 48
          })

          marker.infowindow render_to_string(
          :partial => "/implants/station_info",
          :locals => {
              :bandiera => i.Bandiera.upcase, :indirizzo => i.Indirizzo.humanize,
              :prezzo => i.prezzo, :i => i, :carburante => i.descCarburante.humanize
              }
          )
       end
     end

end
