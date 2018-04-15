include ActionDispatch::TestProcess

FactoryGirl.define do
    factory :game do |f|
        f.name "Random"
        f.description "Descrizione di un gioco random"
        f.genre "Genere random"
        f.maker "Random production"
        f.pegi '18'
        f.year '2000-01-01'
        f.image { fixture_file_upload "#{Rails.root}/spec/fixtures/images/game.jpg", 'image/jpg' }
    end
    
    factory :invalid_game, class: Game, parent: :game do |f|
        f.name ""
    end
end
