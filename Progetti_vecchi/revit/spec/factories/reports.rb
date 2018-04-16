FactoryGirl.define do
  factory :report do |t|
    t.reported {FactoryGirl.create(:review)}
    t.reporter {FactoryGirl.create(:user)}
    
  end
end
