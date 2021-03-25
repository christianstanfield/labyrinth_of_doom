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

  def line_of_sight_above
    viewable_tiles = map.map_tiles.where(column: column)
      .where('row < ?', row).order(row: :desc)

    if end_of_sight = end_of_sight_for(viewable_tiles)
      viewable_tiles.select do |map_tile|
        map_tile.row > end_of_sight.row
      end
    else
      viewable_tiles
    end
  end

  def line_of_sight_below
    viewable_tiles = map.map_tiles.where(column: column)
      .where('row > ?', row).order(:row)

    if end_of_sight = end_of_sight_for(viewable_tiles)
      viewable_tiles.select do |map_tile|
        map_tile.row < end_of_sight.row
      end
    else
      viewable_tiles
    end
  end

  def line_of_sight_to_the_left
    viewable_tiles = map.map_tiles.where(row: row)
      .where('map_tiles.column < ?', column).order(column: :desc)

    if end_of_sight = end_of_sight_for(viewable_tiles)
      viewable_tiles.select do |map_tile|
        map_tile.column > end_of_sight.column
      end
    else
      viewable_tiles
    end
  end

  def line_of_sight_to_the_right
    viewable_tiles = map.map_tiles.where(row: row)
      .where('map_tiles.column > ?', column).order(:column)

    if end_of_sight = end_of_sight_for(viewable_tiles)
      viewable_tiles.select do |map_tile|
        map_tile.column < end_of_sight.column
      end
    else
      viewable_tiles
    end
  end

  def end_of_sight_for(viewable_tiles)
    viewable_tiles.find { |map_tile| map_tile.impassable_terrain_type? }
  end
end
