class CreateCharacterPositions < ActiveRecord::Migration[6.1]
  def change
    create_table :character_positions do |t|
      t.references :character, null: false, foreign_key: true
      t.references :map_tile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
