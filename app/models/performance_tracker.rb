class PerformanceTracker < ApplicationRecord
  belongs_to :user
  belongs_to :invoice
  belongs_to :performance_category
end
