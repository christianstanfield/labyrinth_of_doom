class Map < ApplicationRecord

  has_many :map_tiles, dependent: :destroy
  has_many :games, dependent: :destroy
  has_many :starting_characters, dependent: :destroy
  has_many :starting_enemies, dependent: :destroy

  validates :name,   presence: true
  validates :length, presence: true, numericality: { only_integer: true }
  validates :height, presence: true, numericality: { only_integer: true }

  TILE_TERRAIN_SELECTION = 'terrain'
  TILE_EXIT_SELECTION    = 'exit'

  def exit_tile
    map_tiles.exit_terrain_type.first
  end

  def create_tile_terrain_from_user_input(params)
    height.times do |row|
      length.times do |column|
        coordinates    = "#{row}-#{column}"
        user_selection = params[coordinates]
        terrain_type   = user_selection == '1' ? :impassable : :open

        map_tiles.create!(
          row: row, column: column, terrain_type: terrain_type
        )
      end
    end
  end

  def create_exit_tile_from_user_input(params)
    height.times do |row|
      length.times do |column|
        coordinates    = "#{row}-#{column}"
        user_selection = params[coordinates]

        if user_selection == '1'
          map_tiles.find_by(row: row, column: column).update!(terrain_type: :exit)
          return
        end
      end
    end
  end

  def create_starting_character_from_user_input(character_params, position_params)
    starting_character = starting_characters.create!(character_params)
    starting_tile      = map_tiles.find_by(position_params)
    starting_tile.map_positions.create!(occupant: starting_character)
    nil
  rescue => error
    'Failed to create starting character'
  end

  def create_starting_enemy_from_user_input(enemy_params, position_params)
    starting_enemy = starting_enemies.create!(enemy_params)
    starting_tile  = map_tiles.find_by(position_params)
    starting_tile.map_positions.create!(occupant: starting_enemy)
    nil
  rescue => error
    'Failed to create starting enemy'
  end
end
