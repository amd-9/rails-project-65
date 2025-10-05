# frozen_string_literal: true

class BulletinPolicy
  attr_reader :user, :bulletin

  def initialize(user, bulletin)
    @user = user
    @bulletin = bulletin
  end

  def show?
    return true if @bulletin.published?
    return true if @user&.admin?

    @bulletin.user == @user
  end

  def edit?
    update?
  end

  def update?
    return true if @user.admin?

    @bulletin.user == @user && (@bulletin.draft? || @bulletin.rejected?)
  end

  def archive?
    return true if @user.admin?

    @bulletin.user == @user && @bulletin.may_archive?
  end

  def to_moderate?
    return true if @user.admin?

    @bulletin.user == @user && @bulletin.to_moderate?
  end
end
