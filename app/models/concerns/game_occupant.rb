module GameOccupant
  extend ActiveSupport::Concern

  included do
    scope :for_game, -> (game) { where(game: game) }
  end
end
