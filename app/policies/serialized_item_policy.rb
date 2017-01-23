class SerializedItemPolicy < ApplicationPolicy
	def destroy?
		@current_user.superuser?
	end

	def edit?
		@current_user.superuser?
	end

	def update?
		@current_user.superuser?
	end

	def sold?
		@current_user.employee_accessible
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
