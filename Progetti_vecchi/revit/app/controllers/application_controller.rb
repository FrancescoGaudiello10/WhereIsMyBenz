class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
   before_action :set_locale
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end
 
 

  
  private

    def set_locale
     I18n.locale = extract_locale_from_tld || I18n.default_locale
   end
 
# Get locale from top-level domain or return nil if such locale is not available
# You have to put something like:
#   127.0.0.1 application.com
#   127.0.0.1 application.it
#   127.0.0.1 application.pl
# in your /etc/hosts file to try this out locally
def extract_locale_from_tld
  parsed_locale = request.host.split('.').last
  I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
end
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms a logged-in owners.
    def logged_in_owner
      unless logged_in_owner?
        store_location
        flash[:danger] = "Please log in."
        redirect_to loginowners_url
      end
    end

end
