require 'rails_helper'

RSpec.describe FeedbacksController, type: :controller do
  before :each do
    @user = FactoryGirl.create(:user)
  sign_in @user
  end

  it "should create feedback" do
          @feedback = FactoryGirl.create(:feedback)
          post :create, feedback: { receiver: @feedback.receiver, giver: @feedback.giver, value: @feedback.value }, :receiver_id => @feedback.receiver 
          assert_response :redirect
    end

  describe "POST create" do
      context "with valid attributes" do
        
        it "redirects to the new contact" do
          @feedback = FactoryGirl.create(:feedback)
          post :create,  feedback: { receiver: @feedback.receiver, giver: @feedback.giver, value: @feedback.value }, :receiver_id => @feedback.receiver 
          expect(response.status).to eq(302)
        end
      end
      
      context "with invalid attributes" do
        
        it "does not save the new feedback with same giver and receiver" do
          @feedback = FactoryGirl.create(:feedback)
          @feedback.save
          post :create,  feedback: { receiver: @feedback.receiver, giver: @feedback.giver, value: @feedback.value }, :receiver_id => @feedback.receiver 
          expect{
            post :create,  feedback: { receiver: @feedback.receiver, giver: @feedback.giver, value: @feedback.value }, :receiver_id => @feedback.receiver 
          }.to_not change(Feedback,:count)
        end
        
        
        it "re-renders the new method" do
          @feedback = FactoryGirl.create(:feedback)
          post :create, feedback: { receiver: @feedback.receiver, giver: @feedback.giver, value: @feedback.value }, :receiver_id => @feedback.receiver
          post :create, feedback: { receiver: @feedback.receiver, giver: @feedback.giver, value: @feedback.value }, :receiver_id => @feedback.receiver
          expect(response).to redirect_to(@feedback.receiver)
        end
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
