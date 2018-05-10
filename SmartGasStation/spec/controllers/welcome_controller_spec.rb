require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  login_user

  it "should have a current_user" do
    expect(subject.current_user).to_not eq(nil)
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to be_successful #have_http_status(:success)
    end

    it "shows an html page" do
      get :index
      expect(response.content_type).to eq "text/html"
    end

    it "renders the home page" do
      get :index
      expect(response).to render_template(:index)
    end

  end

end
