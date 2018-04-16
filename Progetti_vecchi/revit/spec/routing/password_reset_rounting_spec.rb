require "rails_helper"

RSpec.describe "routes for password_resets", :type => :routing do

        it "new password_reset" do
            expect(:get => "/password_resets/new").to route_to(
                      :controller => "password_resets",
                      :action => "new"
                    )
        end
        
        it "edit password_reset" do
            expect(:get => "/password_resets/1/edit").to route_to(
                      :controller => "password_resets",
                      :action => "edit",
                      :id=>"1"
                    )
        end


        it "update password_reset" do 
           expect(:put => "/password_resets/1").to route_to(
                      :controller => "password_resets",
                      :action => "update",
                      :id => "1"
                  )
        end            

        it "create password_reset" do 
           expect(:post => "/password_resets").to route_to(
                      :controller => "password_resets",
                      :action => "create",
                      
                  )
        end 

end 
