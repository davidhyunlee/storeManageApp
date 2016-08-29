class Payment < ApplicationRecord
  belongs_to :invoice
  belongs_to :store
  belongs_to :customer
  belongs_to :user
  belongs_to :carrier

  validates :amount, :payment_type, :store_id, :customer_id, :carrier_id, :user_id, :presence => true
  validates :amount, :numericality => true
end
