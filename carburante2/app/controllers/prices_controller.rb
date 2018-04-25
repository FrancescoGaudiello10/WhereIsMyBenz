class PricesController < ApplicationController

    def index
        @price = Price.all
    end

    def new
        @price = Price.new
    end

    def create
        @price = Price.new(price_params) #Station è una classe
        @price.save #salva nel database, valore booleano
    end

    def show

    end

    private
    def price_params
        params.require(:price).permit(:idImpianto, :descCarburante, :prezzo, :isSelf, :dtComu)
    end

end


