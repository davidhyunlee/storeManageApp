class Invoice < ApplicationRecord
  belongs_to :customer, inverse_of: :invoices
  belongs_to :user
  belongs_to :store
  has_many :line_items, inverse_of: :invoice, dependent: :destroy
  accepts_nested_attributes_for :line_items, allow_destroy: true

  validates :customer_id, :user_id, :store_id, :presence => true
end
