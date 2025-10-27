# frozen_string_literal: true

class BulletinPolicy
  attr_reader :user, :bulletin

  def initialize(user, bulletin)
    @user = user
    @bulletin = bulletin
  end

  def show?
    return true if @bulletin.published? || @user&.admin?

    @bulletin.user == @user
  end

  def edit?
    update?
  end

  def update?
    return true if @user.admin?

    @bulletin.user == @user && (@bulletin.draft? || @bulletin.rejected?)
  end

  def author?
    @bulletin.user == @user
  end

  def archive?
    author? || @user.admin?
  end

  def to_moderate?
    author? || @user.admin?
  end
end
