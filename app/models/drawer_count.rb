class DrawerCount < ApplicationRecord
	has_many :card_receipts, inverse_of: :drawer_count
	accepts_nested_attributes_for :card_receipts, allow_destroy: true, reject_if: :all_blank
end
