module GameOccupant
  extend ActiveSupport::Concern

  included do
    scope :for_game, -> (game) { where(game: game) }
    scope :at_position, -> (map_tile) {
      joins(:map_position).where(map_position: { map_tile: map_tile })
    }
  end
end
