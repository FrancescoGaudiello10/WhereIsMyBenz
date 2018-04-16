class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user == nil
      owner = Owner.find_by(email: params[:email])
    if owner && !owner.activated? && owner.authenticated?(:activation, params[:id])
      owner.activate
      log_in_owner owner
      flash[:success] = "Account activated!"
      redirect_to owner
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
    else
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated,    true)
      user.update_attribute(:activated_at, Time.zone.now)
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
    end
  end

  
end
