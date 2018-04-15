FactoryGirl.define do
    factory :review do |f|
        f.description "Non mi piace"
        f.rating 1
    end
    
    factory :invalid_review, class: Review, parent: :review do |f|
        f.description ""
    end
end
