class CalcsController < ApplicationController

    def index
        @visitati = current_user.idImpianto #array di impianti visitati
    end

    def show

        @id = params[:id]
        @tipo_carburante = params[:tipo_carburante]

        salvaImpiantoDB(@id)

        @implant = Implant
                    .select('Implants.*, prices.*')
                    .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto')
                    .where("Implants.idImpianto = ? AND descCarburante = ?", @id, @tipo_carburante)
                    .group("descCarburante")

    end

    private

    def salvaImpiantoDB(id)
        if id.is_a? Numeric
            @visitati = current_user.idImpianto #impianti attualmente in DB
            @visitati.append(id) unless @visitati.include?(id) #aggiungo l'impianto cercato
            current_user.update_attribute :idImpianto, @visitati  #scrivo nel DB
        end
    end

end
