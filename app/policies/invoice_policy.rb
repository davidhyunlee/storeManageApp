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

	def add_payment_line_item?
		true
	end

	def add_plan?
		true
	end

	def add_plan_line_item?
		true
	end

	def add_item?
		true
	end

	def search_items?
		true
	end

	def search_serialized?
		true
	end

	def search_simple?
		true
	end

	def add_number?
		true
	end

	def number_details?
		true
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
