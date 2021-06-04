class CreateSources < ActiveRecord::Migration[6.0]
  def change
    create_table :sources do |t|
      t.string :name, null: false
      t.string :external_id, null: false
      t.integer :condition, null: false
      t.integer :category, null: false

      t.timestamps
    end
  end
end
