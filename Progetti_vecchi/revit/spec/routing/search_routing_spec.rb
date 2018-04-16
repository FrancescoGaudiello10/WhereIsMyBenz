require "rails_helper"

RSpec.describe "routes for searchs", :type => :routing do




        it "listing searchs" do
            expect(:get => "/search/index").to route_to(
                      :controller => "search",
                      :action => "index"
                    )
        end

end
