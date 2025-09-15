# frozen_string_literal: true

class User < ApplicationRecord
  attribute :admin, default: false

  has_many :bulletins, dependent: :destroy
end
