require 'rails_helper'

RSpec.describe "stations/show", type: :view do
  before(:each) do
    @station = assign(:station, Station.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Bandiera/)
    expect(rendered).to match(/Nome/)
    expect(rendered).to match(/Indirizzo/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/5.5/)
    expect(rendered).to match(/6.5/)
    expect(rendered).to match(/7.5/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
