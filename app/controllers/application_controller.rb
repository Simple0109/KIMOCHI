class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [profile_attributes: [:name]])
  end

  private
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path # ここを好きなパスに変更
  end
end
