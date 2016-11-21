class Payment < ApplicationRecord
  belongs_to :invoice
  belongs_to :store
  belongs_to :customer
  belongs_to :user
  belongs_to :carrier
  belongs_to :payment_type
  belongs_to :number

  validates :amount, :payment_type_id, :store_id, :customer_id, :carrier_id, :user_id, :number_id, :presence => true
  validates :amount, :numericality => true
end
