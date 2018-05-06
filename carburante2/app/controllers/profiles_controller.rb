class ProfilesController < ApplicationController

  def index
    @user = current_user
    #array di tutte le stazioni di rifornimento disponibili
    @stazioni = Implant
                     .select('Bandiera')
                     .from('implants')
                     .group('Bandiera')
                     .order('Bandiera ASC')
                     .pluck("Bandiera") #converte in array
    if current_user.targa != nil                  
        infoAuto(current_user.targa)
    end
  end

  def update
    admin                = params[:admin]
    luogo_preferito      = params[:luogo_preferito]
    stazione_preferita   = params[:stazione_preferita]
    carburante_preferito = params[:carburante_preferito]
    litri_serbatoio      = params[:litri_serbatoio][0]
    targa                = params[:targa].upcase


    current_user.update_attribute :admin,                 admin
    current_user.update_attribute :luogo_preferito,       luogo_preferito
    current_user.update_attribute :stazione_preferita,    stazione_preferita
    current_user.update_attribute :carburante_preferito,  carburante_preferito
    current_user.update_attribute :litri_serbatoio,       litri_serbatoio
    current_user.update_attribute :targa,                 targa
  end
  
  private 
  
  def infoAuto(targa)
    veicolo = JSON.parse(
        HTTParty.get(  "http://app.segugio.it/doJsonCommand.bl?pstjsn=%7B%22directive%22:%22GDT%22,%22parameters%22:%7B%22vehicleType%22:A,%20%22plate%22:#{targa},%20%22ver%22:%22tu2Ah%22%7D%7D&_=1517504750001")
    )["jsonDaTarga"]
    if veicolo != nil
        @immatricolazione  = veicolo["registration_date"]
        @auto              = veicolo["brands"][0]["brand_description"] + " " + veicolo["models"][0]["model_description"]
    end
  end

end
