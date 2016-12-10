class SerializedItem < ApplicationRecord
  belongs_to :store
  belongs_to :sellable, inverse_of: :serialized_items
  belongs_to :user
  has_many :line_items, inverse_of: :serialized_item

  delegate :carrier_id, :to => :sellable

  scope :by_carrier, lambda { |id| joins(:sellable).where(:sellables => {:carrier_id => id}) }
  scope :by_sku, lambda { |id| joins(:sellable).where(:sellables => {:sku => id}) }
  scope :by_description, lambda { |id| joins(:sellable).basic_search(:sellables => {:description => id}) }
  scope :by_serial, -> serial_number { basic_search(serial_number: serial_number) }

  validates :sellable_id, :user_id, :cost, :quantity, :store_id, presence: true
  validates :serial_number, uniqueness: true, presence: true, length: { minimum: 1 }

  def sold
  	self.quantity = 0
  	self.save
  end

  def available?
  	if self.quantity == 1
  		return true
  	else
      return false
  	end
  end

  def make_available
    self.quantity = 1
    self.save
  end

  def lock
    self.locked = true
    self.save
  end
end
