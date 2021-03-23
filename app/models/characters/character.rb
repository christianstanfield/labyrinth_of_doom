class Character < ApplicationRecord
  has_many :character_positions, dependent: :destroy
  has_many :map_tiles, through: :character_positions
end
