class DropCharacterPositions < ActiveRecord::Migration[6.1]
  def change
    drop_table :character_positions
  end
end
