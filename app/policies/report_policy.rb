class ReportPolicy < ApplicationPolicy
	def sales?
		true
	end

	def payments?
		true
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
