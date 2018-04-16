FactoryGirl.define do
  factory :add do |f|
    f.name  "add"
    f.description "questa è una buona add"
    f.price 50
    f.owner {FactoryGirl.create(:owner)}
  end
end
