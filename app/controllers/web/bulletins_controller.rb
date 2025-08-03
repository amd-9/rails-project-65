class Web::BulletinsController < ApplicationController
    def index
        if session[:user_id]
            @user = User.find(session[:user_id])
        end

        @bulletins = Bulletin.all.order(created_at: :desc)
    end

    def new
        @bulletin = Bulletin.new
    end

    def show
        @bulletin = Bulletin.new
    end

    def create
        @current_user = User.find(session[:user_id])
        @bulletin = @current_user.bulletins.build(bulletin_params)

        if @bulletin.save
            redirect_to root_url
        else
            render :new, status: :unprocessable_entity
        end
    end

    private

    def bulletin_params
        params.require(:bulletin).permit(:title, :description, :category_id)
    end
end
