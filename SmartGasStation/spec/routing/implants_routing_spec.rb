require "rails_helper"

RSpec.describe ImplantsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/implants").to route_to("implants#index")
    end

    it "routes to #new" do
      expect(:get => "/implants/new").to route_to("implants#new")
    end

    it "routes to #show" do
      expect(:get => "/implants/1").to route_to("implants#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/implants/1/edit").to route_to("implants#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/implants").to route_to("implants#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/implants/1").to route_to("implants#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/implants/1").to route_to("implants#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/implants/1").to route_to("implants#destroy", :id => "1")
    end

  end
end
