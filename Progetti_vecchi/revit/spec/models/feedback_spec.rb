require 'rails_helper'

RSpec.describe Feedback, type: :model do
  it "has a valid factory" do
    assert FactoryGirl.create(:feedback).valid?
  end

  it "has none to begin with" do
    expect(Feedback.count).to eq 0
  end

  it "has one after adding one" do
    feedback = FactoryGirl.create(:feedback)
    expect(feedback.save!).to eq true
  end

  it "is invalid without a giver" do
    assert !FactoryGirl.build(:feedback, giver: nil).valid?
  end
  
  it "is invalid without a receiver" do
    assert !FactoryGirl.build(:feedback, receiver: nil).valid?
  end
  
    
  
end
