class Bulletin < ApplicationRecord
    validates :title, presence: true, length: { maximum: 50 }
    validates :description, length: { maximum: 2000 }

    belongs_to :category
    belongs_to :user
end
