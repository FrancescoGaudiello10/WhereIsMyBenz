require "rails_helper"

RSpec.describe "routes for contacts", :type => :routing do

        it "new contact" do
            expect(:get => "/contacts/new").to route_to(
                      :controller => "contacts",
                      :action => "new"
                    )
        end
        
        it "listing contacts" do
            expect(:get => "/contacts").to route_to(
                      :controller => "contacts",
                      :action => "index"
                    )
        end
        
        it "show contact" do
            expect(:get => "/contacts/1").to route_to(
                      :controller => "contacts",
                      :action => "show",
                      :id=>"1"
                    )
        end
        
        it "edit contact" do
            expect(:get => "/contacts/1/edit").to route_to(
                      :controller => "contacts",
                      :action => "edit",
                      :id=>"1"
                    )
        end

        it "destroy contact" do 
           expect(:delete => "/contacts/1").to route_to(
                      :controller => "contacts",
                      :action => "destroy",
                      :id => "1"
                  )
        end

        it "update contact" do 
           expect(:put => "/contacts/1").to route_to(
                      :controller => "contacts",
                      :action => "update",
                      :id => "1"
                  )
        end

        it "create contact" do 
           expect(:post => "/contacts").to route_to(
                      :controller => "contacts",
                      :action => "create",
                      
                  )
        end
                       

             
end
