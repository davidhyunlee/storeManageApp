class Carrier < ApplicationRecord
  has_many :numbers, inverse_of: :carrier
  has_many :payment_types, inverse_of: :carrier
  has_many :plans, inverse_of: :carrier
  has_many :sellables, inverse_of: :carrier
end
