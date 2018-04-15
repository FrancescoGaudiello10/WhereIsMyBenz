require 'spec_helper'

RSpec.describe Ad, :type => :model do

    it "is valid" do
        expect(FactoryGirl.build(:ad)).to be_valid
    end
    it "is invalid without a location" do
        @invalid_ad = FactoryGirl.build(:ad)
        @invalid_ad.location = nil
        expect(@invalid_ad.save).to eq(false)
    end
    it "is invalid without a delivery info" do
        @invalid_ad = FactoryGirl.build(:ad)
        @invalid_ad.delivery = nil
        expect(@invalid_ad.save).to eq(false)
    end
    it "is invalid with incorrect type" do
        @invalid_ad = FactoryGirl.build(:ad)
        @invalid_ad.tipo = 'Prendita'
        expect(@invalid_ad.save).to eq(false)
    end

end
