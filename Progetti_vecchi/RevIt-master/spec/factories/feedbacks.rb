FactoryGirl.define do
  factory :feedback do |f|
    f.giver {FactoryGirl.create(:user)}
    f.value true
    f.receiver {FactoryGirl.create(:user)}
  end
end
