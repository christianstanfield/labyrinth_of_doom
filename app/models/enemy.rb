class Enemy < ApplicationRecord
  include GameOccupant

  belongs_to :game
  has_one :map_position, as: :occupant, dependent: :destroy
end
