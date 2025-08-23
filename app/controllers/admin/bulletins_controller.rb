class Admin::BulletinsController < Admin::ApplicationController
    layout "layouts/admin"

    def on_moderation
        @bulletins = Bulletin.where(state: :under_moderation).order(created_at: :desc).page(params[:page]).per(2)
        render :on_moderation
    end

    def index
        @q = Bulletin.ransack(params[:q])
        @bulletins = @q.result.order(created_at: :desc).page(params[:page]).per(10)
    end

    def archive
        @bulletin = Bulletin.find(params[:id])
        render :index
    end
end
