class Game < ApplicationRecord

  belongs_to :map
  has_many :characters, dependent: :destroy
  has_many :living_characters, -> { alive }, class_name: 'Character', dependent: :destroy
  has_many :deceased_characters, -> { dead }, class_name: 'Character', dependent: :destroy
  has_many :enemies, dependent: :destroy
  has_many :living_enemies, -> { alive }, class_name: 'Enemy', dependent: :destroy

  OCCUPANT_TRANSFERABLE_ATTRIBUTES = ["health", "attack", "defense", "actions"]
  ITEM_TRANSFERABLE_ATTRIBUTES     = ["name", "reference_id", "ability"]

  def setup
    map.starting_characters.includes(:map_position).each do |starting_character|
      attributes = starting_character.attributes.slice(*OCCUPANT_TRANSFERABLE_ATTRIBUTES)
      new_character = characters.create!(attributes)

      map_tile_id = starting_character.map_position.map_tile_id
      MapPosition.create!(occupant: new_character, map_tile_id: map_tile_id)
    end

    map.starting_enemies.includes(:map_position).each do |starting_enemy|
      attributes = starting_enemy.attributes.slice(*OCCUPANT_TRANSFERABLE_ATTRIBUTES)
      new_enemy = enemies.create!(attributes)

      map_tile_id = starting_enemy.map_position.map_tile_id
      MapPosition.create!(occupant: new_enemy, map_tile_id: map_tile_id)

      new_enemy.pickup_items_from(starting_enemy)
    end
  end

  def over?
    living_characters.empty?
  end

  def successful?
    !over? && living_characters.at_position(map.exit_tile).size == living_characters.size
  end

  def enemies_turn(player_character)
    living_enemies.each do |enemy|
      enemy.actions.times do
        enemy.take_turn(player_character)
      end
    end
  end

  def single_player_character
    living_characters.first
  end

  def last_played_time
    updated_at.strftime("%A %B %d")
  end
end
