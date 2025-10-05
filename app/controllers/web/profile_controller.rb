# frozen_string_literal: true

class Web::ProfileController < Web::ApplicationController
  before_action :user_signed_in?

  def show
    @q = current_user.bulletins.ransack(params[:q])
    @bulletins = @q.result.page(params[:page]).per(10)
  end
end
