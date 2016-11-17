class SimpleItem < ApplicationRecord
  belongs_to :store
  belongs_to :sellable

  validates :sellable_id, :quantity, :store_id, presence: true
end
