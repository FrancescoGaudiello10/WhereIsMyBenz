require 'rails_helper'

RSpec.describe Contact, type: :model do
  it "has a valid factory" do
    assert FactoryGirl.create(:contact).valid?
  end

  it "has none to begin with" do
    expect(Contact.count).to eq 0
  end

  it "has one after adding one" do
    contact = FactoryGirl.create(:contact)
    expect(contact.save!).to eq true
  end

  it "is invalid without a title" do
    assert !FactoryGirl.build(:contact, title: nil).valid?
  end
  
  it "is invalid without a description" do
    assert !FactoryGirl.build(:contact, description: nil).valid?
  end
  
  it "is invalid without a author" do
    assert !FactoryGirl.build(:contact, author: nil).valid?
  end
  
  it "title too long" do
    contact = FactoryGirl.build(:contact, title: ""*101)
    expect(contact.valid?).to eq false
  end
end
