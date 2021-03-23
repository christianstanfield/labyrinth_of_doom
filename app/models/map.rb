class Map < ApplicationRecord
  has_many :map_tiles, dependent: :destroy
end
