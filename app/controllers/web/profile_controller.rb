class Web::ProfileController < ApplicationController
  before_action :user_signed_in?

  def show
    @q = Bulletin.where(user: current_user).ransack(params[:q])
    @bulletins = @q.result.page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.json { render json: @resource }
    end
  end
end
