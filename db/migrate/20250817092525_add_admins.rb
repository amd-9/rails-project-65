class AddAdmins < ActiveRecord::Migration[7.2]
  def change
    admin_user = User.find_by(email: "asamoshin9@gmail.com")

    if admin_user.nil?
      admin_user = User.create(name: 'amd-9', email: 'asamoshin9@gmail.com')
    end

    admin_user.update(admin: true)
  end
end
