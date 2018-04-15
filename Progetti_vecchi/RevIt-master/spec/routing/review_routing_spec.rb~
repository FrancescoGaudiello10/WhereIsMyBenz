require "rails_helper"

RSpec.describe "routes for reviews", :type => :routing do

        it "new review" do
            expect(:get => "/items/1/reviews/new").to route_to(
                      :controller => "reviews",
                      :action => "new",
                      :item_id => "1"
                    )
        end
        
        it "listing reviews for items" do
            expect(:get => "/items/1/reviews").to route_to(
                      :controller => "reviews",
                      :action => "index",
                      :item_id => "1"
                    )
        end
        
        it "show item reviews" do
            expect(:get => "/items/1/reviews/1").to route_to(
                      :controller => "reviews",
                      :action => "show",
                      :item_id => "1",
                      :id=>"1"
                    )
        end
        
        it "edit item review" do
            expect(:get => "/items/1/reviews/1/edit").to route_to(
                      :controller => "reviews",
                      :action => "edit",
                      :item_id => "1",
                      :id=>"1"
                    )
        end

        it "destroy item review" do 
           expect(:delete => "/items/1/reviews/1").to route_to(
                      :controller => "reviews",
                      :action => "destroy",
                      :item_id=> "1",
                      :id => "1"
                  )
        end

        it "update review" do 
           expect(:put => "/items/1/reviews/1").to route_to(
                      :controller => "reviews",
                      :action => "update",
                      :item_id => "1",
                      :id => "1"
                  )
        end

        it "create item review" do 
           expect(:post => "/items/1/reviews").to route_to(
                      :controller => "reviews",
                      :action => "create",
                      :item_id => "1"
                  )
        end
                       

             
end
