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
    invalid_move = 'Invalid move'
    destination  = current_position.tile_in_direction(direction)

    if destination.nil?
      errors.add(:base, invalid_move)

    elsif destination.impassable_or_occupied?(game)
      if possesses_tunneling_cloak? && destination.impassable_terrain_type?
        new_destination = destination.tile_in_direction(direction)

        if new_destination.nil? || new_destination.impassable_or_occupied?(game)
          errors.add(:base, invalid_move)
        else
          map_position.update!(map_tile: new_destination)
        end
      else
        errors.add(:base, invalid_move)
      end

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

  def pickup_items_from(owner)
    owner.items.each do |item|
      attributes = item.attributes.slice(*Game::ITEM_TRANSFERABLE_ATTRIBUTES)
      items.create!(attributes)
    end
  end

  def possesses_tunneling_cloak?
    items.where(reference_id: 'tunneling_cloak').exists?
  end
end
