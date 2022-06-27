class CreateContributions < ActiveRecord::Migration[6.1]
  def change
    create_table :contributions do |t|
      t.integer :customer_id, null: false
      #t.integer :menu_id, null: false
      t.text :title, null: false
      #t.float :revue, null: false
      t.string :comment, null: false
      t.timestamps
    end
  end
end
