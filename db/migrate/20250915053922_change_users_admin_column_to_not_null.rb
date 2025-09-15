class ChangeUsersAdminColumnToNotNull < ActiveRecord::Migration[7.2]
  def change
    change_column_null :users, :admin, false
  end
end
