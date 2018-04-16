require 'rails_helper'
require 'carrierwave'
require 'mini_magick'
require 'carrierwave/orm/activerecord'
RSpec.describe Add, type: :model do
  it "has a valid factory" do
    assert FactoryGirl.create(:add).valid?
  end

  it "has none to begin with" do
    expect(Add.count).to eq 0
  end

  it "has one after adding one" do
    add = FactoryGirl.create(:add)
    expect(add.save!).to eq true
  end

  it "is invalid without a name" do
    assert !FactoryGirl.build(:add, name: nil).valid?
  end
  
  it "is invalid without a price" do
    assert !FactoryGirl.build(:add, price: nil).valid?
  end
  
  it "is invalid without a description" do
    assert !FactoryGirl.build(:add, description: nil).valid?
  end
  
  it "is invalid without a owner" do
    assert !FactoryGirl.build(:add, owner: nil).valid?
  end
  
  it "is invalid with a name too long" do
    assert !FactoryGirl.build(:add, name: "a"*51).valid?
  end
  
  
  
  it "Name too long" do
    add = FactoryGirl.build(:add, name: ""*51)
    expect(add.valid?).to eq false
  end
  
  it "is invalid without a name during the update" do
	add = FactoryGirl.build(:add) 
	add.update_attributes(:name => nil) 
	expect(add.valid?).to eq false
  end
  
  it "is invalid without a price during the update" do
	add = FactoryGirl.build(:add) 
	add.update_attributes(:price => nil) 
	expect(add.valid?).to eq false
  end  
  
  it "is invalid without a description during the update" do
	add = FactoryGirl.build(:add) 
	add.update_attributes(:description => nil) 
	expect(add.valid?).to eq false
  end
  
  
end
