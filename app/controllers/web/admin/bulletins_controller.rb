class Web::Admin::BulletinsController < Web::Admin::ApplicationController
    layout "layouts/admin"

    def on_moderation
        @bulletins = Bulletin.where(state: :under_moderation).order(created_at: :desc).page(params[:page]).per(10)
    end

    def index
        @q = Bulletin.ransack(params[:q])
        @bulletins = @q.result.order(created_at: :desc).page(params[:page]).per(10)
    end

    def publish
        bulletin = Bulletin.find(params[:id])
        
        if !bulletin.may_publish?
            redirect_back fallback_location: root_path, notice: t("bulletin.state_change_not_permited")
        end

        bulletin.publish!
        redirect_back fallback_location: root_path, notice: t("bulletins.publish.success")
    end

    def archive
        bulletin = Bulletin.find(params[:id])

        if !bulletin.may_archive?
            redirect_back fallback_location: root_path, notice: t("bulletin.state_change_not_permited")
        end

        bulletin.archive!
        redirect_back fallback_location: root_path, notice: t("bulletins.pubarchivelish.success")
    end

    def reject
        bulletin = Bulletin.find(params[:id])

        if !bulletin.may_reject?
            redirect_back fallback_location: root_path, notice: t("bulletin.state_change_not_permited")
        end

        bulletin.reject!
        redirect_back fallback_location: root_path, notice: t("bulletins.reject.success")
    end
end
