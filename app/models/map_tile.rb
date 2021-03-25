class MapTile < ApplicationRecord

  belongs_to :map
  has_many :map_positions, dependent: :destroy
  has_many :characters, through: :map_positions, source: :occupant, source_type: 'Character'
  has_many :enemies, through: :map_positions, source: :occupant, source_type: 'Enemy'

  enum terrain_type: {
    open:       'open',
    impassable: 'impassable',
    exit:       'exit'
  }, _suffix: true

  def tile_above
    map.map_tiles.find_by(row: row - 1, column: column)
  end

  def tile_below
    map.map_tiles.find_by(row: row + 1, column: column)
  end

  def tile_to_the_left
    map.map_tiles.find_by(row: row, column: column - 1)
  end

  def tile_to_the_right
    map.map_tiles.find_by(row: row, column: column + 1)
  end

  def impassable_or_occupied?(game)
    impassable_terrain_type? ||
    occupied_by_enemy?(game) ||
    occupied_by_character?(game)
  end

  def occupied_by_enemy?(game)
    enemies.for_game(game).exists?
  end

  def occupied_by_character?(game)
    characters.for_game(game).exists?
  end
end
