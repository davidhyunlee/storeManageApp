class CategoryPolicy < ApplicationPolicy
	def index?
		@current_user.superuser?
	end

	def new?
		@current_user.superuser?
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
