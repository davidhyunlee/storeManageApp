class SaleTypePolicy < ApplicationPolicy
	
	def index?
		@current_user.superuser?
	end

	def new?
		@current_user.superuser?
	end

	def edit?
		@current_user.superuser?
	end

	def destroy?
		@current_user.superuser?
	end		

	def create?
		@current_user.superuser?
	end

	def show?
		@current_user.superuser?
	end

	def update?
		@current_user.superuser?
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
