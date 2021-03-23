class Game < ApplicationRecord
  belongs_to :map
  has_many :characters, dependent: :destroy
  has_many :enemies, dependent: :destroy
end
