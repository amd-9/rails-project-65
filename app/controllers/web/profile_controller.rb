class Web::ProfileController < ApplicationController
  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result
  end
end
