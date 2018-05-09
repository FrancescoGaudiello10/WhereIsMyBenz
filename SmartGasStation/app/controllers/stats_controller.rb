class StatsController < ApplicationController
    def index
        if (params.has_key?(:tipo_carburante) && params.has_key?(:order))
            @tipo_carburante = params[:tipo_carburante]
            @order = params[:order]

            if (@order == "MEDIA")

                @provincia = params[:provincia]
                @prezzi_media = Implant
                                    .select('Implants.*, prices.*')
                                    .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto')
                                    .where('prices.descCarburante = ? AND Implants.Provincia = ?', @tipo_carburante, @provincia)
                                    .group('Implants.Provincia')
                                    .average('prices.prezzo')
                @prezzo_medio_italia = Implant
                                           .select('Implants.*, prices.*')
                                           .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto')
                                           .where('prices.descCarburante = ?', @tipo_carburante)
                                           .average('prices.prezzo')

            else
                @order_desc = (@order == "ASC") ? "migliore" : "peggiore"
                @prezzi = Implant
                              .select('Implants.*, prices.*')
                              .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto')
                              .where('descCarburante = ?', @tipo_carburante)
                              .group('Implants.Indirizzo')
                              .order("prices.prezzo #{@order}")
                              .limit(5)

                load_markers(@prezzi, @order)

            end
        end
    end

    private

    #https://melvinchng.github.io/rails/GoogleMap.html#65-dynamic-map-marker
    def load_markers(implant, order)
        @routers_default = Gmaps4rails.build_markers(implant) do |i, marker|
            marker.lat i.latitude
            marker.lng i.longitude

            if order == "ASC" #prezzi migliori, marker verde
                marker_pic = "/marker_green.png"
            elsif order == "DESC" #prezzi peggiori, marker rosso
                marker_pic = "/marker_red.png"
            end

            marker.picture({
                               "url" => marker_pic,
                               "width" => 48,
                               "height" => 48
                           })

            marker.infowindow render_to_string(
                                  :partial => "/implants/station_info",
                                  :locals => {
                                      :bandiera => i.Bandiera.upcase, :indirizzo => i.Indirizzo.humanize,
                                      :prezzo => i.prezzo, :i => i, :carburante => i.descCarburante.humanize
                                  }
                              )
        end

    end

end
