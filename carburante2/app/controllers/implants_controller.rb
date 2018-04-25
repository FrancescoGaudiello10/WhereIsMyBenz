class ImplantsController < ApplicationController
    def index
        @implant = Implant.all
    end

    def show
        #@implant = Implant.where(Comune: params[@city]).take
        @implant = Implant.where("Comune = ?", params[:city]).take
    end

    def new
        @implant = Implant.new
    end

    def edit
        @implant = Implant.find(params[:id])
    end

    # http://guides.rubyonrails.org/getting_started.html#saving-data-in-the-controller
    def create
        @implant = Implant.new(implant_params) #Implant è una classe

        if @implant.save #salva nel database, valore booleano
            redirect_to @implant
        else
            render 'new'
        end

    end

    def update
        @implant = Implant.find(params[:id])

        if @implant.update(article_params)
            redirect_to @implant
        else
            render 'edit'
        end
    end

    def destroy
        @implant = Implant.find(params[:id])
        @implant.destroy

        redirect_to stations_path
    end

    private
    def implant_params
        params.require(:implant).permit(:Gestore, :Bandiera, :TipoImpianto, :NomeImpianto, :Indirizzo, :Comune, :Provincia, :Latitudine, :Longitudine)
    end
    
end
