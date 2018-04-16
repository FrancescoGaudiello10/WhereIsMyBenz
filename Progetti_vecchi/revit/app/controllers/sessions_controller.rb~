class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    if auth_hash != nil
 
    @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    if @authorization
      user = User.find_by email: auth_hash["info"]["email"]
      log_in user
      redirect_back_or user
    else
      chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ0123456789'
      password = ''
      8.times { password << chars[rand(chars.size)] }
    
      user = User.new :name => auth_hash["info"]["name"], :email => auth_hash["info"]["email"], :password => password , :password_confirmation => password, :activated => TRUE, :activated_at => DateTime.now
      
      user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
      user.save
      log_in user
 
      redirect_back_or user
    end
    else
    
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end

    else
      #messaggio di errore
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
    end
    
  end

  def destroy
    
    log_out if logged_in?
    redirect_to root_url
  end

  def create_own
    owner = Owner.find_by(email: params[:session][:email].downcase)
    if owner && owner.authenticate(params[:session][:password])
        if owner.activated?
        log_in_owner owner
        params[:session][:remember_me] == '1' ? remember(owner) : forget(owner)
        redirect_back_or owner
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end

    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new_own'
    end
  end

  def destroy_own
    log_out_owner if logged_in_owner?
    redirect_to root_url
  end

end
