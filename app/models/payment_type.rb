class PaymentType < ApplicationRecord
	belongs_to :carrier, inverse_of: :payment_types
end
