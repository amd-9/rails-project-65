class CategoryPolicy < ApplicationPolicy
    attr_reader :user, :category

    def update?
        user.admin?
    end
end
