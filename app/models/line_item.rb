class LineItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :sellable
  belongs_to :serialized_item
  belongs_to :simple_item

  after_create :adjust_quantity

	def adjust_quantity
		item = SerializedItem.find(self.serialized_item.id) if self.serialized_item
		item = SimpleItem.find(self.simple_item.id) if self.simple_item
		item.quantity -= self.quantity
		if item.save
			item.lock if item.class == SerializedItem
		else

		end
	end

end
