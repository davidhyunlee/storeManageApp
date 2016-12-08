class Plan < ApplicationRecord
  belongs_to :carrier, inverse_of: :plans
  has_many :line_items, inverse_of: :plan

	scope :carrier, -> carrier_id { where(:carrier_id => carrier_id) }
	scope :code, -> code { where(:code => code) }
	scope :by_name, -> name { basic_search(name: name) }
	scope :by_price, -> price_from, price_to { where("price >= ? AND price <= ?", price_from, price_to) }

  validates :name, presence: true
  validates_associated :carrier
  validates :price, numericality: true
  validates :code, uniqueness: true
end
