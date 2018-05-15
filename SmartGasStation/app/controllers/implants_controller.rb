class ImplantsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_implant, only: [:show, :edit, :update, :destroy]

    # GET /implants
    # GET /implants.json
    def index
        @city = params[:city] #indirizzo cercato

        @coord = Geocoder.coordinates(@city) #coordinate dell'indirizzo cercato

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
                       .where('descCarburante = ?', @tipo_carburante)
                       .group('Implants.Indirizzo')
                       .order('prices.prezzo ASC')
                       .near(@coord, @raggio, :order => :distance) #magia

        @titolo_impianti = helpers.calcola_numero_impianti_trovati(@implant)

        # carico i marker delle stazioni sulla mappa
        load_markers(@implant, @city, @coord)
    end

    # GET /implants/1
    # GET /implants/1.json
    def show
        id = params[:id]
        @implant = Implant
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
        @prezzi     = @implant.pluck(:descCarburante, :prezzo).to_h #hash


        #Meteo per impianto selezionato
        get_weather
        @logo = helpers.get_implant_logo(@Bandiera)

        @stazioniVicine = Implant.find(id).nearbys(3, :order => 'distance').limit(3)

    end

    # GET /implants/new
    def new
        @implant = Implant.new
    end

    # GET /implants/1/edit
    def edit
    end

    # POST /implants
    # POST /implants.json
    def create
        @implant = Implant.new(implant_params)

        respond_to do |format|
            if @implant.save
                format.html {redirect_to @implant, notice: 'Implant was successfully created.'}
                format.json {render :show, status: :created, location: @implant}
            else
                format.html {render :new}
                format.json {render json: @implant.errors, status: :unprocessable_entity}
            end
        end
    end

    # PATCH/PUT /implants/1
    # PATCH/PUT /implants/1.json
    def update
        respond_to do |format|
            if @implant.update(implant_params)
                format.html {redirect_to @implant, notice: 'Implant was successfully updated.'}
                format.json {render :show, status: :ok, location: @implant}
            else
                format.html {render :edit}
                format.json {render json: @implant.errors, status: :unprocessable_entity}
            end
        end
    end

    # DELETE /implants/1
    # DELETE /implants/1.json
    def destroy
        @implant.destroy
        respond_to do |format|
            format.html {redirect_to implants_url, notice: 'Implant was successfully destroyed.'}
            format.json {head :no_content}
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_implant
        @implant = Implant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def implant_params
        params.require(:implant).permit(:idImpianto, :Gestore, :Bandiera, :TipoImpianto, :NomeImpianto, :Indirizzo, :Comune, :Provincia, :latitude, :longitude, :distance)
    end

    #ottiene il meteo della stazione di rifornimento cercata
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
        @weather_sunrise = helpers.unixToHuman(@weather["sys"]["sunrise"])
        @weather_sunset = helpers.unixToHuman(@weather["sys"]["sunset"])
    end


    #https://melvinchng.github.io/rails/GoogleMap.html#65-dynamic-map-marker
    # disegna i marker sulla mappa
    # il migliore è indicato il verde
    # il peggiore in rosso
    # tutti gli altri in nero
    # aggiunge per ultimo l'indirizzo cercato con marker blu
    def load_markers(implant, center_address, center_coords)

        #Array di prezzi ordinato in ordine crescente
        prezzi = implant.pluck(:prezzo)
        prezzo_migliore = prezzi.first
        prezzo_peggiore = prezzi.last

        @routers_default = Gmaps4rails.build_markers(implant) do |i, marker|
            marker.lat i.latitude
            marker.lng i.longitude

            if i.prezzo == prezzo_migliore
                marker_pic = "/marker_green.png"
            elsif i.prezzo == prezzo_peggiore
                marker_pic = "/marker_red.png"
            else
                marker_pic = "/marker_black.png"
            end

            marker.picture({
                               "url" => marker_pic,
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

        #aggiungo l'indirizzo cercato, il centro della mappa, come ultimo elemento dell'array
        if center_address != nil and center_coords != nil
            @routers_default.append({:lat => center_coords[0], :lng => center_coords[1],
                                     :picture => {"url" => "/blue-marker.png", "width" => 30, "height" => 48},
                                     :infowindow => "<b>#{center_address}</b> <br>\n"
                                    })
        end

    end

end
