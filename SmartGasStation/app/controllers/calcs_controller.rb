class CalcsController < ApplicationController
    def show

        @id = params[:id]
        @tipo_carburante = params[:tipo_carburante]
        @litri = current_user.litri_serbatoio.to_i
        @prezzo = params[:prezzo].to_f

        salvaImpiantoDB(@id)
        flash[:notice] = "Stazione salvata tra quelle visitate"

    end

    private
    def salvaImpiantoDB(id)
        if is_number(id)
            @visitati = current_user.idImpianto #impianti attualmente in DB
            @visitati.append(id) unless @visitati.include?(id) #aggiungo l'impianto cercato
            current_user.update_attribute :idImpianto, @visitati #scrivo nel DB
        end
    end
    # https://stackoverflow.com/a/26062228/1440037
    def is_number(n)
        !!(n =~ /\A[-+]?[0-9]+(\.[0-9]+)?\z/)
    end

end
