# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, presence: true

  has_many :bulletins, dependent: :restrict_with_exception
end
