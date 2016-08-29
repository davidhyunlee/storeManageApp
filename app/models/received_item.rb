class ReceivedItem < ApplicationRecord
  belongs_to :store
  belongs_to :user
  belongs_to :sellable
end
