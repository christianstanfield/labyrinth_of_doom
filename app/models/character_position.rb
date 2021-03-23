class CharacterPosition < ApplicationRecord
  belongs_to :character
  belongs_to :map_tile
end
