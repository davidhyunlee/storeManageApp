class SessionsController < ApplicationController
  layout "login", only: :new

	def new
    # redirect_to dashboard_path if current_user
    @stores = Store.all
    authorize :session, :new?
  end

  def create
    if params[:store_id] == ""
      redirect_to root_path and return
    end
    user = User.find_by_email(params[:email])
    authorize :session, :create?
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      session[:store_id] = params[:store_id]
      redirect_to '/dashboard'
    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
    authorize :session, :destroy?
  end
end