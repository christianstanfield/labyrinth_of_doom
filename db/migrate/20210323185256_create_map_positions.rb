class CreateMapPositions < ActiveRecord::Migration[6.1]
  def change
    create_table :map_positions do |t|
      t.references :occupant, polymorphic: true, null: false
      t.references :map_tile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
