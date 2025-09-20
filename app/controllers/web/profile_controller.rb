# frozen_string_literal: true

class Web::ProfileController < Web::ApplicationController
  before_action :user_signed_in?
  before_action :current_user

  def show
    @q = Bulletin.where(user: @current_user).ransack(params[:q])
    @bulletins = @q.result.page(params[:page]).per(10)
  end
end
