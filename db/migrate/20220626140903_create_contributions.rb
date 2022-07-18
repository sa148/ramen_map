class CreateContributions < ActiveRecord::Migration[6.1]
  def change
    create_table :contributions do |t|
      t.integer :shop_id
      t.string :tag_name, null: false
      t.text :title, null: false
      t.string :star, null: false
      t.string :comment, null: false
      t.references :customer, foreign_key: true
      t.timestamps
    end
  end
end
