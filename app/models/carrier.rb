class Carrier < ApplicationRecord
  has_many :numbers, inverse_of: :carrier
end
