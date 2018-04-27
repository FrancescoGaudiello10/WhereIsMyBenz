class StationsController < ApplicationController

    #autenticazione richiesta, solo gli amministratori possono aggiungere stazioni
    before_action :authenticate_user! , :admin_user, only: :index

    def index
        @station = Station.all
    end

    def show
        @station = Station.find(params[:id])
    end

    def new
        @station = Station.new
    end

    def edit
        @station = Station.find(params[:id])
    end

    # http://guides.rubyonrails.org/getting_started.html#saving-data-in-the-controller
    def create
        # render plain: params[:station].inspect #The params method is the object which represents the parameters (or fields) coming in from the form
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
        params.require(:station).permit(:Bandiera, :Nome, :Indirizzo, :Comune, :Provincia)
    end

    def admin_user
        redirect_to(new_user_session_path) unless current_user.admin?
    end

end
