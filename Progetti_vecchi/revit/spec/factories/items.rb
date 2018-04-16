FactoryGirl.define do
  factory :item do |f|
    f.name "prova"
    f.description "proviamo gli items"
    f.store_location "velletri"
    f.tag_list "booksaudible"
    f.user { FactoryGirl.create(:user) }
  end
end
