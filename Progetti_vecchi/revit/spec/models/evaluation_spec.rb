require 'rails_helper'

RSpec.describe Evaluation, type: :model do
  it "has a valid factory" do
    assert FactoryGirl.create(:evaluation).valid?
  end

  it "has none to begin with" do
    expect(Evaluation.count).to eq 0
  end

  it "has one after adding one" do
    evaluation = FactoryGirl.create(:evaluation)
    expect(evaluation.save!).to eq true
  end
  
  it "is invalid without a evaluater" do
    assert !FactoryGirl.build(:evaluation, evaluater: nil).valid?
  end
  
  it "is invalid without a evaluated" do
    assert !FactoryGirl.build(:evaluation, evaluated: nil).valid?
  end
  
  it "is invalid without a value" do
    assert !FactoryGirl.build(:evaluation, value: nil).valid?
  end

  it "is invalid with a value over 10" do
    assert !FactoryGirl.build(:evaluation, value: 11 ).valid?
  end

  it "is invalid with a negative value" do
    assert !FactoryGirl.build(:evaluation, value: -2 ).valid?
  end
end
