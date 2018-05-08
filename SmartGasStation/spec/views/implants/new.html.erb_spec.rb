require 'rails_helper'

RSpec.describe "implants/new", type: :view do
  before(:each) do
    assign(:implant, Implant.new(
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

  it "renders new implant form" do
    render

    assert_select "form[action=?][method=?]", implants_path, "post" do

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
