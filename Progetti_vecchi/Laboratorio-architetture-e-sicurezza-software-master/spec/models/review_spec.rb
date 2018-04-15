require 'spec_helper'

RSpec.describe Review, :type => :model do

    it "is valid" do
        expect(FactoryGirl.build(:review)).to be_valid
    end
    it "is invalid without a description" do
        @invalid_review = FactoryGirl.build(:review)
        @invalid_review.description = nil
        expect(@invalid_review.save).to eq(false)
    end
    it "is invalid with rating out of range" do
        @invalid_review = FactoryGirl.build(:review)
        @invalid_review.rating = 0
        expect(@invalid_review.save).to eq(false)
    end

end
