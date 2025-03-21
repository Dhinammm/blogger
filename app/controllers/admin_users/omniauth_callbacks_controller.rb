class AdminUsers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
   
  skip_before_action :verify_authenticity_token, only: [:google_oauth2]
    def google_oauth2
      puts '333333333333333333333333333333333333333333'
    @admin_user = AdminUser.from_omniauth(request.env['omniauth.auth'])

    if @admin_user
      sign_in_and_redirect @admin_user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      redirect_to new_admin_user_session_path, alert: "Access Denied"
    end
  end

  def failure
    redirect_to new_admin_user_session_path, alert: "Authentication failed"
  end
end

