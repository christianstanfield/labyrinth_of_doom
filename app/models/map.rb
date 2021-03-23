class Map < ApplicationRecord
  has_many :map_tiles, dependent: :destroy
  has_many :games, dependent: :destroy
  has_many :starting_characters, dependent: :destroy
  has_many :starting_enemies, dependent: :destroy
end
