require "rails_helper"

RSpec.describe Property, :type => :model do
  describe "Creazione Inserzione senza titolo" do
    it "dovrebbe non essere valida" do
      property = Property.new(:description => "Fantasticissimo!!!", :price => "567.0", :city => "New York, Stati Uniti")
      expect(property).not_to be_valid
    end
  end

  describe "Creazione Inserzione senza descrizione" do
    it "dovrebbe non essere valida" do
      property = Property.new(:title => "Eccezionale", :price => "567.0", :city => "New York, Stati Uniti")
      expect(property).not_to be_valid
    end
  end

  describe "Creazione Inserzione senza prezzo" do
    it "dovrebbe non essere valida" do
      property = Property.new(:title => "Eccezionale", :description => "Fantasticissimo!!!", :city => "New York, Stati Uniti")
      expect(property).not_to be_valid
    end
  end

  describe "Creazione Inserzione senza città" do
    it "dovrebbe non essere valida" do
      property = Property.new(:title => "Eccezionale", :description => "Fantasticissimo!!!", :price => "567.0")
      expect(property).not_to be_valid
    end
  end

  describe "Creazione Inserzione con titolo insufficientemente lungo" do
    it "dovrebbe non essere valida" do
      user = User.create(:email => "giacominoalberobello@omega.it", :password => "password", :password_confirmation => "password", :username => "giacominoalberobello")
      property = Property.new(:title => "ccc", :description => "Fantasticissimo!!!", :price => "567.0", :city => "New York, Stati Uniti", :user_id => user.id)
      expect(property).not_to be_valid
    end
  end

  describe "Creazione Inserzione con descrizione insufficientemente lunga" do
    it "dovrebbe non essere valida" do
      user = User.create(:email => "giacominoalberobello@omega.it", :password => "password", :password_confirmation => "password", :username => "giacominoalberobello")
      property = Property.new(:title => "ccccccc", :description => "Too short", :price => "567.0", :city => "New York, Stati Uniti", :user_id => user.id)
      expect(property).not_to be_valid
    end
  end

  describe "Creazione Inserzione con prezzo negativo" do
    it "dovrebbe non essere valida" do
      user = User.create(:email => "giacominoalberobello@omega.it", :password => "password", :password_confirmation => "password", :username => "giacominoalberobello")
      property = Property.new(:title => "ccccccc", :description => "Fantasticissimo!!!", :price => "-567.0", :city => "New York, Stati Uniti", :user_id => user.id)
      expect(property).not_to be_valid
    end
  end

  describe "Creazione Inserzione completa" do
    it "dovrebbe essere valida e salvata correttamente" do
      user = User.create(:email => "giacominoalberobello@omega.it", :password => "password", :password_confirmation => "password", :username => "giacominoalberobello")
      property = Property.new(:title => "Eccezionale", :description => "Fantasticissimo!!!", :price => "567.0", :city => "New York, Stati Uniti", :user_id => user.id)
      expect(property).to be_valid
      property.save
      expect(Property.first).to eq(property)
    end
  end

  context "Inserzione con 2 o più recensioni" do
    it "dovrei vedere le recensioni ordinate per data crescente" do
      user = User.create(:email => "giacominoalberobello@omega.it", :password => "password", :password_confirmation => "password", :username => "giacominoalberobello")
      property = Property.new(:title => "Eccezionale", :description => "Fantasticissimo!!!", :price => "567.0", :city => "New York, Stati Uniti", :user_id => user.id)
      property.save!
      recensione1 = property.reviews.create!(:title => "Prima Recensione", :body => "Questa è la prima recensione", :valutation => 4, :user_id => user.id)
      recensione2 = property.reviews.create!(:title => "Seconda Recensione", :body => "Questa è la seconda recensione", :valutation => 3, :user_id => user.id)
      expect(property.reload.reviews).to eq([recensione1, recensione2])
    end
  end

  context "Inserzione con almeno una recensione" do
    it "rimozione recensione da una proprietà" do
      user = User.create(:email => "giacominoalberobello@omega.it", :password => "password", :password_confirmation => "password", :username => "giacominoalberobello")
      property = Property.new(:title => "Eccezionale", :description => "Fantasticissimo!!!", :price => "567.0", :city => "New York, Stati Uniti", :user_id => user.id)
      property.save!
      recensione1 = property.reviews.create!(:title => "Prima Recensione", :body => "Questa è la prima recensione", :valutation => 4, :user_id => user.id)
      property.reviews.first.delete
      expect(property.reload.reviews.first).to eq(nil)
    end

  end

end
