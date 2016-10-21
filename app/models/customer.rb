class Customer < ApplicationRecord
	has_many :payments
	has_many :numbers, inverse_of: :customer, dependent: :destroy
	has_many :invoices, inverse_of: :customer
	accepts_nested_attributes_for :numbers, allow_destroy: true

	validates :first_name, :last_name, :presence => true

	def days_until_birthday
    bday = Date.new(Date.today.year, dob.month, dob.day)
    bday += 1.year if Date.today >= bday
    (bday - Date.today).to_i
  end

  def age
  	now = Time.now.utc.to_date
  	now.year - self.dob.year - ((now.month > self.dob.month || (now.month == self.dob.month && now.day >= self.dob.day)) ? 0 : 1)
	end
end
