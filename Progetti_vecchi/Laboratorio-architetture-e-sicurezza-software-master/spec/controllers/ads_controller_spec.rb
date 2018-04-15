require 'spec_helper'
require 'rails_helper'

RSpec.describe AdsController, type: :controller do

    describe "GET #show" do
        context "user not banned" do
            login_user
            
            before(:each) do
                dude = FactoryGirl.create(:user, :name => 'Dude', :email => "du@de.com")
                @game = FactoryGirl.create(:game)
                @ad = FactoryGirl.create(:ad)
                
                @game.ads << @ad
                dude.ads << @ad
            end
        
            it "assigns the requested ad to @ad" do
                get :show, game_id: @game, id: @ad
                assigns(:ad).should eq(@ad)
            end
            
            it "assigns the person's name to @person" do
                get :show, game_id: @game, id: @ad
                assigns(:person).should eq(@ad.user.name)
            end
      
            it "renders the #show view" do
                get :show, game_id: @game, id: @ad
                response.should render_template :show
            end
        end
        
        context 'user banned' do
            login_banned
            
            before(:each) do
                @game = FactoryGirl.create(:game)
                @ad = FactoryGirl.create(:ad)
            end
            
            it "should be banned" do
                expect(subject.current_user.role).to eq("Banned")
            end
            
            it "redirect to games_path" do
                get :show, game_id: @game, id: @ad
                response.should redirect_to games_path
            end
        end
    end
    
    describe "GET #new" do
        context 'user logged and ad not present yet' do
            login_user
            
            before(:each) do
                @game = FactoryGirl.create(:game)
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should not have created the ad for the game yet" do
                expect(subject.current_user.ads.any? {|ad| ad.game.id == @game.id}).not_to eq(true)
            end
        
            it "assigns @ad" do
                get :new, game_id: @game
                assigns(:ad).should_not eq(nil)
            end
        end
        
        context 'user logged and ad exists for the game' do
            login_user
            
            before(:each) do
                @game = FactoryGirl.create(:game)
                @ad = FactoryGirl.create(:ad)
                
                @game.ads << @ad
                subject.current_user.ads << @ad
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should have added ad for the game" do
                expect(subject.current_user.ads.any? {|ad| ad.game.id == @game.id}).to eq(true)
            end
        
            it "should redirect to game_reviews_path" do
                get :new, game_id: @game
                response.should redirect_to game_reviews_path(@game)
            end
        end
        
        context 'user not logged' do
        
            before(:each) do
                @game = FactoryGirl.create(:game)
            end
            
            it "renders to games_path" do
                get :new, game_id: @game
                response.should redirect_to game_reviews_path(@game)
            end
        end
        
        context 'user banned' do
            login_banned
            
            before(:each) do
                @game = FactoryGirl.create(:game)
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should be banned" do
                expect(subject.current_user.role).to eq('Banned')
            end
            
            it "renders to games_path" do
                get :new, game_id: @game
                response.should redirect_to game_reviews_path(@game)
            end
        end
    end
    
    describe "POST create" do
        login_user
        
        it "should have a current_user" do
            expect(subject.current_user).to_not eq(nil)
        end
        
        before(:each) do
            @game = FactoryGirl.create(:game)
        end
        
        context "with valid attributes" do
            
            it "creates a new ad" do
                expect{post :create, game_id: @game, ad: FactoryGirl.attributes_for(:ad)}.to change(Ad,:count).by(1)
            end
    
            it "redirects to game_reviews_path" do
                post :create, game_id: @game, ad: FactoryGirl.attributes_for(:ad)
                response.should redirect_to game_reviews_path(@game)
            end
        end
  
        context "with invalid attributes" do
        
            it "does not save the new ad" do
                expect{post :create, game_id: @game, ad: FactoryGirl.attributes_for(:invalid_ad)}.to_not change(Ad,:count)
            end
    
            it "redirect to game_reviews_path" do
                post :create, game_id: @game, ad: FactoryGirl.attributes_for(:invalid_ad)
                response.should redirect_to game_reviews_path(@game)
            end
        end 
    end
    
    describe 'DELETE destroy' do
        context "user logged and ad owner" do
            login_user
            
            before(:each) do
                @game = FactoryGirl.create(:game)
                @ad = FactoryGirl.create(:ad)
                subject.current_user.ads << @ad
                @game.ads << @ad
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should be ad owner" do
                expect(subject.current_user.name == @ad.user.name).to eq(true)
            end
            
            it "deletes the review" do
                expect{delete :destroy, game_id: @game, id: @ad}.to change(Ad,:count).by(-1)
            end
    
            it "redirects to game_reviews_path" do
                delete :destroy, game_id: @game, id: @ad
                response.should redirect_to game_reviews_path(@game)
            end
        end
        
        context 'user logged and not ad owner' do
            login_user
            
            before(:each) do
                another_dude = FactoryGirl.create(:user, :name => 'Another One', :email => "another@email.com")
                @game = FactoryGirl.create(:game)
                @ad = FactoryGirl.create(:ad)
                
                another_dude.ads << @ad
                @game.ads << @ad
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should not be ad owner" do
                expect(subject.current_user.name == @ad.user.name).to eq(false)
            end
            
            it "should not delete ad" do
                expect{delete :destroy, game_id: @game, id: @ad}.to_not change(Ad, :count)
            end
            
            it "should render to game_reviews_path" do
                delete :destroy, game_id: @game, id: @ad
                response.should redirect_to game_reviews_path(@game)
            end
        end
        
        context 'user not logged' do
            before(:each) do
                @game = FactoryGirl.create(:game)
                @ad = FactoryGirl.create(:ad)
            end
            
            it "should not delete ad" do
                expect{delete :destroy, game_id: @game, id: @ad}.to_not change(Ad, :count)
            end
            
            it 'should render to game_reviews_path' do
                delete :destroy, game_id: @game, id: @ad
                response.should redirect_to game_reviews_path(@game)
            end
        end
        
        context 'user is admin' do
            login_admin
            
            before(:each) do
                another_dude = FactoryGirl.create(:user, :name => 'Another One', :email => "another@email.com")
                @game = FactoryGirl.create(:game)
                @ad = FactoryGirl.create(:ad)
                
                another_dude.ads << @ad
                @game.ads << @ad
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should be admin" do
                expect(subject.current_user.role).to eq('Admin')
            end
            
            it "deletes the ad" do
                expect{delete :destroy, game_id: @game, id: @ad}.to change(Ad,:count).by(-1)
            end
    
            it "redirects to game_reviews_path" do
                delete :destroy, game_id: @game, id: @ad
                response.should redirect_to game_reviews_path(@game)
            end
        end
        
        context 'user banned' do
            login_banned
            
            before(:each) do
                @game = FactoryGirl.create(:game)
                @ad = FactoryGirl.create(:ad)
                subject.current_user.ads << @ad
                @game.ads << @ad
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it 'should be banned' do
                expect(subject.current_user.role).to eq('Banned')
            end
            
            it "should not delete ad" do
                expect{delete :destroy, game_id: @game, id: @ad}.to_not change(Ad, :count)
            end
            
            it "should render to game_reviews_path" do
                delete :destroy, game_id: @game, id: @ad
                response.should redirect_to game_reviews_path(@game)
            end
        end
    end

end
