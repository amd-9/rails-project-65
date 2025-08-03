class User < ApplicationRecord
    has_many :bulletins, dependent: :destroy, inverse_of: :creator
end
