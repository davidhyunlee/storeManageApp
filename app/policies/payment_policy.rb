class PaymentPolicy < ApplicationPolicy
	def new?
		true
	end

	def create?
		true
	end

	def edit?
	end

	def show?
		true
	end


  class Scope < Scope
    def resolve
      scope
    end
  end
end
