class Game < ApplicationRecord
  belongs_to :map
  has_many :characters, dependent: :destroy
  has_many :enemies, dependent: :destroy

  TRANSFERABLE_ATTRIBUTES = ["health", "attack", "defense", "actions"]

  def setup
    map.starting_characters.includes(:map_position).each do |starting_character|
      attributes = starting_character.attributes.slice(*TRANSFERABLE_ATTRIBUTES)
      new_character = characters.create!(attributes)

      map_tile_id = starting_character.map_position.map_tile_id
      MapPosition.create!(occupant: new_character, map_tile_id: map_tile_id)
    end

    map.starting_enemies.includes(:map_position).each do |starting_enemy|
      attributes = starting_enemy.attributes.slice(*TRANSFERABLE_ATTRIBUTES)
      new_enemy = enemies.create!(attributes)

      map_tile_id = starting_enemy.map_position.map_tile_id
      MapPosition.create!(occupant: new_enemy, map_tile_id: map_tile_id)
    end
  end
end
