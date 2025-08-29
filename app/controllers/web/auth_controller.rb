class Web::AuthController < ApplicationController
    def callback
        user_info = request.env["omniauth.auth"]
        user_name = user_info[:info][:name]
        user_email =  user_info[:info][:email]

        user = User.find_or_initialize_by(email: user_email)
        current_user_name = user.name
        user.name = user_name

        if user.persisted?
            session[:user_id] = user.id
            flash[:info] = "Wellcome back!"

            user.save! unless current_user_name == user_name

            redirect_to root_path
            return
        end

        if user.save
            flash[:info] = "Logged in successfully!"
            session[:user_id] = user.id
            redirect_to root_path
        else
            flash[:alert] = "Authorization error"
            redirect_to root_path
        end
    end

    def logout
        session[:user_id] = nil
        redirect_to root_path, notice: "Logged out successfully!"
    end
end
