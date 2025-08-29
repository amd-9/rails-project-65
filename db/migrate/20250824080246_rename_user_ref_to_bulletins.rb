# frozen_string_literal: true

class RenameUserRefToBulletins < ActiveRecord::Migration[7.2]
  def change
    rename_column :bulletins, :user_id, :user
  end
end
