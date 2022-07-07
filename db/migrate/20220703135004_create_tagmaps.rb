class CreateTagmaps < ActiveRecord::Migration[6.1]
  def change
    create_table :tagmaps do |t|
      t.references :contribution,  foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
