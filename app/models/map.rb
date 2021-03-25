class Map < ApplicationRecord
  has_many :map_tiles, dependent: :destroy
  has_many :games, dependent: :destroy
  has_many :starting_characters, dependent: :destroy
  has_many :starting_enemies, dependent: :destroy

  def exit_tile
    map_tiles.exit_terrain_type.first
  end
end
