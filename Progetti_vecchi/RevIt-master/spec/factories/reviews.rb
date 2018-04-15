FactoryGirl.define do
  factory :review do |f|
    f.comment "va bene"
    f.price 5
    f.rating 5
    f.store "prova"
    f.store_location "velletri"
    f.item { FactoryGirl.create(:item) }
    f.user { FactoryGirl.create(:user) }
  end
end
