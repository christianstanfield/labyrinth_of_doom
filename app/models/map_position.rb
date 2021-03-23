class MapPosition < ApplicationRecord
  belongs_to :occupant, polymorphic: true
  belongs_to :map_tile
end
