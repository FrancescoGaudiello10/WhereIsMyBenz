require 'rails_helper'

RSpec.describe "implants/edit", type: :view do
  before(:each) do
    @implant = assign(:implant, Implant.create!(
      :idImpianto => "MyString",
      :Gestore => "MyString",
      :Bandiera => "MyString",
      :TipoImpianto => "MyString",
      :NomeImpianto => "MyString",
      :Indirizzo => "MyString",
      :Comune => "MyString",
      :Provincia => "MyString",
      :latitude => 1.5,
      :longitude => 1.5,
      :distance => 1.5
    ))
  end

  it "renders the edit implant form" do
    render

    assert_select "form[action=?][method=?]", implant_path(@implant), "post" do

      assert_select "input[name=?]", "implant[idImpianto]"

      assert_select "input[name=?]", "implant[Gestore]"

      assert_select "input[name=?]", "implant[Bandiera]"

      assert_select "input[name=?]", "implant[TipoImpianto]"

      assert_select "input[name=?]", "implant[NomeImpianto]"

      assert_select "input[name=?]", "implant[Indirizzo]"

      assert_select "input[name=?]", "implant[Comune]"

      assert_select "input[name=?]", "implant[Provincia]"

      assert_select "input[name=?]", "implant[latitude]"

      assert_select "input[name=?]", "implant[longitude]"

      assert_select "input[name=?]", "implant[distance]"
    end
  end
end
