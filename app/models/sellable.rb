class Sellable < ApplicationRecord
  belongs_to :category
  belongs_to :carrier
  has_many :line_items
  has_many :serialized_items
  has_many :simple_items

	scope :by_category, -> category_id { where(:category_id => category_id) }
	scope :by_carrier, -> carrier_id { where(:carrier_id => carrier_id) }
	scope :by_sku, -> sku { where(:sku => sku) }
	scope :by_description, -> description { basic_search(description: description) }

  validates :sku, :category_id, :retail_price, :taxable_price, :presence => true
  validates_uniqueness_of :sku
end
