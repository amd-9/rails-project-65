class ReverseRenameUserRefToBulletins < ActiveRecord::Migration[7.2]
  def change
    rename_column :bulletins, :user, :user_id
  end
end
