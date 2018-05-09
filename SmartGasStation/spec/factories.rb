FactoryGirl.define do
    factory :user do
        id "1"
        email "lollo@gmail.com"
        password "123456"
        password_confirmation "123456"
        admin "1"
    end

    factory :station do
        bandiera "ESSO"
        nome "Mario rossi"
        indirizzo "Via ariosto 22, roma"
    end

end
