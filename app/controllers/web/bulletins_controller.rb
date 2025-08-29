# frozen_string_literal: true

class Web::BulletinsController < ApplicationController
  before_action :user_signed_in?, except: %i[index show]

  def index
    @q = Bulletin.where(state: :published).ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc)
  end

  def show
    @bulletin = Bulletin.find(params[:id])

    if current_user.nil?
      redirect_to bulletins_path, notice: t('bulletin.show.not_found') unless @bulletin.published?
    else
      redirect_to bulletins_path, notice: t('bulletin.show.not_found') unless @bulletin.user == current_user
    end
  end

  def new
    @bulletin = Bulletin.new
  end

  def edit
    @bulletin = Bulletin.find(params[:id])
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      redirect_to bulletin_url(@bulletin), notice: t('bulletin.create.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    bulletin = Bulletin.find(params[:id])

    if bulletin.user != current_user
      return redirect_to root_path, notice: t('bulletin.state_change_not_permited')
    end

    if bulletin.update(bulletin_params)
      redirect_to bulletin_path(bulletin), notice: t('bulletin.update.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def archive
    bulletin = Bulletin.find(params[:id])

    unless bulletin.may_archive?
      redirect_back fallback_location: root_path, notice: t('bulletin.state_change_not_permited')
    end

    bulletin.archive!
    redirect_back fallback_location: root_path, notice: t('bulletins.archive.success')
  end

  def to_moderate
    bulletin = Bulletin.find(params[:id])

    unless bulletin.may_to_moderate?
      redirect_back fallback_location: root_path, notice: t('bulletin.state_change_not_permited')
    end

    bulletin.to_moderate!
    redirect_back fallback_location: root_path, notice: t('bulletins.to_moderate.success')
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
