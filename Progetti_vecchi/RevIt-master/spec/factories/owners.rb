FactoryGirl.define do
  factory :owner do |f| 
    f.name { Faker::Name.name }
    f.email { Faker::Internet.email }
    f.password "matteo"
    f.password_confirmation "matteo"
    f.address "velletri"
    f.latitude 40
    f.longitude 50
    f.website "www.carlo.it"
    f.description "sono una prova"
  end
end
