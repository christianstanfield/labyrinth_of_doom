class Item < ApplicationRecord
  belongs_to :owner, polymorphic: true
end
