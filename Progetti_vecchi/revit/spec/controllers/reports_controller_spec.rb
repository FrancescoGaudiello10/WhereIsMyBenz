require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  before :each do
    @user = FactoryGirl.create(:user)
  sign_in @user
  end

  it "should create report" do
          @report = FactoryGirl.create(:report)
          post :create, report: { reporter: @report.reporter, reported: @report.reported}, :reported_id => @report.reported, :reporter_id => @report.reporter 
          assert_response :redirect
    end

  describe "POST create" do
      context "with valid attributes" do
        
        it "redirects to the new contact" do
          @report = FactoryGirl.create(:report)
          post :create,  report: { reporter: @report.reporter, reported: @report.reported}, :reported_id => @report.reported, :reporter_id => @report.reporter 
          expect(response.status).to eq(302)
        end
      end
      
      context "with invalid attributes" do
        
        it "does not save the new report with same giver and receiver" do
          @report = FactoryGirl.create(:report)
          @report.save
          post :create,  report: { reporter: @report.reporter, reported: @report.reported}, :reported_id => @report.reported, :reporter_id => @report.reporter  
          expect{
            post :create,  report: { reporter: @report.reporter, reported: @report.reported}, :reported_id => @report.reported, :reporter_id => @report.reporter 
          }.to_not change(Report,:count)
        end
        
        
        it "re-renders the new method" do
          @report = FactoryGirl.create(:report)
          post :create, report: { reporter: @report.reporter, reported: @report.reported}, :reported_id => @report.reported, :reporter_id => @report.reporter 
          post :create, report: { reporter: @report.reporter, reported: @report.reported}, :reported_id => @report.reported, :reporter_id => @report.reporter 
          expect(response).to redirect_to("/items/1")
        end
      end 
    end

    context "if admin" do 
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in @user
      @user.admin = true
      @user.save
    end

    it "should destroy report" do
        @report = FactoryGirl.create(:report)
        count = Report.count
        delete :destroy, id: @report
        assert_response :redirect
    	expect(Report.count).not_to eq(count)
      end

    it "renders the :index view" do
        get :index
        expect(response).to render_template :index
      end
    end

    context "if not admin" do 
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in @user
      
    end

    it "should not destroy report" do
        @report = FactoryGirl.create(:report)
        count = Report.count
        delete :destroy, id: @report
        assert_response :redirect
    	expect(Report.count).to eq(count)
      end

    it "not renders the :index view" do
        get :index
        expect(response).to redirect_to root_url
      end
  end

  private
    
    def sign_in(user)
     session[:user_id] = user.id
     current_user = user
     @current_user = user
    end

    def sign_out
     current_user = nil
     @current_user = nil
     cookies.delete(:remember_token)
    end

    def signed_in?
     return !@current_user.nil?
    end
end
