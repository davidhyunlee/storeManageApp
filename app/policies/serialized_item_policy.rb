class SerializedItemPolicy < ApplicationPolicy
	def destroy?
		@current_user.superuser?
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
