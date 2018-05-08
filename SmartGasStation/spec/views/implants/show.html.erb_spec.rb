require 'rails_helper'

RSpec.describe "implants/show", type: :view do
  before(:each) do
    @implant = assign(:implant, Implant.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Id Impianto/)
    expect(rendered).to match(/Gestore/)
    expect(rendered).to match(/Bandiera/)
    expect(rendered).to match(/Tipo Impianto/)
    expect(rendered).to match(/Nome Impianto/)
    expect(rendered).to match(/Indirizzo/)
    expect(rendered).to match(/Comune/)
    expect(rendered).to match(/Provincia/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4.5/)
  end
end
