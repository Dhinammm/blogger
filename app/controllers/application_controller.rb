class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  #include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  #allow_browser versions: :modern
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end
    #protect_from_forgery with: :null_session
    protect_from_forgery with: :exception, unless: -> { request.path.start_with?('/auth/') }
    # Skip authenticity token verification for OmniAuth
    skip_before_action :verify_authenticity_token, if: -> { request.path.starts_with?('/admin/auth/go') }
end