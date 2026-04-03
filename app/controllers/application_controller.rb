class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  #allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    two_factor_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  # Call this before_action on any controller that requires a verified session
  def require_two_factor_verification
    return unless user_signed_in?
    redirect_to two_factor_path unless session[:two_factor_verified]
  end
end
