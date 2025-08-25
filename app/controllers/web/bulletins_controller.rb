class Web::BulletinsController < ApplicationController
    before_action :user_signed_in?, except: [ :index ]

    def index
        @q = Bulletin.where(state: :published).ransack(params[:q])
        @bulletins = @q.result.order(created_at: :desc)
    end

    def new
        @bulletin = Bulletin.new
    end

    def show
        @bulletin = Bulletin.find(params[:id])
    end

    def create
        @current_user = User.find(session[:user_id])
        @bulletin = @current_user.bulletins.build(bulletin_params)

        if @bulletin.save
            redirect_to bulletin_url(@bulletin), notice: t("bulletin.create.success")
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @bulletin = Bulletin.find(params[:id])
    end

    def update
        bulletin = Bulletin.find(params[:id])

        if bulletin.user != current_user
            return redirect_to root_path, notice: t("bulletin.state_change_not_permited")
        end

        if bulletin.update(bulletin_params)
            redirect_to bulletin_path(bulletin), notice: t("bulletin.update.success")
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def change_state
        bulletin = Bulletin.find(params[:id])
        to_state = params[:to_state]
        restricted_states = [ :reject, :publish ]
        trasition_success_notices =
            {
                "reject" => t("bulletins.reject.success"),
                "publish" => t("bulletins.publish.success"),
                "archive" => t("bulletins.archive.success"),
                "to_moderate" => t("bulletins.to_moderate.success")
            }

        if bulletin.user != current_user and !current_user.admin?
            redirect_back fallback_location: root_path, notice: t("bulletin.state_change_not_permited")
        end

        if restricted_states.include? to_state and !user.admin?
            redirect_back fallback_location: root_path, notice: t("bulletin.state_change_not_permited")
        end

        bulletin.aasm.fire!(to_state)

        redirect_back fallback_location: root_path, notice: trasition_success_notices[to_state]
    end

    private

    def bulletin_params
        params.require(:bulletin).permit(:title, :description, :category_id, :image)
    end
end
