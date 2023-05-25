# frozen_string_literal: true

class Web::AuthController < ApplicationController
  def callback
    user_info = request.env['omniauth.auth']

    user_data = user_info[:info]

    @user = User.new(name: user_data.name, email: user_data.email)

    if @user.save
      session[:user_id] = @user.id
      redirect_to auth_request_path
    else
      redirect_to auth_request_path, alert: t('.auth.create.fail')
    end
  end
end
