require "rails_helper"

RSpec.describe "routes for adds", :type => :routing do

        it "new add" do
            expect(:get => "/adds/new").to route_to(
                      :controller => "adds",
                      :action => "new"
                    )
        end
        
        it "listing adds" do
            expect(:get => "/adds").to route_to(
                      :controller => "adds",
                      :action => "index"
                    )
        end
        
        it "show add" do
            expect(:get => "/adds/1").to route_to(
                      :controller => "adds",
                      :action => "show",
                      :id=>"1"
                    )
        end
        
        it "edit add" do
            expect(:get => "/adds/1/edit").to route_to(
                      :controller => "adds",
                      :action => "edit",
                      :id=>"1"
                    )
        end

        it "destroy add" do 
           expect(:delete => "/adds/1").to route_to(
                      :controller => "adds",
                      :action => "destroy",
                      :id => "1"
                  )
        end

        it "update add" do 
           expect(:put => "/adds/1").to route_to(
                      :controller => "adds",
                      :action => "update",
                      :id => "1"
                  )
        end

        it "create add" do 
           expect(:post => "/adds").to route_to(
                      :controller => "adds",
                      :action => "create",
                      
                  )
        end
                       

             
end
