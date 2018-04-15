FactoryGirl.define do
    factory :ad do |f|
        f.location "Roma"
        f.delivery "Scambio diretto"
        f.tipo "Prestito"
        f.description "Nessuna informazione aggiuntiva"
    end
    
    factory :invalid_ad, class: Ad, parent: :ad do |f|
        f.location ""
    end
end
