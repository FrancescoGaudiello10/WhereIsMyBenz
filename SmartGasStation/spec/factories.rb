FactoryBot.define do
  factory :comment do
    body "MyText"
    title "MyString"
    user nil
    implant nil
    station nil
  end

factory :user do
    id "1"
    email "lollo@gmail.com"
    password "123456"
    password_confirmation "123456"
    admin "1"
end

end


