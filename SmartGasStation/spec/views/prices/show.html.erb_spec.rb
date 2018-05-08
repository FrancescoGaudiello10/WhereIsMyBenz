require 'rails_helper'

RSpec.describe "prices/show", type: :view do
  before(:each) do
    @price = assign(:price, Price.create!(
      :idImpianto => "Id Impianto",
      :descCarburante => "Desc Carburante",
      :prezzo => "Prezzo",
      :isSelf => false,
      :dtComu => "Dt Comu"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Id Impianto/)
    expect(rendered).to match(/Desc Carburante/)
    expect(rendered).to match(/Prezzo/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Dt Comu/)
  end
end
