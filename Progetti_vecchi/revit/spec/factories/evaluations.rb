FactoryGirl.define do
  factory :evaluation do |f|
    f.evaluater {FactoryGirl.create(:user)}
    f.evaluated {FactoryGirl.create(:owner)}
    f.value 7
    
  end
end
