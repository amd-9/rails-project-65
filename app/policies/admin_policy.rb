class AdminPolicy
    attr_reader :user

    def initialize(user, _record)
        @user = user
    end

    def admin?
        user.admin? unless user.nil?
    end
end
