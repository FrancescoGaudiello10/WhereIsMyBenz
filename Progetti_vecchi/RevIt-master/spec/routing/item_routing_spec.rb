require "rails_helper"

RSpec.describe "routes for items", :type => :routing do

        it "new item" do
            expect(:get => "/items/new").to route_to(
                      :controller => "items",
                      :action => "new"
                    )
        end
        
        it "listing items" do
            expect(:get => "/items").to route_to(
                      :controller => "items",
                      :action => "index"
                    )
        end
        
        it "show item" do
            expect(:get => "/items/1").to route_to(
                      :controller => "items",
                      :action => "show",
                      :id=>"1"
                    )
        end
        
        it "edit item" do
            expect(:get => "/items/1/edit").to route_to(
                      :controller => "items",
                      :action => "edit",
                      :id=>"1"
                    )
        end

        it "destroy item" do 
           expect(:delete => "/items/1").to route_to(
                      :controller => "items",
                      :action => "destroy",
                      :id => "1"
                  )
        end

        it "update item" do 
           expect(:put => "/items/1").to route_to(
                      :controller => "items",
                      :action => "update",
                      :id => "1"
                  )
        end

        it "create item" do 
           expect(:post => "/items").to route_to(
                      :controller => "items",
                      :action => "create",
                      
                  )
        end

        it "item category" do
          expect(:get => "/categories").to route_to(
                      :controller => "items",
                      :action => "categories",
                      
                  )
        end
                       

             
end
