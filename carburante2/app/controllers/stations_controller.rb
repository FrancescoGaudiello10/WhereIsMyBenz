class StationsController < ApplicationController

    def show
        @station = Station.find(params[:id])
    end

    def new

    end

    # http://guides.rubyonrails.org/getting_started.html#saving-data-in-the-controller
    def create
        # render plain: params[:station].inspect #The params method is the object which represents the parameters (or fields) coming in from the form
        @station = Station.new(station_params) #Station è una classe
        @station.save #nel database
        redirect_to @station
    end

    private
    def station_params
        params.require(:station).permit(:Bandiera, :Nome, :Indirizzo, :Comune, :Provincia)
    end

end
