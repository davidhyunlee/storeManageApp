class CustomerPolicy < ApplicationPolicy

	def index?
		@user.employee? || @user.manager? || @user.superuser?
	end

	def new?
		@user.employee? || @user.manager? || @user.superuser?
	end

	def edit?
		@user.employee? || @user.manager? || @user.superuser?
	end

	def update?
		@user.employee? || @user.manager? || @user.superuser?
	end

	def delete?
		@user.employee? || @user.manager? || @user.superuser?
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
