class CreateMapTiles < ActiveRecord::Migration[6.1]
  def change
    create_table :map_tiles do |t|
      t.string :terrain_type, null: false
      t.references :map, null: false, foreign_key: true
      t.integer :row, null: false
      t.integer :column, null: false

      t.timestamps
    end
  end
end
