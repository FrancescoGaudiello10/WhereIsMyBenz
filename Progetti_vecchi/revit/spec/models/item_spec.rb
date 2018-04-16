require 'rails_helper'
require 'carrierwave'
require 'mini_magick'
require 'carrierwave/orm/activerecord'
RSpec.describe Item, type: :model do
  it "has a valid factory" do
    assert FactoryGirl.create(:item).valid?
  end

  it "has none to begin with" do
    expect(Item.count).to eq 0
  end

  it "has one after adding one" do
    item = FactoryGirl.create(:item)
    expect(item.save!).to eq true
  end

  it "is invalid without a name" do
    assert !FactoryGirl.build(:item, name: nil).valid?
  end
  
  it "is invalid without a description" do
    assert !FactoryGirl.build(:item, description: nil).valid?
  end
  
  it "is invalid without a tag_list" do
    assert !FactoryGirl.build(:item, tag_list: nil).valid?
  end
  
  it "is invalid without a user" do
    assert !FactoryGirl.build(:item, user: nil).valid?
  end
  
  it "is invalid with a name too long" do
    assert !FactoryGirl.build(:item, name: "a"*101).valid?
  end
  
   
  it "Name too long" do
    item = FactoryGirl.build(:item, name: ""*101)
    expect(item.valid?).to eq false
  end
  
  it "is invalid without a name during the update" do
	item = FactoryGirl.build(:item) 
	item.update_attributes(:name => nil) 
	expect(item.valid?).to eq false
  end
  
  it "is invalid without a description during the update" do
	item = FactoryGirl.build(:item) 
	item.update_attributes(:description => nil) 
	expect(item.valid?).to eq false
  end  
  
  it "is invalid without a tag_list during the update" do
	item = FactoryGirl.build(:item) 
	item.update_attributes(:tag_list => nil) 
	expect(item.valid?).to eq false
  end
  
  
end
