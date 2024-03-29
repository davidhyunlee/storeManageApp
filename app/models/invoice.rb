class Invoice < ApplicationRecord
  belongs_to :customer, inverse_of: :invoices
  belongs_to :user
  belongs_to :store
  has_many :line_items, inverse_of: :invoice, dependent: :destroy
  has_many :payments, inverse_of: :invoice, dependent: :destroy
  accepts_nested_attributes_for :line_items, allow_destroy: true
  accepts_nested_attributes_for :payments, allow_destroy: true

  scope :by_carrier, -> carrier_id { where(:carrier_id => carrier_id) }
  scope :by_sku, -> sku { where(:sku => sku) }
  scope :by_description, -> description { basic_search(description: description) }
  scope :by_on_hand, -> quantity { basic_search(quantity: quantity) }
  scope :by_serial, -> serial_number { basic_search(serial_number: serial_number) }

  validates :customer_id, :user_id, :store_id, :presence => true
end
