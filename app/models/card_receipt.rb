class CardReceipt < ApplicationRecord
  belongs_to :drawer_count, inverse_of: :card_receipts
end
