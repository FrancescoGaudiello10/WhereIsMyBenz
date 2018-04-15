require "rails_helper"

RSpec.describe Review, :type => :model do

  it "Creazione recensione per un'inserzione" do
    user = User.create(:email => "giacominoalberobello@omega.it", :password => "password", :password_confirmation => "password", :username => "giacominoalberobello")
    property = Property.create(:title => "Eccezionale", :description => "Fantasticissimo!!!", :price => "567.0", :city => "New York, Stati Uniti", :user_id => user.id)
    recensione = property.reviews.create!(:title => "Posto scadente", :body => "Non ci tornerò mai più", :valutation => 1, :user_id => user.id)
    expect(property.reload.reviews.first).to eq(recensione)
  end

  it "Creazione recensione senza titolo" do
    user = User.create(:email => "giacominoalberobello@omega.it", :password => "password", :password_confirmation => "password", :username => "giacominoalberobello")
    property = Property.create(:title => "Eccezionale", :description => "Fantasticissimo!!!", :price => "567.0", :city => "New York, Stati Uniti", :user_id => user.id)
    recensione = Review.new(:body => "Non ci tornerò mai più", :valutation => 1, :user_id => user.id)
    expect(recensione).not_to be_valid
  end

  it "Creazione recensione senza descrizione" do
    user = User.create(:email => "giacominoalberobello@omega.it", :password => "password", :password_confirmation => "password", :username => "giacominoalberobello")
    property = Property.create(:title => "Eccezionale", :description => "Fantasticissimo!!!", :price => "567.0", :city => "New York, Stati Uniti", :user_id => user.id)
    recensione = Review.new(:title => "Posto scadente", :valutation => 1, :user_id => user.id)
    expect(recensione).not_to be_valid
  end

  it "Creazione recensione senza valutazione" do
    user = User.create(:email => "giacominoalberobello@omega.it", :password => "password", :password_confirmation => "password", :username => "giacominoalberobello")
    property = Property.create(:title => "Eccezionale", :description => "Fantasticissimo!!!", :price => "567.0", :city => "New York, Stati Uniti", :user_id => user.id)
    recensione = Review.new(:title => "Posto scadente", :body => "Non ci tornerò mai più", :user_id => user.id)
    expect(recensione).not_to be_valid
  end

  it "Creazione recensione con valutazione minore o uguale a 0" do
    user = User.create(:email => "giacominoalberobello@omega.it", :password => "password", :password_confirmation => "password", :username => "giacominoalberobello")
    property = Property.create(:title => "Eccezionale", :description => "Fantasticissimo!!!", :price => "567.0", :city => "New York, Stati Uniti", :user_id => user.id)
    recensione = Review.new(:title => "Posto scadente", :body => "Non ci tornerò mai più", :valutation => 0, :user_id => user.id)
    expect(recensione).not_to be_valid
  end

  it "Creazione recensione con valutazione maggiore di 5" do
    user = User.create(:email => "giacominoalberobello@omega.it", :password => "password", :password_confirmation => "password", :username => "giacominoalberobello")
    property = Property.create(:title => "Eccezionale", :description => "Fantasticissimo!!!", :price => "567.0", :city => "New York, Stati Uniti", :user_id => user.id)
    recensione = Review.new(:title => "Posto scadente", :body => "Non ci tornerò mai più", :valutation => 9, :user_id => user.id)
    expect(recensione).not_to be_valid
  end

  it "Creazione recensione con valutazione non intera" do
    user = User.create(:email => "giacominoalberobello@omega.it", :password => "password", :password_confirmation => "password", :username => "giacominoalberobello")
    property = Property.create(:title => "Eccezionale", :description => "Fantasticissimo!!!", :price => "567.0", :city => "New York, Stati Uniti", :user_id => user.id)
    recensione = Review.new(:title => "Posto scadente", :body => "Non ci tornerò mai più", :valutation => 3.4, :user_id => user.id)
    expect(recensione).not_to be_valid
  end

end
