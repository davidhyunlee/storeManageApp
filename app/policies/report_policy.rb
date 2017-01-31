class ReportPolicy < ApplicationPolicy
	def sales?
		@current_user.employee_accessible
	end

	def payments?
		@current_user.employee_accessible
	end

	def performance?
		@current_user.superuser?
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
