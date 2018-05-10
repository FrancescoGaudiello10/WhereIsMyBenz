require 'rails_helper'

RSpec.describe User, type: :model do

    it "Validazione utente" do
        user = User.new(:email => "lollo@dis.uniroma1.it", :password => "123456", :password_confirmation => "123456")
        expect(user).to be_valid
    end

    it "Creazione utente" do
        user = User.create(:email => "utente@omega.it", :password => "123456", :password_confirmation => "123456")
        expect(User.first).to eq(user)
    end

    it "Utente senza email" do
        user = User.new(:password => "123456", :password_confirmation => "123456")
        expect(user).not_to be_valid
    end

    it "Utente senza password" do
        user = User.new(:email => "utente@omega.it", :password_confirmation => "123456")
        expect(user).not_to be_valid
    end

end
