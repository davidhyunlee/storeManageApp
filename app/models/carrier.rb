class Carrier < ApplicationRecord
  has_many :mobile_numbers, inverse_of: :carrier
end
