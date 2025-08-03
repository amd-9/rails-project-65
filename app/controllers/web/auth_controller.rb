class Web::AuthController < ApplicationController
    def callback
        pp "Processing callback"

        user_info = request.env["omniauth.auth"]

        @user = User.new(name: user_info[:info][:login], email: user_info[:info][:email])

        pp user_info
        pp "authorized user - login: #{@user.name}, email: #{@user.email}"

        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path
        else
            redirect_to root_path
        end
    end
end
