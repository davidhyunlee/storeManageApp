class TenantPolicy < ApplicationPolicy
	def index?
		@current_user.employee_accessible
	end

	def new?
		@current_user.employee_accessible
	end

	def edit?
		@current_user.employee_accessible
	end

	def destroy?
		@current_user.employee_accessible
	end		

	def create?
		@current_user.employee_accessible
	end

	def show?
		@current_user.employee_accessible
	end

	def update?
		@current_user.employee_accessible
	end
  class Scope < Scope
    def resolve
      scope
    end
  end
end
