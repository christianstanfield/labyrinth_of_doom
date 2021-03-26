# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Map.destroy_all

map = Map.create!(
  name: 'Level 1',
  length: 6,
  height: 5
)

character = map.starting_characters.create!(
  health: 1,
  attack: 1,
  defense: 1,
  actions: 1
)

enemy1 = map.starting_enemies.create!(
  health: 1,
  attack: 1,
  defense: 0,
  actions: 2
)

enemy1.items.create!(
  name: 'Cloak of Quantum Tunneling',
  reference_id: 'tunneling_cloak',
  ability: 'Allows owner to teleport through walls'
)

enemy2 = map.starting_enemies.create!(
  health: 2,
  attack: 2,
  defense: 0,
  actions: 2
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
    3 => :impassable
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

starting_tile = map.map_tiles.find_by(column: 5, row: 4)
enemy1_tile    = map.map_tiles.find_by(column: 0, row: 4)
enemy2_tile    = map.map_tiles.find_by(column: 4, row: 0)

starting_tile.map_positions.create!(occupant: character)
enemy1_tile.map_positions.create!(occupant: enemy1)
enemy2_tile.map_positions.create!(occupant: enemy2)
