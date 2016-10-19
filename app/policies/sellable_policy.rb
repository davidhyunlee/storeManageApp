class SellablePolicy < ApplicationPolicy
	def index?
		@current_user.employee? || @current_user.manager? || @current_user.superuser?
	end

	def new?
		@current_user.employee? || @current_user.manager? || @current_user.superuser?
	end

	def edit?
		@current_user.employee? || @current_user.manager? || @current_user.superuser?
	end

	def create?
		@current_user.employee? || @current_user.manager? || @current_user.superuser?
	end

	def update?
		@current_user.employee? || @current_user.manager? || @current_user.superuser?
	end

	def show?
		@current_user.employee? || @current_user.manager? || @current_user.superuser?
	end

	def destroy?
		@current_user.employee? || @current_user.manager? || @current_user.superuser?
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
