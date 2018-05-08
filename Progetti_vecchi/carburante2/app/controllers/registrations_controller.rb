#https://github.com/plataformatec/devise/wiki/How-To:-Redirect-to-a-specific-page-on-successful-sign-up-(registration)#1-make-a-new-controller-registrations_controllerrb-and-customize-the-appropriate-method
class RegistrationsController < Devise::RegistrationsController
    protected

    def after_sign_up_path_for(resource)
        profiles_index_path
    end
end
