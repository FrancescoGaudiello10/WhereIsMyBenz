class VisitsController < ApplicationController

    def index
        @visitati = current_user.idImpianto #array di impianti visitati
    end

end
