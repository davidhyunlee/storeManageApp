class InvoicePolicy < ApplicationPolicy
	def index
		true
	end

	def new
		true
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
