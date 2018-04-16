class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url

  end
  def my_review
    @user=User.find(params[:id])
    if current_user==nil ||  @user.id!=current_user.id
    redirect_to users_url
    end


  end
  
  def index
   
    
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC").paginate(page: params[:page]).per_page(10)
    else
       @users = User.paginate(page: params[:page]).per_page(10)
      end
 
  end

  def new
    @user = User.new
  end


  def show
    @user = User.find(params[:id])
    @items = @user.items.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url

      # Handle a successful save.
    else
      render 'new'
    end
  end 

  def edit
    
  end

  def update
    
    if @user.update_attributes(user_params)
      redirect_to current_user
    else
      render 'edit'
    end
  end

  private 
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Before filters

    

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  


end
