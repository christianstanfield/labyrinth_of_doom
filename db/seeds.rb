# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Character.destroy_all
Map.destroy_all

player = Player.create!(
  health: 1,
  attack: 1,
  defense: 1,
  actions: 1
)

enemy = Enemy.create!(
  health: 1,
  attack: 1,
  defense: 0,
  actions: 2
)

map = Map.create!(
  length: 6,
  height: 5
)

map_tile_terrains = {
  1 => {
    1 => :impassable,
    3 => :impassable
  },
  2 => {
    1 => :impassable,
    3 => :impassable
  },
  3 => {
    1 => :impassable
  },
  4 => {
    3 => :impassable
  },
  5 => {
    0 => :exit,
    1 => :impassable,
    3 => :impassable,
    4 => :start
  }
}

map.length.times do |column|
  map.height.times do |row|
    terrain_type = map_tile_terrains[column]&.dig(row)
    terrain_type ||= :open
    map.map_tiles.create!(
      row: row, column: column, terrain_type: terrain_type
    )
  end
end

starting_tile = map.map_tiles.start.first
enemy_tile    = map.map_tiles.find_by(column: 0, row: 4)

starting_tile.character_positions.create!(character: player)
enemy_tile.character_positions.create!(character: enemy)
