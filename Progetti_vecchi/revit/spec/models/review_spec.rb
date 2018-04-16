require 'rails_helper'
require 'geocoder'
require "geocoder/railtie"
Geocoder::Railtie.insert
RSpec.describe Review, type: :model do
  
  it "has a valid factory" do
    assert FactoryGirl.create(:review).valid?
  end

  it "has none to begin with" do
    expect(Review.count).to eq 0
  end

  it "has one after adding one" do
    review = FactoryGirl.create(:review)
    expect(review.save!).to eq true
  end
  
  it "is invalid without a comment" do
    assert !FactoryGirl.build(:review, comment: nil).valid?
  end
  
  it "is invalid without a price" do
    assert !FactoryGirl.build(:review, price: nil).valid?
  end
  
  it "is invalid without a rating" do
    assert !FactoryGirl.build(:review, rating: nil).valid?
  end
  
  it "is invalid without a store" do
    assert !FactoryGirl.build(:review, store: nil).valid?
  end

  it "is invalid without a store_location" do
    assert !FactoryGirl.build(:review, store_location: nil).valid?
  end

  it "is invalid without a user" do
    assert !FactoryGirl.build(:review, user: nil).valid?
  end

  it "is invalid without a item" do
    assert !FactoryGirl.build(:review, item: nil).valid?
  end
  
  it "is invalid with a rating over 5" do
    assert !FactoryGirl.build(:review, rating: 6 ).valid?
  end

  it "is invalid with a negative rating" do
    assert !FactoryGirl.build(:review, rating: -2 ).valid?
  end

  it "is invalid with a negative price" do
    assert !FactoryGirl.build(:review, price: -2 ).valid?
  end
  
  
  
  
  it "is invalid without a comment during the update" do
	review = FactoryGirl.build(:review) 
	review.update_attributes(:comment => nil) 
	expect(review.valid?).to eq false
  end
  
  it "is invalid without a price during the update" do
	review = FactoryGirl.build(:review) 
	review.update_attributes(:price => nil) 
	expect(review.valid?).to eq false
  end  
  
  it "is invalid without a rating during the update" do
	review = FactoryGirl.build(:review) 
	review.update_attributes(:rating => nil) 
	expect(review.valid?).to eq false
  end
  
  it "is invalid without a store during the update" do
	review = FactoryGirl.build(:review) 
	review.update_attributes(:store => nil) 
	expect(review.valid?).to eq false
  end

  it "is invalid without a store_location during the update" do
	review = FactoryGirl.build(:review) 
	review.update_attributes(:store_location => nil) 
	expect(review.valid?).to eq false
  end

  it "is invalid without a item during the update" do
	review = FactoryGirl.build(:review) 
	review.update_attributes(:item => nil) 
	expect(review.valid?).to eq false
  end
end
