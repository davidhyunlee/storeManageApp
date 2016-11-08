class InventoryPolicy < Struct.new(:user, :inventory)
	def receive?
		true
	end

	def add_serialized_to_queue?
		true
	end

	def add_sellable_to_queue?
		true
	end

	def save?
		true
	end

	def search?
		true
	end

	def index?
		true
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