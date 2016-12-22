class SaleType < ApplicationRecord
  has_many :line_items, inverse_of: :sale_type

  validates :name, :presence => true
end
