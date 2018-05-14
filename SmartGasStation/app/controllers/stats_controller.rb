class StatsController < ApplicationController
    def index
        if (params.has_key?(:tipo_carburante) && params.has_key?(:order))
            @tipo_carburante = params[:tipo_carburante]
            @order = params[:order]

            if @order == "MEDIA"

                @regione = params[:regione]
                @prezzi_media = Implant
                                    .select('Implants.*, prices.*')
                                    .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto INNER JOIN regioni ON regioni.sigla = Implants.Provincia')
                                    .where('prices.descCarburante = ? AND regioni.regione = ?', @tipo_carburante, @regione)
                                    .group('regioni.regione')
                                    .average('prices.prezzo')
                @prezzo_medio_italia = Implant
                                           .select('Implants.*, prices.*')
                                           .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto')
                                           .where('prices.descCarburante = ?', @tipo_carburante)
                                           .average('prices.prezzo')

            elsif @order == "ANDAMENTO"
                @andamento_array = Implant
                                 .select('regioni.regione, avg(prices_old.prezzo) , avg(prices.prezzo)')
                                 .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto INNER JOIN prices_old ON Implants.idImpianto = prices_old.idImpianto INNER JOIN regioni ON Implants.Provincia = regioni.sigla')
                                 .where('prices.descCarburante = ?', @tipo_carburante)
                                 .group('regioni.regione')
                                 .pluck('regioni.regione, avg(prices_old.prezzo), avg(prices.prezzo)')

            else
                @order_desc = (@order == "ASC") ? "migliore" : "peggiore" #descrizione
                
                if params[:regione]!=''
                    @prezzi = Implant
                              .select('regioni.regione, Implants.*, prices.*')
                              .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto INNER JOIN regioni ON Implants.Provincia = regioni.sigla')
                              .where('descCarburante = ? AND regioni.regione=?', @tipo_carburante, params[:regione] )
                              .group('Implants.Indirizzo')
                              .order("prices.prezzo #{@order}")
                              .limit(5)
                else 
                    @prezzi = Implant
                                  .select('Implants.*, prices.*')
                                  .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto')
                                  .where('descCarburante = ?', @tipo_carburante)
                                  .group('Implants.Indirizzo')
                                  .order("prices.prezzo #{@order}")
                                  .limit(5)
                end              
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
