class Customer < ApplicationRecord
	has_many :payments
	has_many :numbers, inverse_of: :customer, dependent: :destroy
	has_many :invoices, inverse_of: :customer
	accepts_nested_attributes_for :numbers, allow_destroy: true, reject_if: :all_blank
	before_save :downcase_name

	validates :first_name, :last_name, :presence => true

  def days_until_birthday
    bday = Date.new(Date.today.year, dob.month, dob.day) if dob
    bday += 1.year if Date.today >= bday if dob
    (bday - Date.today).to_i if dob
  end

  def age
  	now = Time.now.utc.to_date
  	now.year - self.dob.year - ((now.month > self.dob.month || (now.month == self.dob.month && now.day >= self.dob.day)) ? 0 : 1) if self.dob
	end

	def downcase_name
		self.first_name.downcase!
		self.middle_name.downcase!
		self.last_name.downcase!
	end
end
