class CreateMaps < ActiveRecord::Migration[6.1]
  def change
    create_table :maps do |t|
      t.integer :length, null: false
      t.integer :height, null: false

      t.timestamps
    end
  end
end
