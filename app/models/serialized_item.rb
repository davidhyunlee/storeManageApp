class SerializedItem < ApplicationRecord
  belongs_to :store
  belongs_to :received_item
  belongs_to :sellable
end
