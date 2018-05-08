require 'rails_helper'

RSpec.describe "prices/new", type: :view do
  before(:each) do
    assign(:price, Price.new(
      :idImpianto => "MyString",
      :descCarburante => "MyString",
      :prezzo => "MyString",
      :isSelf => false,
      :dtComu => "MyString"
    ))
  end

  it "renders new price form" do
    render

    assert_select "form[action=?][method=?]", prices_path, "post" do

      assert_select "input[name=?]", "price[idImpianto]"

      assert_select "input[name=?]", "price[descCarburante]"

      assert_select "input[name=?]", "price[prezzo]"

      assert_select "input[name=?]", "price[isSelf]"

      assert_select "input[name=?]", "price[dtComu]"
    end
  end
end
