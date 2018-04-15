require 'spec_helper'
require 'rails_helper'

RSpec.describe ResponsesController, type: :controller do
    
    describe "GET #index" do
        context 'user not banned' do
            login_user
            
            before(:each) do
                another_dude = FactoryGirl.create(:user, :name => 'Another One', :email => "another@email.com")
                @ad = FactoryGirl.create(:ad)
                response = FactoryGirl.create(:response)
                
                subject.current_user.ads << @ad
                @ad.responses << response
                another_dude.responses << response
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should not be banned" do
                expect(subject.current_user.role).to_not eq('Banned')
            end
            
            it "populates arrays of responses for user's ads" do
                responses = []
                subject.current_user.ads.each do |ad|
                    ad.responses.each do |response|
                        responses.append(response)
                    end
                end
                get :index
                expect(assigns(:responses)).to eq(responses)
            end
            
            it "renders the :index view" do
                get :index
                response.should render_template :index
            end
        end
        
        context 'user banned' do
            login_banned
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should be banned" do
                expect(subject.current_user.role).to eq('Banned')
            end
            
            it "should redirect to games_path" do
                get :index
                response.should redirect_to games_path
            end
        end
    end
    
    describe "GET #show" do
        context "user not banned" do
            login_user
            
            before(:each) do
                another_dude = FactoryGirl.create(:user, :name => 'Another One', :email => "another@email.com")
                @ad = FactoryGirl.create(:ad)
                @myresponse = FactoryGirl.create(:response)
                
                subject.current_user.ads << @ad
                @ad.responses << @myresponse
                another_dude.responses << @myresponse
            end
            
            it "should not be banned" do
                expect(subject.current_user.role).to_not eq("Banned")
            end
        
            it "assigns the requested response to @response" do
                get :show, id: @myresponse
                assigns(:response).should eq(@myresponse)
            end
      
            it "renders the #show view" do
                get :show, id: @myresponse
                response.should render_template :show
            end
        end
        
        context 'user banned' do
            login_banned
            
            it "should be banned" do
                expect(subject.current_user.role).to eq("Banned")
            end
            
            it "redirect to games_path" do
                get :show, id: FactoryGirl.create(:response)
                response.should redirect_to games_path
            end
        end
    end
    
    describe "POST create" do
        context 'user logged and not responded yet' do
        
            login_user
            
            before(:each) do
                game = FactoryGirl.create(:game)
                @ad = FactoryGirl.create(:ad)
                
                game.ads << @ad
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should not be banned" do
                expect(subject.current_user.role).to_not eq("Banned")
            end
            
            it "should not have responded to the ad yet" do
                expect(subject.current_user.responses.any? {|response| response.ad.id == @ad.id}).not_to eq(true)
            end
            
            it "creates a new response" do
                expect{post :create, ad_id: @ad, response: FactoryGirl.attributes_for(:response)}.to change(Response,:count).by(1)
            end
    
            it "redirects to game_reviews_path" do
                post :create, ad_id: @ad, response: FactoryGirl.attributes_for(:response)
                response.should redirect_to game_reviews_path(@ad.game)
            end
        
        end
        
        context 'user logged and responded yet' do
        
            login_user
            
            before(:each) do
                game = FactoryGirl.create(:game)
                @ad = FactoryGirl.create(:ad)
                @myresponse = FactoryGirl.create(:response)
                
                game.ads << @ad
                @ad.responses << @myresponse
                subject.current_user.responses << @myresponse
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should not be banned" do
                expect(subject.current_user.role).to_not eq("Banned")
            end
            
            it "should have responded to the ad yet" do
                expect(subject.current_user.responses.any? {|response| response.ad.id == @ad.id}).to eq(true)
            end
            
            it "does not creates a new response" do
                expect{post :create, ad_id: @ad, response: FactoryGirl.attributes_for(:response)}.to_not change(Response,:count)
            end
    
            it "redirects to game_reviews_path" do
                post :create, ad_id: @ad, response: FactoryGirl.attributes_for(:response)
                response.should redirect_to game_reviews_path(@ad.game)
            end
        
        end
        
        context 'user not logged' do
        
            before(:each) do
                game = FactoryGirl.create(:game)
                @ad = FactoryGirl.create(:ad)
                
                game.ads << @ad
            end
            
            it "does not creates a new response" do
                expect{post :create, ad_id: @ad, response: FactoryGirl.attributes_for(:response)}.to_not change(Response,:count)
            end
            
            it "renders to game_reviews_path" do
                post :create, ad_id: @ad, response: FactoryGirl.attributes_for(:response)
                response.should redirect_to game_reviews_path(@ad.game)
            end
        end
        
        context "user banned" do
            
            login_banned
            
            before(:each) do
                game = FactoryGirl.create(:game)
                @ad = FactoryGirl.create(:ad)
                
                game.ads << @ad
            end
            
            it "should be banned" do
                expect(subject.current_user.role).to eq("Banned")
            end
            
            it "does not creates a new response" do
                expect{post :create, ad_id: @ad, response: FactoryGirl.attributes_for(:response)}.to_not change(Response,:count)
            end
            
            it "renders to game_reviews_path" do
                post :create, ad_id: @ad, response: FactoryGirl.attributes_for(:response)
                response.should redirect_to game_reviews_path(@ad.game)
            end
        end
    end
    
    describe 'DELETE destroy' do
        
        context 'user logged' do
            login_user
            
            before(:each) do
                @myresponse = FactoryGirl.create(:response)
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should delete response" do
                expect{delete :destroy, id: @myresponse}.to change(Response, :count).by(-1)
            end
            
            it "should render to responses_path" do
                delete :destroy, id: @myresponse
                response.should redirect_to responses_path
            end
        end
        
        context 'user not logged' do
            
            before(:each) do
                @myresponse = FactoryGirl.create(:response)
            end
            
            it "should not delete response" do
                expect{delete :destroy, id: @myresponse}.to_not change(Response,:count)
            end
            
            it 'should render to game_review_path' do
                delete :destroy, id: FactoryGirl.create(:response)
                response.should redirect_to games_path
            end
        end
        
        context 'user is admin' do
            login_admin
            
            before(:each) do
                @myresponse = FactoryGirl.create(:response)
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should be admin" do
                expect(subject.current_user.role).to eq('Admin')
            end
            
            it "deletes the response" do
                expect{delete :destroy, id: @myresponse}.to change(Response,:count).by(-1)
            end
    
            it "redirects to responses_path" do
                delete :destroy, id: @myresponse
                response.should redirect_to responses_path
            end
        end
        
        context 'user banned' do
            login_banned
            
            before(:each) do
                @myresponse = FactoryGirl.create(:response)
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it 'should be banned' do
                expect(subject.current_user.role).to eq('Banned')
            end
            
            it "should not delete response" do
                expect{delete :destroy, id: @myresponse}.to_not change(Response,:count)
            end
            
            it 'should render to games_path' do
                delete :destroy, id: @myresponse
                response.should redirect_to games_path
            end
        end
    end
end
