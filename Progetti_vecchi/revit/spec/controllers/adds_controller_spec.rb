require 'rails_helper'

RSpec.describe AddsController, type: :controller do
  require 'rails_helper'


  before :each do
    @owner = FactoryGirl.create(:owner)
  sign_in @owner
  end

  
    
    it "should create add" do
          @add = FactoryGirl.create(:add)
          post :create, add: { name: @add.name, description: @add.description, price: @add.price,  owner: @add.owner }
          assert_response :redirect
    end
    
    
    
    
    it "should delete an add" do
    	@add = FactoryGirl.create(:add)
    	@owner = FactoryGirl.create(:owner)
    	@add.owner = @owner
    	delete :destroy, :id => @add.id
    	assert_response :redirect
    	expect(response).to redirect_to(root_url)
    end
    
    
    
    
    
         
      
    
    
    describe "POST create" do
      context "with valid attributes" do
        
        it "redirects to the new contact" do
          @add = FactoryGirl.create(:add)
          post :create, add: { name: @add.name, description: @add.description, price: @add.price,  owner: @add.owner }
          expect(response.status).to eq(302)
        end
      end
      
      context "with invalid attributes" do
        
        it "does not save the new add without name" do
          @add = FactoryGirl.create(:add)
          expect{
            post :create, add: { name: nil, description: @add.description, price: @add.price,  owner: @add.owner }
          }.to_not change(Add,:count)
        end
        it "does not save the new add without description" do
          @add = FactoryGirl.create(:add)
          expect{
            post :create, add: { name: @add.name, description: nil, price: @add.price,  owner: @add.owner }
          }.to_not change(Add,:count)
        end
        it "does not save the new add without price" do
          @add = FactoryGirl.create(:add)
          expect{
            post :create, add: { name: @add.name, description: @add.description, price: nil,  owner: @add.owner }
          }.to_not change(Add,:count)
        end
        
        
        it "re-renders the new method" do
          @add = FactoryGirl.create(:add)
          post :create, add: { name: nil, description: @add.description, price: nil,  owner: @add.owner }
          expect(response).to redirect_to(root_url)
        end
      end 
    end
    
    describe 'PUT update' do
      before :each do
        @add = FactoryGirl.create(:add)
        @add.owner = @owner
        @add.save
      end
      
      context "valid attributes" do
        it "located the requested @add" do
          put :update, id: @add,add: { name: @add.name, description: @add.description, price: @add.price,  owner: @add.owner }
          expect(assigns(:add)).to eq(@add)      
        end
      
        it "changes @add's attributes" do
          put :update, id: @add, 
            add: { name: "cavallo", description: @add.description, price: @add.price,  owner: @add.owner }
          @add.reload
          expect(@add.name).to eq("cavallo")
        end
      
        it "redirects to the updated owner" do
          put :update, id: @add, add: { name: @add.name, description: @add.description, price: @add.price,  owner: @add.owner }
          expect(response).to redirect_to @owner
        end
      end
      
      context "invalid attributes" do
        it "locates the requested @add" do
          put :update, id: @add, add: { name: nil, description: @add.description, price: @add.price,  owner: @add.owner }
          expect(assigns(:add)).to eq(@add)      
        end
        
        it "does not change @add's attributes" do
          put :update, id: @add, 
            add: { name: "cavallo", description: nil, price: @add.price,  owner: @add.owner }
          @add.reload
          expect(@add.name).not_to eq("cavallo")
        end
        
        it "re-renders the edit method" do
          put :update, id: @add,add: { name: nil, description: @add.description, price: @add.price,  owner: @add.owner }
          expect(response).to render_template :edit
        end
      end
      
      context "not current owner" do
        it "does not change @add's attribute" do
          @add.owner = FactoryGirl.create(:owner)
          @add.save
          put :update, id: @add, add: { name: "prova", description: @add.description, price: @add.price,  owner: @add.owner }
          expect(assigns(:add)).to_not eq(@add)      
        end
        it "render root_url" do
          @add.owner = FactoryGirl.create(:owner)
          @add.save
          put :update, id: @add, add: { name: "prova", description: @add.description, price: @add.price,  owner: @add.owner }
          expect(response).to redirect_to(root_url)     
        end
      end
    end
    
    private
    
    def sign_in(owner)
     session[:owner_id] = owner.id
     current_owner = owner
     @current_owner = owner
    end

    def sign_out
     current_owner = nil
     @current_owner = nil
     cookies.delete(:remember_token)
    end

    def signed_in?
     return !@current_owner.nil?
    end


end
