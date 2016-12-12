class PaymentPolicy < ApplicationPolicy
	def new?
		@current_user.employee_accessible
	end

	def create?
		@current_user.employee_accessible
	end

	def edit?
		@current_user.superuser?
	end

	def show?
		@current_user.employee_accessible
	end

	def index?
		@current_user.employee_accessible
	end

	def update?
		@current_user.superuser?
	end

	def destroy?
		@current_user.superuser?
	end

	def carrier_and_payment_types?
		@current_user.employee_accessible
	end

	def verify?
		@current_user.employee_accessible
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
