class PlanPolicy < ApplicationPolicy
	def index?
		@current_user.employee_accessible
	end

	def new?
		@current_user.superuser?
	end

	def create?
		@current_user.superuser?
	end

	def show?
		@current_user.employee_accessible
	end

	def edit?
		@current_user.superuser?
	end

	def update?
		@current_user.superuser?
	end

	def destroy?
		@current_user.superuser?
	end

	def search?
		@current_user.employee_accessible
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
