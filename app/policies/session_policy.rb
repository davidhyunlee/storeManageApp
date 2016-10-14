class SessionPolicy < Struct.new(:user, :session)
	def new?
		true
	end

	def create?
		true
	end

	def destroy?
		true
	end
	
  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end
end
