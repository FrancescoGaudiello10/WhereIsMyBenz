require 'rails_helper'

RSpec.describe "prices/edit", type: :view do
  before(:each) do
    @price = assign(:price, Price.create!(
      :idImpianto => "MyString",
      :descCarburante => "MyString",
      :prezzo => "MyString",
      :isSelf => false,
      :dtComu => "MyString"
    ))
  end

  it "renders the edit price form" do
    render

    assert_select "form[action=?][method=?]", price_path(@price), "post" do

      assert_select "input[name=?]", "price[idImpianto]"

      assert_select "input[name=?]", "price[descCarburante]"

      assert_select "input[name=?]", "price[prezzo]"

      assert_select "input[name=?]", "price[isSelf]"

      assert_select "input[name=?]", "price[dtComu]"
    end
  end
end
