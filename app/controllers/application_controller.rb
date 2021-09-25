class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout(:by_resource)

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user, if: :user_signed_in?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_signed_in_is_whitelisted?
    user_signed_in? && current_user.member?
  end
  helper_method :user_signed_in_is_whitelisted?

  private

  def set_current_user
    Current.user = current_user
  end

  def by_resource
    guest? ? "unauthenticated" : "application"
  end

  def guest?
    devise_controller? && !user_signed_in?
  end

  def require_admin_account!
    return if current_user.admin?

    user_not_authorized
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_url)
  end

  def check_minecraft_uuid?
    # Check that the Minecraft UUID for the user isn't nil, if it is make them fill it out
    unless current_user.minecraft_uuid
      flash[:alert] = "We need you to link a Minecraft Account before allowing you to continue."
      redirect_to links_minecraft_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
