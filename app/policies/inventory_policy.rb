class InventoryPolicy < Struct.new(:user, :inventory)
	def receive?
		true
	end

	def add_serialized_to_queue?
		true
	end

	def save?
		true
	end

	def search?
		true
	end

  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end
end
