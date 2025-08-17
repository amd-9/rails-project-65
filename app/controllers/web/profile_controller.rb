class Web::ProfileController < ApplicationController
  def index
    @bulletins = @user.bulletins
  end
end
