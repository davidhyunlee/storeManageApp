class Sellable < ApplicationRecord
  belongs_to :category
  belongs_to :carrier
  has_many :line_items
end
