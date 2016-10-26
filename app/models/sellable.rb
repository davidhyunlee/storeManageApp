class Sellable < ApplicationRecord
  belongs_to :category
  belongs_to :carrier
  has_many :line_items
  has_many :serialized_items
  has_many :simple_items
end
