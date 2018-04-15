require 'spec_helper'

RSpec.describe Report, :type => :model do

    it "is valid" do
        expect(FactoryGirl.build(:report)).to be_valid
    end
    it "is invalid without a description" do
        @invalid_report = FactoryGirl.build(:report)
        @invalid_report.description = nil
        expect(@invalid_report.save).to eq(false)
    end

end
