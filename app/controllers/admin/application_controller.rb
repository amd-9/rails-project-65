class Admin::ApplicationController < ApplicationController
  before_action :authorize_user

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def authorize_user
      authorize :admin, :admin?
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back_or_to(root_path)
  end
end
