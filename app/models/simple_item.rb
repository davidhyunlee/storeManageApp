class SimpleItem < ApplicationRecord
  belongs_to :store
  belongs_to :sellable
  has_many :line_items, inverse_of: :simple_item

  delegate :carrier_id, :to => :sellable

  scope :by_sku, lambda { |id| joins(:sellable).where(:sellables => {:sku => id}) }
  scope :by_description, lambda { |id| joins(:sellable).basic_search(:sellables => {:description => id}) }

  validates :sellable_id, :quantity, :store_id, presence: true
end
