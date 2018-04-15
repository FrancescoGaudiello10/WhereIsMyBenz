require "rails_helper"

RSpec.describe ReportsController, type: :routing do
  describe "routing" do

    it "new report" do
            expect(:get => "/reports/new").to route_to(
                      :controller => "reports",
                      :action => "new"
                    )
        end
        
        it "listing reports" do
            expect(:get => "/reports").to route_to(
                      :controller => "reports",
                      :action => "index"
                    )
        end
        
        
        
        

        it "destroy report" do 
           expect(:delete => "/reports/1").to route_to(
                      :controller => "reports",
                      :action => "destroy",
                      :id => "1"
                  )
        end

        

        it "create report" do 
           expect(:post => "/reports").to route_to(
                      :controller => "reports",
                      :action => "create",
                      
                  )
        end

  end
end
