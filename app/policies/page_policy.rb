class PagePolicy < Struct.new(:user, :page)

  def dashboard?
  	@current_user.superuser?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
