class StartingCharacter < ApplicationRecord
  belongs_to :map
  has_one :map_position, as: :occupant, dependent: :destroy
  has_many :items, as: :owner, dependent: :destroy

  attr_accessor :row, :column
end
