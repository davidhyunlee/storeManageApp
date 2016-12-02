class Store < ApplicationRecord
	has_many :simple_items
	has_many :serialized_items
	has_many :invoices
	has_many :payments
end
