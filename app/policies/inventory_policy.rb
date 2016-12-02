class InventoryPolicy < Struct.new(:user, :inventory)
	def receive?
		user.employee_accessible
	end

	def add_serialized_to_queue?
		user.employee_accessible
	end

	def add_sellable_to_queue?
		user.employee_accessible
	end

	def save?
		user.manager_accessible
	end

	def search?
		true
	end

	def index?
		user.employee_accessible
	end

	def inventory_list?
		true
	end

  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end
end
