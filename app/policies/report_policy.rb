class ReportPolicy < ApplicationPolicy
	def sales?
		@current_user.employee_accessible
	end

	def payments?
		@current_user.employee_accessible
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
