class StartingEnemy < ApplicationRecord
  belongs_to :map
  has_one :map_position, as: :occupant, dependent: :destroy
end
