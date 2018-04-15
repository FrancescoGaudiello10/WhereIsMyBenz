class OwnersController < ApplicationController
  before_action :logged_in_owner, only: [:edit, :update]
  before_action :correct_owner,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @owners = Owner.paginate(page: params[:page])

  end
  
  def show
    @owner = Owner.find(params[:id])
    @adds = @owner.adds.paginate(page: params[:page])

  end
  
  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      @owner.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url

    else
      render 'new'
    end
  end

  def edit
    @owner = Owner.find(params[:id])
  end

  def update
    @owner = Owner.find(params[:id])
    if @owner.update_attributes(owner_params)
      flash[:success] = "Profile updated"
      redirect_to @owner

    else
      render 'edit'
    end
  end

  def destroy
    Owner.find(params[:id]).destroy
    flash[:success] = "Owner deleted"
    redirect_to owners_url
  end

  private

    def owner_params
      params.require(:owner).permit(:name, :email, :website, :description, :address, :password,
                                   :password_confirmation)
    end


    # Before filters

    

    # Confirms the correct owner.
    def correct_owner
      @owner = Owner.find(params[:id])
      redirect_to(root_url) unless current_owner?(@owner)

    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
