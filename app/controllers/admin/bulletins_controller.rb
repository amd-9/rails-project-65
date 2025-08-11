class Admin::BulletinsController < ApplicationController
    def index
        @bulletins = Bulletin.order(created_at: :desc)
    end

    def archive
        @bulletin = Bulletin.find(params[:id])
        render :index
    end
end
