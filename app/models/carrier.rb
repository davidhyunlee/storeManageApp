class Carrier < ApplicationRecord
  has_many :numbers, inverse_of: :carrier
  has_many :payment_types, inverse_of: :carrier
end
