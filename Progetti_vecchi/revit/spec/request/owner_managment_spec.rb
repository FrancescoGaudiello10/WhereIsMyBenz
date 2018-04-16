require "rails_helper"
require 'rails-i18n'
RSpec.describe "owner management", :type => :request do
  
  it "after signup redirect to the home page" do
    visit "/signupowners"
    #dev = FactoryGirl.create(:owner)
    find('#owner_name', visible: false).set 'Matteo'
    fill_in "Website" , :with => "www.ok.it"
    find('#owner_description', visible: false).set "siamo aperti"
    find('#owner_address', visible: false).set :with => "velletri"
    fill_in "Email", :with => "mhfdgdj@gmail.com"
    fill_in "Password", :with => "muromuro"
    fill_in "Confirmation", :with => "muromuro"
    
    click_button "Create"

    expect(current_path).to eq (root_path)
    #expect(page).to have_content "Now let's set up your skills"
    #expect(page).to have_css("h1", text: "Now let's set up your skills")
    
  end
  
  it "invalid signup (name too long)" do
    visit "/signupowners"
    #dev = FactoryGirl.create(:owner)
    find('#owner_name', visible: false).set  "Maaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    fill_in "Website" , :with => "www.ok.it"
    find('#owner_description', visible: false).set "siamo aperti"
    find('#owner_address', visible: false).set  "velletri"
    fill_in "Email", :with => "mhfdgdj@gmail.com"
    fill_in "Password", :with => "muromuro"
    fill_in "Confirmation", :with => "muromuro"
    click_button "Create"

    expect(current_path).to eq "/owners"
    
    #expect(page).to have_css("h1", text: "Now let's set up your skills")
    
  end
  

    
  
  
  
  
  
  
  it "invalid signup (Password confirmation doesn't match Password)" do
    visit "signupowners"
    #dev = FactoryGirl.create(:owner)
    find('#owner_name', visible: false).set  "matteo"
    fill_in "Website" , :with => "www.ok.it"
    find('#owner_description', visible: false).set  "siamo aperti"
    find('#owner_address', visible: false).set  "velletri"
    fill_in "Email", :with => "mhfdgdj@gmail.com"
    fill_in "Password", :with => "muromuro"
    fill_in "Confirmation", :with => "muromuroo"
    click_button "Create"
    expect(current_path).to eq "/owners"

    
  end
  
  it "logout -> signin, login -> home " do
    visit "/signupowners"
    #dev = FactoryGirl.create(:owner)
    find('#owner_name', visible: false).set  "Matteo"
    fill_in "Website" , :with => "www.ok.it"
    find('#owner_description', visible: false).set  "siamo aperti"
    find('#owner_address', visible: false).set  "velletri"
    fill_in "Email", :with => "mhfdgdj@gmail.com"
    fill_in "Password", :with => "muromuro"
    fill_in "Confirmation", :with => "muromuro"
    click_button "Create"
    
    
    delete "/logoutowners"
    expect(current_path).to eq(root_path)
    
    visit "/loginowners"
    fill_in "Email", :with => "mhfdgdj@gmail.com"
    fill_in "Password", :with => "muromuro"
    click_button "Log in"

    expect(current_path).to eq(root_path)
  end

end
