class Character < ApplicationRecord
  belongs_to :game
  has_one :map_position, as: :occupant, dependent: :destroy
end
