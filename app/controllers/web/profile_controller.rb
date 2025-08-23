class Web::ProfileController < ApplicationController
  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.page(params[:page]).per(2)
  end
end
