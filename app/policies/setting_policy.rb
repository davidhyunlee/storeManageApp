class SettingPolicy < ApplicationPolicy
	def index?
		true
	end

	def update?
		true
	end
  class Scope < Scope
    def resolve
      scope
    end
  end
end
