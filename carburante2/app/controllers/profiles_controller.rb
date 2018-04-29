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
  end

  def update
    admin = params[:admin]
    luogo_preferito = params[:luogo_preferito]
    stazione_preferita = params[:stazione_preferita]
    carburante_preferito = params[:carburante_preferito]
    litri_serbatoio = params[:litri_serbatoio][0]

    current_user.update_attribute :admin, admin
    current_user.update_attribute :luogo_preferito, luogo_preferito
    current_user.update_attribute :stazione_preferita, stazione_preferita
    current_user.update_attribute :carburante_preferito, carburante_preferito
    current_user.update_attribute :litri_serbatoio, litri_serbatoio
  end

end
