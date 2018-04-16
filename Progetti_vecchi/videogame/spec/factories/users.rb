FactoryGirl.define do
    factory :user do |f|
        f.provider "facebook"
        f.uid '12345'
        f.name "Piermenti Sfracellozzi"
        f.email "piermenti@sfracellozzi.com"
        f.password 'some sort of password'
        f.role 'Active'
    end
    
    factory :admin, class: User, parent: :user do |f|
        f.role "Admin"
    end
    
    factory :banned, class: User, parent: :user do |f|
        f.role 'Banned'
    end
end
