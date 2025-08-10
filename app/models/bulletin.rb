class Bulletin < ApplicationRecord
    has_one_attached :image

    validates :title, presence: true, length: { maximum: 50 }
    validates :description, length: { maximum: 1000 }
    validates :image, attached: true, content_type: %i[png jpg jpeg], size: { less_than: 5.megabytes}

    belongs_to :category
    belongs_to :creator, class_name: 'User', foreign_key: :user_id, inverse_of: :bulletins
end
