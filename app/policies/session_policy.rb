class SessionPolicy < ApplicationPolicy
	def new?
		if @user
			redirect_to dashboard_path
		else
			true
		end
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
