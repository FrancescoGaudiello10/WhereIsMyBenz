require 'rails_helper'

RSpec.describe "stations/index", type: :view do
  before(:each) do
    assign(:stations, [
      Station.create!(
        :Bandiera => "Bandiera",
        :Nome => "Nome",
        :Indirizzo => "Indirizzo",
        :Benzina => 2.5,
        :Diesel => 3.5,
        :Super => 4.5,
        :Excellium => 5.5,
        :Metano => 6.5,
        :GPL => 7.5,
        :allDay => false,
        :Self => false,
        :autoLavaggio => false
      ),
      Station.create!(
        :Bandiera => "Bandiera",
        :Nome => "Nome",
        :Indirizzo => "Indirizzo",
        :Benzina => 2.5,
        :Diesel => 3.5,
        :Super => 4.5,
        :Excellium => 5.5,
        :Metano => 6.5,
        :GPL => 7.5,
        :allDay => false,
        :Self => false,
        :autoLavaggio => false
      )
    ])
  end

  it "renders a list of stations" do
    render
    assert_select "tr>td", :text => "Bandiera".to_s, :count => 2
    assert_select "tr>td", :text => "Nome".to_s, :count => 2
    assert_select "tr>td", :text => "Indirizzo".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => 5.5.to_s, :count => 2
    assert_select "tr>td", :text => 6.5.to_s, :count => 2
    assert_select "tr>td", :text => 7.5.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
