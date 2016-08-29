class Sellable < ApplicationRecord
  belongs_to :category
  belongs_to :carrier
end
