class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :current_user
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def current_user
      @user = User.find(session[:user_id]) if session[:user_id]
  end
end
