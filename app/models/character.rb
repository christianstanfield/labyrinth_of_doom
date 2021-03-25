class Character < ApplicationRecord
  include GameOccupant

  belongs_to :game
  has_one :map_position, as: :occupant, dependent: :destroy

  def attack_enemy
    damage = nil

    if current_position.tile_above&.occupied_by_enemy?(game)
      opponent = game.living_enemies.at_position(current_position.tile_above).first
      damage = attack_opponent(opponent)

    elsif current_position.tile_below&.occupied_by_enemy?(game)
      opponent = game.living_enemies.at_position(current_position.tile_below).first
      damage = attack_opponent(opponent)

    elsif current_position.tile_to_the_left&.occupied_by_enemy?(game)
      opponent = game.living_enemies.at_position(current_position.tile_to_the_left).first
      damage = attack_opponent(opponent)

    elsif current_position.tile_to_the_right&.occupied_by_enemy?(game)
      opponent = game.living_enemies.at_position(current_position.tile_to_the_right).first
      damage = attack_opponent(opponent)

    else
      errors.add(:base, 'No enemies in range')
    end

    if damage
      attack_result = "You dealt #{damage} damage"
      opponent.dead? ? "#{attack_result}. Enemy defeated" : attack_result
    end
  end
end
