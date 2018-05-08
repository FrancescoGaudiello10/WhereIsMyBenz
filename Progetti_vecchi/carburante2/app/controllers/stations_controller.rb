class StationsController < ApplicationController

    #autenticazione richiesta
    before_action   :authenticate_user! #, :admin_user, only: :index
    #solo gli amministratori possono modificare o cancellare stazioni
    before_action   :admin_user, only:[:new, :edit, :update, :destroy]
      
    def index
        @station = Station.all
    end

    def show
        @station    = Station.find(params[:id])
        @coord      = Geocoder.coordinates(@station.Indirizzo)
        @lat        = @coord[0]
        @long       = @coord[1]
    end

    def new
        @station = Station.new
        @stazioni = Implant
                        .select('Bandiera')
                        .from('implants')
                        .group('Bandiera')
                        .order('Bandiera ASC')
                        .pluck("Bandiera") #converte in array
    end

    def edit
        @station = Station.find(params[:id])
    end

    # http://guides.rubyonrails.org/getting_started.html#saving-data-in-the-controller
    def create
        @station = Station.new(station_params) #Station è una classe

        if @station.save #salva nel database, valore booleano
            redirect_to @station
        else
            render 'new'
        end

    end

    def update
        @station = Station.find(params[:id])

        if @station.update(article_params)
            redirect_to @station
        else
            render 'edit'
        end
    end

    def destroy
        @station = Station.find(params[:id])
        @station.destroy

        redirect_to stations_path
    end


    private
    
    def station_params
        params.require(:station).permit(:Bandiera, :Nome, :Indirizzo, :Benzina, :Diesel, :Super, :Excellium, :Metano, :GPL, :allDay, :Self, :autoLavaggio)
    end
    
    # https://stackoverflow.com/a/18821972/1440037
    def admin_user
        redirect_to stations_path, notice: "Solo i gestori possono compiere questa azione."  unless current_user.admin?
        #flash[:error] = "Solo i gestori possono compiere questa azione."  unless current_user.admin?
    end

end
