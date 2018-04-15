require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  before :each do
    @user = FactoryGirl.create(:user)
  sign_in @user
  end

  it "should show item" do
          @item = FactoryGirl.create(:item)
          get :show, :id => @item
          assert_response :success
    end
    
    it "should create item" do
          @item = FactoryGirl.create(:item)
          post :create, item: { name: @item.name, description: @item.description, store_location: @item.store_location, tag_list: @item.tag_list, user: @item.user }
          assert_response :redirect
    end
    
    
    
    
    it "should delete an item" do
    	@item = FactoryGirl.create(:item)
    	@user = FactoryGirl.create(:user)
    	@item.user = @user
    	delete :destroy, :id => @item.id
    	assert_response :redirect
    	expect(response).to redirect_to(root_url)
    end
    
    
    
    
    
         
      it "renders the :index view" do
        get :index
        expect(response).to render_template :index
      end
    
    
    describe "POST create" do
      context "with valid attributes" do
        
        it "redirects to the new contact" do
          @item = FactoryGirl.create(:item)
          post :create, item: { name: @item.name, description: @item.description, store_location: @item.store_location, tag_list: @item.tag_list, user: @item.user }
          expect(response.status).to eq(302)
        end
      end
      
      context "with invalid attributes" do
        
        it "does not save the new item without name" do
          @item = FactoryGirl.create(:item)
          expect{
            post :create, item: { name: nil, description: "porto", store_location: "cagliari", tag_list: @item.tag_list, user: @user }
          }.to_not change(Item,:count)
        end
        it "does not save the new item without description" do
          @item = FactoryGirl.create(:item)
          expect{
            post :create, item: { name: "cavallo", description: nil, store_location: "cagliari", tag_list: @item.tag_list, user: @user }
          }.to_not change(Item,:count)
        end
        it "does not save the new item without taglist" do
          
          expect{
            post :create, item: { name: "cavallo", description: "porto", store_location: "cagliari", tag_list: nil, user: @user }
          }.to_not change(Item,:count)
        end
        
        
        it "re-renders the new method" do
          @item = FactoryGirl.create(:item)
          post :create, item: { name: @item.name, description: @item.description, store_location: @item.store_location, tag_list: nil, user:nil }
          expect(response).to redirect_to(root_url)
        end
      end 
    end
    
    describe 'PUT update' do
      before :each do
        @item = FactoryGirl.create(:item)
      end
      
      context "valid attributes" do
        it "located the requested @item" do
          put :update, id: @item, item: { name: @item.name, description: @item.description, store_location: @item.store_location, tag_list: @item.tag_list, user: @item.user }
          expect(assigns(:item)).to eq(@item)      
        end
      
        it "changes @item's attributes" do
          put :update, id: @item, 
            item: { name: "cavallo", description: @item.description, store_location: @item.store_location, tag_list: @item.tag_list, user: @item.user }
          @item.reload
          expect(@item.name).to eq("cavallo")
        end
      
        it "redirects to the updated item" do
          put :update, id: @item, item: { name: @item.name, description: @item.description, store_location: @item.store_location, tag_list: @item.tag_list, user: @item.user }
          expect(response).to redirect_to @item
        end
      end
      
      context "invalid attributes" do
        it "locates the requested @item" do
          put :update, id: @item, item: { name: @item.name, description: @item.description, store_location: @item.store_location, tag_list: @item.tag_list, user:nil }
          expect(assigns(:item)).to eq(@item)      
        end
        
        it "does not change @item's attributes" do
          put :update, id: @item, 
            item: { name: "cavallo", description: @item.description, store_location: @item.store_location, tag_list: nil, user: nil }
          @item.reload
          expect(@item.name).not_to eq("cavallo")
        end
        
        it "re-renders the edit method" do
          put :update, id: @item, item: { name: @item.name, description: @item.description, store_location: @item.store_location, tag_list: nil, user: nil }
          expect(response).to render_template :edit
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
