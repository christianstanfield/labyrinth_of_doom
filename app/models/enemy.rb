class Enemy < ApplicationRecord
  include GameOccupant

  belongs_to :game
  has_one :map_position, as: :occupant, dependent: :destroy

  def take_turn(player_character)
    character_map_tile_id = player_character.map_position.map_tile_id

    if can_see_character_above?(character_map_tile_id)
      if current_position.tile_above.id == character_map_tile_id
        attack_opponent(player_character)
      else
        move(UPWARDS_MOVE)
      end
    end

    if can_see_character_below?(character_map_tile_id)
      if current_position.tile_below.id == character_map_tile_id
        attack_opponent(player_character)
      else
        move(DOWNWARDS_MOVE)
      end
    end

    if can_see_character_to_the_left?(character_map_tile_id)
      if current_position.tile_to_the_left.id == character_map_tile_id
        attack_opponent(player_character)
      else
        move(LEFTWARDS_MOVE)
      end
    end

    if can_see_character_to_the_right?(character_map_tile_id)
      if current_position.tile_to_the_right.id == character_map_tile_id
        attack_opponent(player_character)
      else
        move(RIGHTWARDS_MOVE)
      end
    end
  end

  def can_see_character_above?(character_map_tile_id)
    current_position.line_of_sight_above.any? do |map_tile|
      map_tile.id == character_map_tile_id
    end
  end

  def can_see_character_below?(character_map_tile_id)
    current_position.line_of_sight_below.any? do |map_tile|
      map_tile.id == character_map_tile_id
    end
  end

  def can_see_character_to_the_left?(character_map_tile_id)
    current_position.line_of_sight_to_the_left.any? do |map_tile|
      map_tile.id == character_map_tile_id
    end
  end

  def can_see_character_to_the_right?(character_map_tile_id)
    current_position.line_of_sight_to_the_right.any? do |map_tile|
      map_tile.id == character_map_tile_id
    end
  end
end
