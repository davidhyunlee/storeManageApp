class SimpleItem < ApplicationRecord
  belongs_to :store
  belongs_to :sellable
  has_many :line_items, inverse_of: :simple_item

  validates :sellable_id, :quantity, :store_id, presence: true
end
