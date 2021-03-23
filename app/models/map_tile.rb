class MapTile < ApplicationRecord
  belongs_to :map
  has_many :character_positions, dependent: :destroy
  has_many :characters, through: :character_positions

  enum terrain_type: {
    open:       'open',
    impassable: 'impassable',
    start:      'start',
    exit:       'exit'
  }
end
