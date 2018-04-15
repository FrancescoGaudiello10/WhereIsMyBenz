require "rails_helper"

RSpec.describe "routes for owners", :type => :routing do

        it "new owner" do
            expect(:get => "/owners/new").to route_to(
                      :controller => "owners",
                      :action => "new"
                    )
        end
        
        it "listing owners" do
            expect(:get => "/owners").to route_to(
                      :controller => "owners",
                      :action => "index"
                    )
        end
        
        it "show owner" do
            expect(:get => "/owners/1").to route_to(
                      :controller => "owners",
                      :action => "show",
                      :id=>"1"
                    )
        end
        
        it "edit owner" do
            expect(:get => "/owners/1/edit").to route_to(
                      :controller => "owners",
                      :action => "edit",
                      :id=>"1"
                    )
        end

        it "destroy owner" do 
           expect(:delete => "/owners/1").to route_to(
                      :controller => "owners",
                      :action => "destroy",
                      :id => "1"
                  )
        end

        it "update owner" do 
           expect(:put => "/owners/1").to route_to(
                      :controller => "owners",
                      :action => "update",
                      :id => "1"
                  )
        end
                       
        it "create owner" do 
           expect(:post => "/owners").to route_to(
                      :controller => "owners",
                      :action => "create",
                      
                  )
        end
             
end
