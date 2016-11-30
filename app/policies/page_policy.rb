class PagePolicy < Struct.new(:user, :page)
  def dashboard?
  	true if user
  end

  def select_store?
  	user.superuser?
  end

  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end
end
