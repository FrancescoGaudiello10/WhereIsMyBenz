require 'rails_helper'

RSpec.describe "prices/index", type: :view do
  before(:each) do
    assign(:prices, [
      Price.create!(
        :idImpianto => "Id Impianto",
        :descCarburante => "Desc Carburante",
        :prezzo => "Prezzo",
        :isSelf => false,
        :dtComu => "Dt Comu"
      ),
      Price.create!(
        :idImpianto => "Id Impianto",
        :descCarburante => "Desc Carburante",
        :prezzo => "Prezzo",
        :isSelf => false,
        :dtComu => "Dt Comu"
      )
    ])
  end

  it "renders a list of prices" do
    render
    assert_select "tr>td", :text => "Id Impianto".to_s, :count => 2
    assert_select "tr>td", :text => "Desc Carburante".to_s, :count => 2
    assert_select "tr>td", :text => "Prezzo".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Dt Comu".to_s, :count => 2
  end
end
