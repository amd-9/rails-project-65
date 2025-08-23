class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :current_user
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_user
      @user = User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    authorize :user, :signed_in?
  end

  def user_not_authorized
    flash[:alert] = "You need to login or register to perform this action"
    redirect_back_or_to(root_path)
  end
end
