class LineItem < ApplicationRecord
  belongs_to :invoice, inverse_of: :line_items
  belongs_to :sellable, inverse_of: :line_items
  belongs_to :serialized_item, inverse_of: :line_items
  belongs_to :simple_item, inverse_of: :line_items
  belongs_to :plan, inverse_of: :line_items
  belongs_to :payment, inverse_of: :line_items
  belongs_to :sale_type, inverse_of: :line_items

  after_create :adjust_quantity

	def adjust_quantity
		item = SerializedItem.find(self.serialized_item.id) if self.serialized_item
		item = SimpleItem.find(self.simple_item.id) if self.simple_item
		item.quantity -= self.quantity if item
		if item
			if item.save
				item.lock if item.class == SerializedItem
			else
			end
		end
	end

end
