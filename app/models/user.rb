class User < ApplicationRecord
	enum role: [:employee, :lead, :manager, :superuser]
	after_initialize :set_default_role, :if => :new_record?

	has_secure_password

	has_many :serialized_items

	def set_default_role
		# if it already exists it's self.role, if it doesn't exist, it's user.
		self.role ||= :employee
	end

	def is_manager?
		if self.role == :superuser || self.role == :manager
			return true
		else
			return false
		end
	end
end
