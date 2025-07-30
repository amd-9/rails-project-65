class Web::AuthController < ApplicationController
    def index
    end

    def callback
        user_info = request.env["omniauth.auth"]

        @user = User.new(name: user_info[:info][:name], email: user_info[:info][:email])

        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path
        else
            redirect_to root_path
        end
    end
end
