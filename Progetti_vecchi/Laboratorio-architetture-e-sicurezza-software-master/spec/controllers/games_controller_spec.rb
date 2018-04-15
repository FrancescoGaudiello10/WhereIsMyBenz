require 'spec_helper'
require 'rails_helper'

RSpec.describe GamesController, type: :controller do
    
    describe "GET #index" do
        it "populates an array of games" do
            game = FactoryGirl.create(:game)
            get :index
            expect(assigns(:games)).to eq([game])
        end
            
        it "renders the :index view" do
            get :index
            response.should render_template :index
        end
    end
    
    describe "GET #new" do
        context 'user logged' do
            login_user
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
        
            it "assigns @game" do
                get :new
                assigns(:game).should_not eq(nil)
            end
        end
        
        context 'user not logged' do
            it "renders to games_path" do
                get :new
                response.should redirect_to games_path
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
            
            it "renders to games_path" do
                get :new
                response.should redirect_to games_path
            end
        end
    end
    
    describe "GET #edit" do
        context 'user logged and game owner' do
            login_user
            
            before(:each) do
                @game = FactoryGirl.create(:game)
                subject.current_user.games << @game
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should be game owner" do
                expect(subject.current_user.games.any? {|game_tmp| game_tmp.name == @game.name}).to eq(true)
            end
        
            it "assigns @game" do
                get :edit, id: @game
                assigns(:game).should eq(@game)
            end
        end
        
        context 'user logged and not game owner' do
            login_user
            
            before(:each) do
                @game = FactoryGirl.create(:game)
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should not be game owner" do
                expect(subject.current_user.games.any? {|game_tmp| game_tmp.name == @game.name}).to eq(false)
            end
        
            it "renders to game_reviews_path" do
                get :edit, id: @game
                response.should redirect_to game_reviews_path(@game)
            end
        end
        
        context 'user not logget' do
            it "renders to game_reviews_path" do
                game = FactoryGirl.create(:game)
                get :edit, id: game
                response.should redirect_to game_reviews_path(game)
            end
        end
        
        context 'user admin' do
            login_admin
            
            before(:each) do
                @game = FactoryGirl.create(:game)
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it 'should be admin' do
                expect(subject.current_user.role).to eq('Admin')
            end
            
            it "assigns @game" do
                get :edit, id: @game
                assigns(:game).should eq(@game)
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
            
            it 'should be banned' do
                expect(subject.current_user.role).to eq('Banned')
            end
            
            it "renders to game_reviews_path" do
                get :edit, id: @game
                response.should redirect_to game_reviews_path(@game)
            end
        end
    end
    
    describe "POST create" do
        login_user
        
        it "should have a current_user" do
            expect(subject.current_user).to_not eq(nil)
        end
        
        context "with valid attributes" do
            it "creates a new game" do
                expect{post :create, game: FactoryGirl.attributes_for(:game)}.to change(Game,:count).by(1)
            end
    
            it "redirects to the games" do
                post :create, game: FactoryGirl.attributes_for(:game)
                response.should redirect_to games_path
            end
        end
  
        context "with invalid attributes" do
            it "does not save the new game" do
                expect{post :create, game: FactoryGirl.attributes_for(:invalid_game)}.to_not change(Game,:count)
            end
    
            it "re-renders the new method" do
                post :create, game: FactoryGirl.attributes_for(:invalid_game)
                response.should render_template :new
            end
        end 
    end
    
    describe 'PUT update' do
        before :each do
            @game = FactoryGirl.create(:game)
        end
  
        context "valid attributes" do
        
            it "located the requested @game" do
                put :update, id: @game, game: FactoryGirl.attributes_for(:game)
                assigns(:game).should eq(@game)      
            end
  
            it "changes @game's attributes" do
                put :update, id: @game, 
                game: FactoryGirl.attributes_for(:game, name: "Another name")
                @game.reload
                @game.name.should eq("Another name")
            end
  
            it "redirects to the game" do
                put :update, id: @game, game: FactoryGirl.attributes_for(:game)
                response.should redirect_to game_reviews_path(@game)
            end
        end
  
        context "invalid attributes" do
            it "locates the requested @game" do
                put :update, id: @game, game: FactoryGirl.attributes_for(:invalid_game)
                assigns(:game).should eq(@game)      
            end
    
            it "does not change @game's attributes" do
                put :update, id: @game, 
                game: FactoryGirl.attributes_for(:game, name: nil)
                @game.reload
                @game.name.should_not eq(nil)
            end
    
            it "re-renders the edit method" do
                put :update, id: @game, game: FactoryGirl.attributes_for(:invalid_game)
                response.should render_template :edit
            end
        end
    end
    
    describe 'DELETE destroy' do
        context "user logged and game owner" do
            login_user
            
            before(:each) do
                @game = FactoryGirl.create(:game)
                subject.current_user.games << @game
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should be game owner" do
                expect(subject.current_user.games.any? {|game_tmp| game_tmp.name == @game.name}).to eq(true)
            end
            
            it "deletes the game" do
                expect{delete :destroy, id: @game}.to change(Game,:count).by(-1)
            end
    
            it "redirects to game#index" do
                delete :destroy, id: @game
                response.should redirect_to games_path
            end
        end
        
        context 'user logged and not game owner' do
            login_user
            
            before(:each) do
                @game = FactoryGirl.create(:game)
            end
            
            it 'should have a current_user' do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should not delete game" do
                expect{delete :destroy, id: @game}.to_not change(Game,:count)
            end
            
            it "should render to game_reviews_path" do
                delete :destroy, id: @game
                response.should redirect_to game_reviews_path(@game)
            end
        end
        
        context 'user not logged' do
            before(:each) do
                @game = FactoryGirl.create(:game)
            end
            
            it "should not delete game" do
                expect{delete :destroy, id: @game}.to_not change(Game,:count)
            end
            
            it 'should render to game_reviews_path' do
                delete :destroy, id: @game
                response.should redirect_to game_reviews_path(@game)
            end
        end
        
        context 'user is admin' do
            login_admin
            
            before(:each) do
                @game = FactoryGirl.create(:game)
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should be admin" do
                expect(subject.current_user.role).to eq('Admin')
            end
            
            it "deletes the game" do
                expect{delete :destroy, id: @game}.to change(Game,:count).by(-1)
            end
    
            it "redirects to game#index" do
                delete :destroy, id: @game
                response.should redirect_to games_path
            end
        end
    end
end
