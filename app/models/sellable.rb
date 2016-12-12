class Sellable < ApplicationRecord
  belongs_to :category
  belongs_to :carrier, inverse_of: :sellables
  has_many :line_items
  has_many :serialized_items, inverse_of: :sellable
  has_many :simple_items

	scope :by_category, -> category_id { where(:category_id => category_id) }
	scope :by_carrier, -> carrier_id { where(:carrier_id => carrier_id) }
	scope :by_sku, -> sku { where(:sku => sku) }
	scope :by_description, -> description { basic_search(description: description) }
  scope :by_price, -> price_from, price_to { where("retail_price >= ? AND retail_price <= ?", price_from, price_to) }
  scope :by_promo_price, -> price_from, price_to { where("promo_price >= ? AND promo_price <= ?", price_from, price_to) }
  scope :by_port_price, -> price_from, price_to { where("port_price >= ? AND port_price <= ?", price_from, price_to) }
  scope :by_aal_price, -> price_from, price_to { where("upgrade_aal_price >= ? AND upgrade_aal_price <= ?", price_from, price_to) }

  validates :sku, :category_id, :retail_price, :taxable_price, :presence => true
  validates :retail_price, :taxable_price, :numericality => true
  validates_uniqueness_of :sku
end
