require 'spec_helper'

RSpec.describe User, :type => :model do

    it "is valid" do
        expect(FactoryGirl.build(:user)).to be_valid
    end
    it "is invalid without a name" do
        @invalid_user = FactoryGirl.build(:user)
        @invalid_user.name = nil
        expect(@invalid_user.save).to eq(false)
    end
    
    it "is invalid without an email" do
        @invalid_user = FactoryGirl.build(:user)
        @invalid_user.email = nil
        expect(@invalid_user.save).to eq(false)
    end

end
