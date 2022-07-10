class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.integer :contribution
      t.float :latitude
      t.float :longitude
      t.string :menu_name
      t.text :menu_introduction
      t.string :price
      t.string :name
      t.text :introduction
      t.string :telephone_number
      t.string :email
      t.string :address
      t.timestamps
    end
  end
end
