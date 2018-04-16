require "rails_helper"

RSpec.describe "routes for sessions", :type => :routing do

        it "new session" do
            expect(:get => "/login").to route_to(
                      :controller => "sessions",
                      :action => "new"
                    )
        end
        
       
        
        
        
        
        it "destroy session" do 
           expect(:delete => "/logout").to route_to(
                      :controller => "sessions",
                      :action => "destroy",
                      
                  )
        end

        

        it "create session" do 
           expect(:post => "/login").to route_to(
                      :controller => "sessions",
                      :action => "create",
                      
                  )
        end

        it "new session owners" do
            expect(:get => "/loginowners").to route_to(
                      :controller => "sessions",
                      :action => "new_own"
                    )
        end
        
       
        
        
        
        
        it "destroy session owners" do 
           expect(:delete => "/logoutowners").to route_to(
                      :controller => "sessions",
                      :action => "destroy_own",
                      
                  )
        end

        

        it "create session owners" do 
           expect(:post => "/loginowners").to route_to(
                      :controller => "sessions",
                      :action => "create_own",
                      
                  )
        end

        it "create session SN" do 
           expect(:get => 'auth/:provider/callback').to route_to(
                      :controller => "sessions",
                      :action => "create",
                      :provider => ":provider"
                  )
        end

        it "destroy session SN" do 
           expect(:get => "/signout").to route_to(
                      :controller => "sessions",
                      :action => "destroy",
                      
                  )
        end
                       

             
end
