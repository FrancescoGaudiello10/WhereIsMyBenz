require "rails_helper"

RSpec.describe "routes for static_pages", :type => :routing do

        it "home" do
            expect(:get => "/home").to route_to(
                      :controller => "static_pages",
                      :action => "home"
                    )
        end
end
