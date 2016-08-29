class SerializedItem < ApplicationRecord
  belongs_to :store
  belongs_to :received_item
  belongs_to :sellable

  def sold
  	self.quantity = 4
  	self.save
  end

  def available?
  	if self.quantity == 1
  		return true
  	else
  		return false
  	end
  end
end
