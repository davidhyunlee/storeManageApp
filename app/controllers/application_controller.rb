class ApplicationController < ActionController::Base
  include Pundit
  before_action :require_login
  after_action :verify_authorized
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_store
  	@current_store ||= Store.find(session[:store_id]) if session[:store_id]
  end

  def set_store(store_id)
  	session[:store_id] = store_id
  end

  helper_method :current_user, :current_store, :set_store

  def require_login
    redirect_to '/login' unless current_user
  end

  private

    def user_not_authorized
      flash[:warning] = "Access denied."
      redirect_to root_path if !current_user
      redirect_to (request.referrer || dashboard_path) if current_user
    end
end
