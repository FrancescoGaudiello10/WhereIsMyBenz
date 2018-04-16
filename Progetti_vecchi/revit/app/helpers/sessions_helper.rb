module SessionsHelper
 #log in dell'utente dato
 def log_in(user)
   session[:user_id] = user.id
 end
 # Logs in the given owner.
 def log_in_owner(owner)
    session[:owner_id] = owner.id
  end
 
 # ritorna l'utente corrente se esiste
 def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end

 end

 # Returns the user corresponding to the remember token cookie.
  def current_owner
    if (owner_id = session[:owner_id])
      @current_owner ||= Owner.find_by(id: owner_id)
    elsif (owner_id = cookies.signed[:owner_id])
      owner = Owner.find_by(id: owner_id)
      if owner && owner.authenticated?(:remember, cookies[:remember_token])
        log_in_owner owner
        @current_owner = owner
      end
    end
  end

 

 # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Forgets a persistent session.
  def forget_owner(owner)
    owner.forget
    cookies.delete(:owner_id)
    cookies.delete(:remember_token)
  end

 # Returns true if the user is logged in, false otherwise.
 def logged_in?
   !current_user.nil?
 end

 # Returns true if the owner is logged in, false otherwise.
  def logged_in_owner?
    !current_owner.nil?
  end
 
 # Logs out the current user.
 def log_out
   forget(current_user)
   session.delete(:user_id)
   @current_user = nil
 end

 # Logs out the current owner.
  def log_out_owner
    forget(current_owner)
    session.delete(:owner_id)
    @current_owner = nil
  end

 # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Remembers a owner in a persistent session.
  def remember_owner(owner)
    owner.remember
    cookies.permanent.signed[:owner_id] = owner.id
    cookies.permanent[:remember_token] = owner.remember_token
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  # Returns true if the given owner is the current owner.
  def current_owner?(owner)
    owner == current_owner
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
