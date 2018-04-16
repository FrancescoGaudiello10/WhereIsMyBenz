require "rails_helper"

RSpec.describe "routes for feedbacks", :type => :routing do

        it "new feedback" do
            expect(:get => "/feedbacks/new").to route_to(
                      :controller => "feedbacks",
                      :action => "new"
                    )
        end


        it "create feedback" do 
           expect(:post => "/feedbacks").to route_to(
                      :controller => "feedbacks",
                      :action => "create",
                      
                  )
        end 

end
