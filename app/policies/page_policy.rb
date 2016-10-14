class PagePolicy < Struct.new(:user, :page)
  def dashboard?
  	true if user || user.role?
  end

  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end
end
