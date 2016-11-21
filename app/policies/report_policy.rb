class ReportPolicy < ApplicationPolicy
	def sales?
		@current_user.manager_accessible
	end

	def payments?
		@current_user.manager_accessible
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
