class PagePolicy < Struct.new(:user, :page)
  def dashboard?
  	true if user
  end

  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end
end
