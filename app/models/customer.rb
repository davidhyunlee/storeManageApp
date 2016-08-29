class Customer < ApplicationRecord
	has_many :payments
	has_many :numbers, inverse_of: :customer, dependent: :destroy
	has_many :invoices, inverse_of: :customer
	accepts_nested_attributes_for :numbers, allow_destroy: true

	validates :first_name, :last_name, :presence => true
end
