class Web::ProfileController < ApplicationController
  before_action :user_signed_in?

  def index
    @q = Bulletin.where(creator: current_user).ransack(params[:q])
    @bulletins = @q.result.page(params[:page]).per(2)
  end
end
