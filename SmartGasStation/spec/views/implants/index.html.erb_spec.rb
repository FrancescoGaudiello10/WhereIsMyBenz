require 'rails_helper'

RSpec.describe "implants/index", type: :view do
  before(:each) do
    assign(:implants, [
      Implant.create!(
        :idImpianto => "Id Impianto",
        :Gestore => "Gestore",
        :Bandiera => "Bandiera",
        :TipoImpianto => "Tipo Impianto",
        :NomeImpianto => "Nome Impianto",
        :Indirizzo => "Indirizzo",
        :Comune => "Comune",
        :Provincia => "Provincia",
        :latitude => 2.5,
        :longitude => 3.5,
        :distance => 4.5
      ),
      Implant.create!(
        :idImpianto => "Id Impianto",
        :Gestore => "Gestore",
        :Bandiera => "Bandiera",
        :TipoImpianto => "Tipo Impianto",
        :NomeImpianto => "Nome Impianto",
        :Indirizzo => "Indirizzo",
        :Comune => "Comune",
        :Provincia => "Provincia",
        :latitude => 2.5,
        :longitude => 3.5,
        :distance => 4.5
      )
    ])
  end

  it "renders a list of implants" do
    render
    assert_select "tr>td", :text => "Id Impianto".to_s, :count => 2
    assert_select "tr>td", :text => "Gestore".to_s, :count => 2
    assert_select "tr>td", :text => "Bandiera".to_s, :count => 2
    assert_select "tr>td", :text => "Tipo Impianto".to_s, :count => 2
    assert_select "tr>td", :text => "Nome Impianto".to_s, :count => 2
    assert_select "tr>td", :text => "Indirizzo".to_s, :count => 2
    assert_select "tr>td", :text => "Comune".to_s, :count => 2
    assert_select "tr>td", :text => "Provincia".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
  end
end
