class Web::AuthController < ApplicationController
    def auth_request
        redirect_to auth_request_path
    end

    def callback_auth
        user_info = request.env['omniauth.auth']

        @user = User.new(name: user_data.name, email: user_data.email)

        if @user.save
            session[:user_id] = @user.id
            pp "done"
        else
            pp "error"
    end
end
