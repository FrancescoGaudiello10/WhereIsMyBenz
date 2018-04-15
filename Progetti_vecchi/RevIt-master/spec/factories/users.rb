FactoryGirl.define do
  factory :user do |f|
    f.name { Faker::Name.name }
    f.email { Faker::Internet.email }
    f.password "matteo"
    f.password_confirmation "matteo"
  end
end
