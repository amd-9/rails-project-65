# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  before_action :authorize_user

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def authorize_user
    authorize :user, :admin?
  end

  def user_not_authorized
    flash[:alert] = t('auth.not_authorized')
    redirect_back_or_to(root_path)
  end
end
