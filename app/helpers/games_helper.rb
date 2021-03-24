module GamesHelper

  def matching_map_tile(map_tiles, row, column)
    map_tiles.find do |map_tile|
      map_tile.row == row && map_tile.column == column
    end
  end

  def occupant_on_map_tile?(map_tile, occupants)
    occupants.any? do |occupant|
      occupant.map_position.map_tile_id == map_tile.id
    end
  end
end
