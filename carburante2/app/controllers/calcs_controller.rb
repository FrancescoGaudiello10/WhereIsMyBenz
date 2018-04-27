class CalcsController < ApplicationController
  def index
  end

  def show

    @id = params[:id]
    @tipo_carburante = params[:tipo_carburante]

    @visitati = current_user.idImpianto
    @visitati.append(@id) unless @visitati.include?(@id)
    current_user.update_attribute :idImpianto, @visitati  #salvo nel DB

    @impiantiVisitati = Array.new
    @visitati.each do |idImpianto|
          @implant = Implant
              .select('Implants.*, prices.*')
              .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto')
              .where("Implants.idImpianto = ?", idImpianto)
              .group("descCarburante")
          @impiantiVisitati.append(@implant)
    end

    # @implant = Implant
    #                 .select('Implants.*, prices.*')
    #                 .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto')
    #                 .where("Implants.idImpianto = ? AND descCarburante = ?", @id, @tipo_carburante)
    #                 .group("descCarburante")

  end

end
