class Number < ApplicationRecord
  belongs_to :customer, inverse_of: :numbers
  belongs_to :carrier, inverse_of: :numbers

  validates_presence_of :carrier_id
  validates :number, :length => { :is => 10 }
end
