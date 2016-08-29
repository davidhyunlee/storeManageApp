class Number < ApplicationRecord
  belongs_to :customer
  belongs_to :carrier
end
