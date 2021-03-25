class Character < ApplicationRecord
  include GameOccupant

  belongs_to :game
  has_one :map_position, as: :occupant, dependent: :destroy

  attr_accessor :defending

  # ACTIONS:
  UPWARDS_MOVE    = 'up'
  DOWNWARDS_MOVE  = 'down'
  LEFTWARDS_MOVE  = 'left'
  RIGHTWARDS_MOVE = 'right'

  def move(direction)
    destination =
      case direction
      when UPWARDS_MOVE
        current_position.tile_above
      when DOWNWARDS_MOVE
        current_position.tile_below
      when LEFTWARDS_MOVE
        current_position.tile_to_the_left
      when RIGHTWARDS_MOVE
        current_position.tile_to_the_right
      end

    if destination.nil? || destination.impassable_or_occupied?(game)
      errors.add(:base, 'Invalid move')
    else
      map_position.update!(map_tile: destination)
    end
  end

  def attack
    if current_position.tile_above&.occupied_by_enemy?(game)
      game.enemies.at_position(current_position.tile_above).first.destroy!
    elsif current_position.tile_below&.occupied_by_enemy?(game)
      game.enemies.at_position(current_position.tile_below).first.destroy!
    elsif current_position.tile_to_the_left&.occupied_by_enemy?(game)
      game.enemies.at_position(current_position.tile_to_the_left).first.destroy!
    elsif current_position.tile_to_the_right&.occupied_by_enemy?(game)
      game.enemies.at_position(current_position.tile_to_the_right).first.destroy!
    else
      errors.add(:base, 'No enemies in range')
    end
  end

  def current_position
    map_position.map_tile
  end
end
