class ChangeUsersAdminColumnDefaultValue < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :admin, false
  end
end
