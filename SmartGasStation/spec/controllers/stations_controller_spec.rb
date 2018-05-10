require 'rails_helper'

RSpec.describe StationsController, type: :controller do

    login_user

    describe "GET index" do
        it "renders the stations list" do
            get :index
            expect(response).to render_template(:index)
        end
    end

    describe "Create a new station" do
        it "renders the new page" do
            get :new
            expect(response).to render_template(:new)
        end

        it "creates the station" do
            post :create,
                 params: {
                     station: {
                         Bandiera: "ESSO",
                         Nome: "Mario ROssi",
                         Indirizzo: "Via Ariosto 22, Roma",
                         Benzina: "1.578", Diesel: "1.389", Super: "", Excellium: "", Metano: "0.579", GPL: "",
                         allDay: "", Self: "", autoLavaggio: ""
                     }}
            expect(response).to redirect_to('/stations/1')
        end
    end

end
