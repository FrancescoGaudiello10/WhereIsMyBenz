class StatsController < ApplicationController
  def index
      if(params.has_key?(:tipo_carburante) && params.has_key?(:order))
                  @tipo_carburante = params[:tipo_carburante]
                  @order = params[:order]

                  if(@order == "MEDIA")

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
                      @order_desc = (@order=="ASC") ? "migliore" : "peggiore"
                      @prezzi = Implant
                                    .select('Implants.*, prices.*')
                                    .joins('INNER JOIN prices ON Implants.idImpianto = prices.idImpianto')
                                    .where('descCarburante = ?',@tipo_carburante)
                                    .group('Implants.Indirizzo')
                                    .order("prices.prezzo #{@order}")
                                    .limit(5)

                      load_markers(@prezzi)

                  end
              end
  end
  
  private
  #https://melvinchng.github.io/rails/GoogleMap.html#65-dynamic-map-marker
  def load_markers(implant, center_address=nil, center_coords=nil)
      @routers_default = Gmaps4rails.build_markers(implant) do |i, marker|
          marker.lat i.latitude
          marker.lng i.longitude

          marker_pic = "https://cdn3.iconfinder.com/data/icons/map/500/gasstation-48.png"
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

      #aggiungo l'indirizzo cercato, il centro della mappa
      if center_address!=nil and center_coords!=nil
      @routers_default.append({:lat=>center_coords[0], :lng=>center_coords[1],
                               :picture=>{"url"=>"/blue-marker.png","width"=>30, "height"=>48},
                               :infowindow=>"<b>#{center_address}</b> <br>\n"
                               })
      end

  end
end
