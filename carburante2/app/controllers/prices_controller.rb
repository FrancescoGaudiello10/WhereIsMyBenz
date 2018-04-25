class PricesController < ApplicationController

    def index
        @price = Price.all
    end

    def show
        #@price = Implant.joins("INNER JOIN prices ON prices.idImpianto = implants.idImpianto")
        #price = Price.joins(:price).where(:price => {:idImpianto => 3464})
    end

end
to
