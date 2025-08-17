class Web::AuthController < ApplicationController
    def callback
        user_info = request.env["omniauth.auth"]
        user_nickname = user_info[:info][:nickname]
        user_email =  user_info[:info][:email]

        user = User.find_by(name: user_nickname, email: user_email) 

        if user
            session[:user_id] = user.id
            flash[:info] = "Wellcome back!"
            redirect_to root_path
            return
        end

        user = User.new(name: user_nickname, email: user_email)

        if user.save
            flash[:info] = "Logged in successfully!"
            session[:user_id] = user.id
            redirect_to root_path
        else
            flash[:alert] = "Authorization error"
            redirect_to root_path
        end
    end
end
