class SellablePolicy < ApplicationPolicy
	def index?
		@current_user.employee_accessible
	end

	def new?
		@current_user.manager_accessible
	end

	def edit?
		@current_user.manager_accessible
	end

	def create?
		@current_user.manager_accessible
	end

	def update?
		@current_user.manager_accessible
	end

	def show?
		@current_user.manager_accessible
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
