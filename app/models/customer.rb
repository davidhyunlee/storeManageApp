class Customer < ApplicationRecord
	has_many :payments
	has_many :numbers, inverse_of: :customer, dependent: :destroy
	has_many :invoices, inverse_of: :customer
	accepts_nested_attributes_for :numbers, allow_destroy: true, reject_if: :all_blank
	before_save :downcase_name
	belongs_to :store

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

	def full_name
		fullname = ""
		fullname << self.first_name.titleize if self.first_name
		fullname << " #{self.middle_name.titleize}" if self.middle_name != ""
		fullname << " #{self.last_name.titleize}" if self.last_name
		return fullname
	end

	def full_name_lmf
		fullname = ""
		fullname << "#{self.last_name.titleize}," if self.last_name
		fullname << " #{self.first_name.titleize}" if self.first_name
		fullname << " #{self.middle_name.titleize}" if self.middle_name != ""
		return fullname
	end

	def downcase_name
		self.first_name.downcase! if self.first_name
		self.middle_name.downcase! if self.middle_name
		self.last_name.downcase! if self.last_name
		self.email.downcase! if self.email
	end
end
