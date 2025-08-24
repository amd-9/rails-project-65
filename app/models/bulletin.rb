class Bulletin < ApplicationRecord
    include AASM

    has_one_attached :image

    validates :title, presence: true, length: { maximum: 50 }
    validates :description, length: { maximum: 1000 }
    validates :image, attached: true, content_type: %i[png jpg jpeg], size: { less_than: 5.megabytes }

    belongs_to :category
    belongs_to :creator, class_name: "User", foreign_key: :user, inverse_of: :bulletins

    aasm column: :state do
        state :draft, initial: true
        state :under_moderation
        state :published
        state :rejected
        state :archived

        event :to_moderate do
            transitions from: :draft, to: :under_moderation
        end

        event :archive do
            transitions from: [ :draft, :under_moderation, :published, :rejected ], to: :archived
        end

        event :publish do
            transitions from: :under_moderation, to: :published
        end

        event :reject do
            transitions from: :under_moderation, to: :rejected
        end
    end

  def self.ransackable_attributes(_auth_object = nil)
    [ "title", "category_id", "state" ]
  end
end
