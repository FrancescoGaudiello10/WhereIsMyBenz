class CalcsController < ApplicationController
    def show

        @id = params[:id]
        @tipo_carburante = params[:tipo_carburante]

        salvaImpiantoDB(@id)
        flash[:notice] = "Stazione salvata tra quelle visitate"

        @implant = Implant
                    .select('Implants.*, prices.*')
                    .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto')
                    .where("Implants.idImpianto = ? AND descCarburante = ?", @id, @tipo_carburante)
                    .group("descCarburante")

    end

    private

    def salvaImpiantoDB(id)
        if is_number(id)
            @visitati = current_user.idImpianto #impianti attualmente in DB
            @visitati.append(id) unless @visitati.include?(id) #aggiungo l'impianto cercato
            current_user.update_attribute :idImpianto, @visitati  #scrivo nel DB
        end
    end

    # https://stackoverflow.com/a/26062228/1440037
    def is_number(n)
        !!(n =~ /\A[-+]?[0-9]+(\.[0-9]+)?\z/)
    end
    
end
