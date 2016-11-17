class InvoicePolicy < ApplicationPolicy
	def index?
		true
	end

	def new?
		true
	end

	def create?
		true
	end

	def edit?
		true
	end

	def update?
		true
	end

	def show?
		true
	end

	def destroy?
		true
	end

	def add_serialized_line_item?
		true
	end

	def add_simple_line_item?
		true
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
