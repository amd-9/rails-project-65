# frozen_string_literal: true

class Web::AuthController < ApplicationController
  def callback
    user_info = request.env['omniauth.auth']
    user_name = user_info[:info][:name]
    user_email = user_info[:info][:email]

    user = User.find_or_initialize_by(email: user_email)
    current_user_name = user.name
    user.name = user_name

    if user.persisted?
      session[:user_id] = user.id
      flash[:info] = t('auth.welcome_back')

      user.save! unless current_user_name == user_name

      redirect_to root_path
      return
    end

    if user.save
      flash[:info] = t('auth.login.success')
      session[:user_id] = user.id
    else
      flash[:alert] = t('auth.login.error')
    end
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path, notice: t('auth.logout.success')
  end
end
