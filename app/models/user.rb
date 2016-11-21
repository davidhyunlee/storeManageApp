class User < ApplicationRecord
	enum role: [:employee, :lead, :manager, :superuser]
	after_initialize :set_default_role, :if => :new_record?

	has_secure_password

	has_many :serialized_items

	def set_default_role
		# if it already exists it's self.role, if it doesn't exist, it's user.
		self.role ||= :employee
	end

	def manager_accessible
		if self.superuser? || self.manager?
			return true
		else
			return false
		end
	end

	def lead_accessible
		if self.superuser? || self.manager? || self.lead?
			return true
		else
			return false
		end
	end

	def employee_accessible
		if self.superuser? || self.manager? || self.lead? || self.employee?
			return true
		else
			return false
		end
	end

	def full_name
		fullname = ""
		fullname << self.first_name.titleize if self.first_name
		fullname << " #{self.middle_name.titleize}" if self.middle_name
		fullname << " #{self.last_name.titleize}" if self.last_name
		return fullname
	end

	def full_name_lmf
		fullname = ""
		fullname << "#{self.last_name.titleize}," if self.last_name
		fullname << " #{self.first_name.titleize}" if self.first_name
		fullname << " #{self.middle_name.titleize}" if self.middle_name
		return fullname
	end

end
