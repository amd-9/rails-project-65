class CreateBulletins < ActiveRecord::Migration[7.2]
  def change
    create_table :bulletins do |t|
      t.string :title, limit: 50
      t.text :description, limit: 1000
      t.binary :image

      t.timestamps
    end
  end
end
