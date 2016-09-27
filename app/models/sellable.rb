class Sellable < ApplicationRecord
  belongs_to :category
  belongs_to :carrier
  has_many :received_items
end
