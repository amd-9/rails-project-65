class Admin::BulletinsController < Admin::ApplicationController
    layout "layouts/admin"

    def on_moderation
        @bulletins = Bulletin.order(created_at: :desc)
        render :on_moderation
    end

    def index
        @bulletins = Bulletin.order(created_at: :desc)
    end

    def archive
        @bulletin = Bulletin.find(params[:id])
        render :index
    end
end
