class Payment < ApplicationRecord
  belongs_to :invoice
  belongs_to :store
  belongs_to :customer
  belongs_to :carrier
  belongs_to :user
  belongs_to :number
end
