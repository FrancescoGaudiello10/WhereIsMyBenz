Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '285762471795260', 'e16b2626bae56e409d80484cc005a59a',{
  provider_ignores_state: true
  }
end
