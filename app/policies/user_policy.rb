class UserPolicy < ApplicationPolicy
	def index?
		@current_user.superuser? if @current_user
	end

	def new?
		@current_user.superuser?
	end

	def create?
		@current_user.superuser?
	end

	def edit?
		@current_user.superuser?
	end

	def update?
		@current_user.superuser?
	end

	def destroy?
		return false if @current_user == @record
		@current_user.superuser?
	end
	
  class Scope < Scope
    def resolve
      scope
    end
  end
end
