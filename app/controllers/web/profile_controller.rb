class Web::ProfileController < ApplicationController
  def index
    @q = Bulletin.where(creator: current_user).ransack(params[:q])
    @bulletins = @q.result.page(params[:page]).per(2)
  end
end
