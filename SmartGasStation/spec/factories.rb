FactoryBot.define do

    factory :user do
        id "1"
        email "lollo@gmail.com"
        password "123456"
        password_confirmation "123456"
        admin "1"
    end

    # factory :station do
    #     bandiera "ESSO"
    #     nome "Mario Rossi"
    #     indirizzo "Via Ariosto 22 Roma"
    #     benzina "1.578"
    #     diesel "1.389"
    #     super ""
    #     excellium ""
    #     metano "0.579"
    #     gpl ""
    #     allDay ""
    #     self ""
    #     autoLavaggio ""
    # end

end


