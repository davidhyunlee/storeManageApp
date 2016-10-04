class SimpleItem < ApplicationRecord
  belongs_to :store
  belongs_to :sellable
end
