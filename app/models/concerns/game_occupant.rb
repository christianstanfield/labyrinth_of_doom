module GameOccupant
  extend ActiveSupport::Concern

  UPWARDS_MOVE    = 'up'
  DOWNWARDS_MOVE  = 'down'
  LEFTWARDS_MOVE  = 'left'
  RIGHTWARDS_MOVE = 'right'

  included do
    attr_accessor :defending

    scope :alive, -> { where('health > 0') }
    scope :dead, -> { where('health <= 0') }
    scope :for_game, -> (game) { where(game: game).alive }
    scope :at_position, -> (map_tile) {
      joins(:map_position).where(map_position: { map_tile: map_tile })
    }
  end

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

  def current_position
    map_position.map_tile
  end

  def attack_opponent(opponent)
    damage = opponent.defending ? attack - opponent.defense : attack
    damage = 0 if damage < 0
    opponent.health -= damage
    opponent.save!
    damage
  end

  def defend
    self.defending = true
  end

  def dead?
    health <= 0
  end
end
