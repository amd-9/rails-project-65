# frozen_string_literal: true

class UserPolicy
  attr_reader :user

  def initialize(user, _record)
    @user = user
  end

  def admin?
    user&.admin?
  end

  def signed_in?
    !user.nil?
  end
end
