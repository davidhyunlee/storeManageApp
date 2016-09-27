class LineItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :sellable
  belongs_to :serialized_item
end
