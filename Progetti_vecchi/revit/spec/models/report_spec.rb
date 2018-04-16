require 'rails_helper'

RSpec.describe Report, type: :model do
  it "has a valid factory" do
    assert FactoryGirl.create(:report).valid?
  end

  it "has none to begin with" do
    expect(Report.count).to eq 0
  end

  it "has one after adding one" do
    report = FactoryGirl.create(:report)
    expect(report.save!).to eq true
  end
  
  it "is invalid without a reporter" do
    assert !FactoryGirl.build(:report, reporter: nil).valid?
  end
  
  it "is invalid without a reported" do
    assert !FactoryGirl.build(:report, reported: nil).valid?
  end
end
