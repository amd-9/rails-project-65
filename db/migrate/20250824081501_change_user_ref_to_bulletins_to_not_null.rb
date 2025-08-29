# frozen_string_literal: true

class ChangeUserRefToBulletinsToNotNull < ActiveRecord::Migration[7.2]
  def change
    change_column_null :bulletins, :user, false
  end
end
