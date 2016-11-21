class SettingPolicy < ApplicationPolicy
	def index?
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
