require 'spec_helper'
require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
    
    describe "GET #index" do
        context 'user not banned' do
            login_user
            
            before(:each) do
                @game = FactoryGirl.create(:game)
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should not be banned" do
                expect(subject.current_user.role).to_not eq('Banned')
            end
        
            it "located the requested @game" do
                get :index, game_id: @game
                assigns(:game).should eq(@game)      
            end
            
            it "populates arrays of reviews of game" do
                review = FactoryGirl.create(:review)
                @game.reviews << review
                get :index, game_id: @game
                expect(assigns(:reviews)).to eq(@game.reviews)
            end
            
            it "populates array of ads of game" do
                ad = FactoryGirl.create(:ad)
                @game.ads << ad
                get :index, game_id: @game
                expect(assigns(:ads)).to eq(@game.ads)
            end
            
            it "calculates avarage rating" do
                get :index, game_id: @game
                expect(assigns(:avarage)).to_not eq(nil)
            end
            
            it "renders the :index view" do
                get :index, game_id: @game
                response.should render_template :index
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
            
            it "should redirect to games_path" do
                get :index, game_id: @game
                response.should redirect_to games_path
            end
        end
    end
    
    describe "GET #show" do
        context "user not banned" do
            login_user
            
            before(:each) do
                @game = FactoryGirl.create(:game)
                @review = FactoryGirl.create(:review)
            end
        
            it "assigns the requested review to @review" do
                subject.current_user.reviews << @review
                get :show, game_id: @game, id: @review
                assigns(:review).should eq(@review)
            end
      
            it "renders the #show view" do
                subject.current_user.reviews << @review
                get :show, game_id: @game, id: @review
                response.should render_template :show
            end
        end
        
        context 'user banned' do
            login_banned
            
            before(:each) do
                @game = FactoryGirl.create(:game)
                @review = FactoryGirl.create(:review)
            end
            
            it "should be banned" do
                expect(subject.current_user.role).to eq("Banned")
            end
            
            it "redirect to games_path" do
                get :show, game_id: @game, id: @review
                response.should redirect_to games_path
            end
        end
    end
    
    describe "GET #new" do
        context 'user logged and game not reviewed' do
            login_user
            
            before(:each) do
                @game = FactoryGirl.create(:game)
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should not be banned" do
                expect(subject.current_user.role).to_not eq("Banned")
            end
            
            it "should not have reviewed the game yet" do
                expect(subject.current_user.reviews.any? {|review| review.game.name == @game.name}).not_to eq(true)
            end
        
            it "assigns @review" do
                get :new, game_id: @game
                assigns(:game).should_not eq(nil)
            end
        end
        
        context 'user logged and game reviewed' do
            login_user
            
            before(:each) do
                @game = FactoryGirl.create(:game)
                subject.current_user.reviews << @game.reviews.build(FactoryGirl.attributes_for(:review))
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should not be banned" do
                expect(subject.current_user.role).to_not eq("Banned")
            end
            
            it "should have reviewed the game yet" do
                expect(subject.current_user.reviews.any? {|review| review.game.name == @game.name}).to eq(true)
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

    describe "GET #edit" do
        context 'user logged and review owner' do
            login_user
            
            before(:each) do
                @game = FactoryGirl.create(:game)
                @review = FactoryGirl.create(:review)
                subject.current_user.reviews << @review
                @game.reviews << @review
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should be review owner" do
                expect(subject.current_user.name == @review.user.name).to eq(true)
            end
        
            it "assigns @review" do
                get :edit, game_id: @game, id: @review
                assigns(:review).should eq(@review)
            end
        end
        
        context 'user logged and not review owner' do
            login_user
            
            before(:each) do
                another_dude = FactoryGirl.create(:user, :name => 'Another One', :email => "another@email.com")
                @game = FactoryGirl.create(:game)
                @review = FactoryGirl.create(:review)
                
                another_dude.reviews << @review
                @game.reviews << @review
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should not be review owner" do
                expect(subject.current_user.name == @review.user.name).to eq(false)
            end
        
            it "renders to game_reviews_path" do
                get :edit, game_id: @game, id: @review
                response.should redirect_to game_reviews_path(@game)
            end
        end
        
        context 'user not logget' do
        
            it "renders to game_reviews_path" do
                game = FactoryGirl.create(:game)
                review = FactoryGirl.create(:review)
                get :edit, game_id: game, id: review
                response.should redirect_to game_reviews_path(game)
            end
        end
        
        context 'user admin' do
            login_admin
            
            before(:each) do
                another_dude = FactoryGirl.create(:user, :name => 'Another One', :email => "another@email.com")
                @game = FactoryGirl.create(:game)
                @review = FactoryGirl.create(:review)
                
                another_dude.reviews << @review
                @game.reviews << @review
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it 'should be admin' do
                expect(subject.current_user.role).to eq('Admin')
            end
            
            it "assigns @review" do
                get :edit, game_id: @game, id: @review
                assigns(:review).should eq(@review)
            end
        end
        
        context 'user banned' do
            login_banned
            
            before(:each) do
                @game = FactoryGirl.create(:game)
                @review = FactoryGirl.create(:review)
                subject.current_user.reviews << @review
                @game.reviews << @review
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it 'should be banned' do
                expect(subject.current_user.role).to eq('Banned')
            end
            
            it "renders to game_reviews_path" do
                get :edit, game_id: @game, id: @review
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
            
            it "creates a new review" do
                expect{post :create, game_id: @game, review: FactoryGirl.attributes_for(:review)}.to change(Review,:count).by(1)
            end
    
            it "redirects to game_reviews_path" do
                post :create, game_id: @game, review: FactoryGirl.attributes_for(:review)
                response.should redirect_to game_reviews_path(@game)
            end
        end
  
        context "with invalid attributes" do
        
            it "does not save the new review" do
                expect{post :create, game_id: @game, review: FactoryGirl.attributes_for(:invalid_review)}.to_not change(Review,:count)
            end
    
            it "redirect to game_reviews_path" do
                post :create, game_id: @game, review: FactoryGirl.attributes_for(:invalid_review)
                response.should redirect_to game_reviews_path(@game)
            end
        end 
    end
    
    describe 'PUT update' do
        before :each do
            @game = FactoryGirl.create(:game)
            @review = FactoryGirl.create(:review)
        end
  
        context "valid attributes" do
        
            it "located the requested @review" do
                put :update, game_id: @game, id: @review, review: FactoryGirl.attributes_for(:review)
                assigns(:review).should eq(@review)      
            end
  
            it "changes @review's attributes" do
                put :update, game_id: @game, id: @review,
                review: FactoryGirl.attributes_for(:review, description: "Another description")
                @review.reload
                @review.description.should eq("Another description")
            end
  
            it "redirects to game_reviews_path" do
                put :update, game_id: @game, id: @review, review: FactoryGirl.attributes_for(:review)
                response.should redirect_to game_reviews_path(@game)
            end
        end
  
        context "invalid attributes" do
            it "locates the requested @game" do
                put :update, game_id: @game, id: @review, review: FactoryGirl.attributes_for(:invalid_review)
                assigns(:review).should eq(@review)      
            end
    
            it "does not change @game's attributes" do
                put :update, game_id: @game, id: @review,
                review: FactoryGirl.attributes_for(:review, description: nil)
                @review.reload
                @review.description.should_not eq(nil)
            end
    
            it "re-render template edit" do
                put :update, game_id: @game, id: @review, review: FactoryGirl.attributes_for(:invalid_review)
                response.should render_template :edit
            end
        end
    end
    
    describe 'DELETE destroy' do
        context "user logged and review owner" do
            login_user
            
            before(:each) do
                @game = FactoryGirl.create(:game)
                @review = FactoryGirl.create(:review)
                subject.current_user.reviews << @review
                @game.reviews << @review
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should be review owner" do
                expect(subject.current_user.name == @review.user.name).to eq(true)
            end
            
            it "deletes the review" do
                expect{delete :destroy, game_id: @game, id: @review}.to change(Review,:count).by(-1)
            end
    
            it "redirects to game_reviews_path" do
                delete :destroy, game_id: @game, id: @review
                response.should redirect_to game_reviews_path(@game)
            end
        end
        
        context 'user logged and not review owner' do
            login_user
            
            before(:each) do
                another_dude = FactoryGirl.create(:user, :name => 'Another One', :email => "another@email.com")
                @game = FactoryGirl.create(:game)
                @review = FactoryGirl.create(:review)
                
                another_dude.reviews << @review
                @game.reviews << @review
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should not be review owner" do
                expect(subject.current_user.name == @review.user.name).to eq(false)
            end
            
            it "should not delete review" do
                expect{delete :destroy, game_id: @game, id: @review}.to_not change(Review,:count)
            end
            
            it "should render to game_review_path" do
                delete :destroy, game_id: @game, id: @review
                response.should redirect_to game_review_path(@game, @review)
            end
        end
        
        context 'user not logged' do
            before(:each) do
                @game = FactoryGirl.create(:game)
                @review = FactoryGirl.create(:review)
            end
            
            it "should not delete review" do
                expect{delete :destroy, game_id: @game, id: @review}.to_not change(Review,:count)
            end
            
            it 'should render to game_review_path' do
                delete :destroy, game_id: @game, id: @review
                response.should redirect_to game_review_path(@game, @review)
            end
        end
        
        context 'user is admin' do
            login_admin
            
            before(:each) do
                another_dude = FactoryGirl.create(:user, :name => 'Another One', :email => "another@email.com")
                @game = FactoryGirl.create(:game)
                @review = FactoryGirl.create(:review)
                
                another_dude.reviews << @review
                @game.reviews << @review
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it "should be admin" do
                expect(subject.current_user.role).to eq('Admin')
            end
            
            it "deletes the review" do
                expect{delete :destroy, game_id: @game, id: @review}.to change(Review,:count).by(-1)
            end
    
            it "redirects to game_reviews_path" do
                delete :destroy, game_id: @game, id: @review
                response.should redirect_to game_reviews_path(@game)
            end
        end
        
        context 'user banned' do
            login_banned
            
            before(:each) do
                @game = FactoryGirl.create(:game)
                @review = FactoryGirl.create(:review)
                subject.current_user.reviews << @review
                @game.reviews << @review
            end
            
            it "should have a current_user" do
                expect(subject.current_user).to_not eq(nil)
            end
            
            it 'should be banned' do
                expect(subject.current_user.role).to eq('Banned')
            end
            
            it "should not delete review" do
                expect{delete :destroy, game_id: @game, id: @review}.to_not change(Review,:count)
            end
            
            it "should render to game_review_path" do
                delete :destroy, game_id: @game, id: @review
                response.should redirect_to game_review_path(@game, @review)
            end
        end
    end
end
