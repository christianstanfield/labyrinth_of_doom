class MapTile < ApplicationRecord
  belongs_to :map
  has_many :map_positions, dependent: :destroy
  has_many :occupants, through: :map_positions

  enum terrain_type: {
    open:       'open',
    impassable: 'impassable',
    exit:       'exit'
  }, _suffix: true
end
