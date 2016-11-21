class Sellable < ApplicationRecord
  belongs_to :category
  belongs_to :carrier
  has_many :line_items
  has_many :serialized_items
  has_many :simple_items

  validates :sku, :category_id, :retail_price, :taxable_price, :presence => true
  validates_uniqueness_of :sku
end
