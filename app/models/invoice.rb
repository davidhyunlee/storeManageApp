class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :user
  belongs_to :store
end
