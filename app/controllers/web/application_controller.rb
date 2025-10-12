# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  include Pundit::Authorization

  helper_method :current_user

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_user
    return @current_user if defined?(@current_user)

    @current_user = User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    redirect_to root_path, alert: t('auth.not_logged_in') if session[:user_id].nil?
  end

  def user_not_authorized
    flash[:alert] = t('auth.not_authorized')
    redirect_back_or_to(root_path)
  end
end
